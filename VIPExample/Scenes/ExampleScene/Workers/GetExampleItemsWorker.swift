import Foundation

struct ExampleItem {
    let name: String
    let description: String
    let fullDescription: String
}

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
