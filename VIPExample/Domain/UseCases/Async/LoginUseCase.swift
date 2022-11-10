import Foundation

enum LoginUseCaseError: Error {
    case serviceError(Error)
}

protocol LoginUseCaseProtocol {
    func execute(
        _ input: User,
        completion: @escaping (Result<User, LoginUseCaseError>) -> Void
    )
}

struct LoginUseCase: LoginUseCaseProtocol {
    private let loginService: LoginServiceProtocol
    
    init(loginService: LoginServiceProtocol) {
        self.loginService = loginService
    }
    
    func execute(
        _ input: User,
        completion: @escaping (Result<User, LoginUseCaseError>) -> Void
    ) {
        loginService.doLogin(for: input) { result in
            switch result {
            case .success:
                completion(.success(input))
            case let .failure(error):
                completion(.failure(.serviceError(error)))
            }
        }
    }
}

// Example Helpers
struct User {}

protocol LoginServiceProtocol {
    func doLogin(
        for: User,
        completion: @escaping (Result<Void, Error>) -> Void
    )
}
