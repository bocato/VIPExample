import Foundation
import Services

public struct ExampleItem: Equatable {
    public let name: String
    public let description: String
    public let fullDescription: String
}

#if DEBUG
extension ExampleItem {
    static func fixture(
        name: String = "name",
        description: String = "description",
        fullDescription: String = "fullDescription"
    ) -> Self {
        .init(
            name: name,
            description: description,
            fullDescription: fullDescription
        )
    }
}
#endif

public enum GetExampleItemsError: Error {
    case oops
}

public protocol GetExampleItemsWorkerProtocol {
    func fetchItems(
        then completion: @escaping (Result<[ExampleItem], GetExampleItemsError>) -> Void
    )
}

public struct GetExampleItemsWorker: GetExampleItemsWorkerProtocol {
    private let itemsService: ItemsServiceProtocol
    
    public init(itemsService: ItemsServiceProtocol) {
        self.itemsService = itemsService
    }
    
    public func fetchItems(
        then completion: @escaping (Result<[ExampleItem], GetExampleItemsError>) -> Void
    ) {
        itemsService.getItems { result in
            do {
                let items: [ExampleItem] = try result
                    .get()
                    .map {
                        .init(
                            name: $0.name,
                            description: $0.simpleDescription,
                            fullDescription: $0.fullDescription
                        )
                    }
                completion(.success(items))
            } catch {
                print(error)
                completion(.failure(.oops))
            }
        }
    }
}

#if DEBUG
import XCTestDynamicOverlay

struct GetExampleItemsWorkerFailing: GetExampleItemsWorkerProtocol {
    func fetchItems(
        then completion: @escaping (Result<[ExampleItem], GetExampleItemsError>) -> Void
    ) {
        XCTFail("fetchItems was not implemented.")
    }
}

final class GetExampleItemsWorkerStub: GetExampleItemsWorkerProtocol{
    var resultToBeReturned: Result<[ExampleItem], GetExampleItemsError> = .failure(.oops)
    func fetchItems(
        then completion: @escaping (Result<[ExampleItem], GetExampleItemsError>) -> Void
    ) {
        completion(resultToBeReturned)
    }
}
#endif
