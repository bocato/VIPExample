import Foundation
import Combine

struct RegistrationRequest {
    let username: String
    let password: String
    let otherData: [String: String]
}

enum UserRegistrationWorkerError: Swift.Error {
    case invalidUser
    case weakPassword
    case registrationFailed(Error)
    case loginFailed
    case unexpected
}

protocol UserRegistrationWorkerProtocol {
    func performRegistration(
        _ request: RegistrationRequest
    ) -> AnyPublisher<Void, UserRegistrationWorkerError>
}

struct UserRegistrationWorker: UserRegistrationWorkerProtocol {
    // MARK: - Dependencies
    
    private let verifyPasswordStrenghtUseCase: VerifyPasswordStrenghtUseCaseProtocol
    private let validateUserNameUseCase: ValidateUserNameUseCaseProtocol
    private let userService: UserServiceProtocol
    private let storeTokenUseCase: StoreTokenUseCaseProtocol
    
    // MARK: - Initialization
    
    init(
        verifyPasswordStrenghtUseCase: VerifyPasswordStrenghtUseCaseProtocol,
        validateUserNameUseCase: ValidateUserNameUseCaseProtocol,
        userService: UserServiceProtocol,
        storeTokenUseCase: StoreTokenUseCaseProtocol
    ) {
        self.verifyPasswordStrenghtUseCase = verifyPasswordStrenghtUseCase
        self.validateUserNameUseCase = validateUserNameUseCase
        self.userService = userService
        self.storeTokenUseCase = storeTokenUseCase
    }
    
    func performRegistration(
        _ request: RegistrationRequest
    ) -> AnyPublisher<Void, UserRegistrationWorkerError> {
        return Future<Void, UserRegistrationWorkerError> { promise in
            let passwordStrenght = verifyPasswordStrenghtUseCase.execute(request.password)
            guard passwordStrenght >= 5 else {
                promise(.failure(.weakPassword))
                return
            }
            let isUserValid = validateUserNameUseCase.execute(request.username)
            guard isUserValid else {
                promise(.failure(.invalidUser))
                return
            }
        }
        .flatMap { [userService] _ in
            userService.registerUser(
                username: request.username,
                password: request.password,
                otherData: request.otherData
            )
            .mapError { UserRegistrationWorkerError.registrationFailed($0) }
            .flatMap {
                userService.performLogin(
                    username: request.username,
                    password: request.password
                )
                .tryMap { [storeTokenUseCase] token -> Void in
                    let isTokenValid = token.isEmpty == false
                    guard isTokenValid else {
                        throw UserRegistrationWorkerError.loginFailed
                    }
                    try? storeTokenUseCase.execute(token) // Here we don't care about the error 😅
                    return ()
                }
                .mapError { _ in  UserRegistrationWorkerError.loginFailed }
            }
        }
        .eraseToAnyPublisher()
    }
}


// Supporting elements for the example
protocol VerifyPasswordStrenghtUseCaseProtocol {
    typealias Input = String
    typealias Output = Int
    func execute(_ input: Input) -> Output
}

protocol ValidateUserNameUseCaseProtocol {
    typealias Input = String
    typealias Output = Bool
    func execute(_ input: Input) -> Output
}

protocol StoreTokenUseCaseProtocol {
    typealias Input = String
    typealias Output = NSError
    func execute(_ input: String) throws -> Void
}

protocol UserServiceProtocol {
    func registerUser(
        username: String,
        password: String,
        otherData: [String: String]
    ) -> AnyPublisher<Void, Error>
    
    func performLogin(
        username: String,
        password: String
    ) -> AnyPublisher<String, Error>
}
