import Foundation

struct ExampleItem: Equatable {
    let name: String
    let description: String
    let fullDescription: String
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

enum GetExampleItemsError: Error {
    case oops
}

protocol GetExampleItemsWorkerProtocol {
    func fetchItems(
        then completion: @escaping (Result<[ExampleItem], GetExampleItemsError>) -> Void
    )
}

struct GetExampleItemsWorker: GetExampleItemsWorkerProtocol {
    private let itemsService: ItemsServiceProtocol
    
    init(itemsService: ItemsServiceProtocol) {
        self.itemsService = itemsService
    }
    
    func fetchItems(
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
