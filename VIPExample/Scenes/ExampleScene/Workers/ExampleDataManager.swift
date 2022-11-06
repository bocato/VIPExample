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

enum ExampleDataManagerError: Error {
    case oops
}

protocol ExampleDataManagerProtocol {
    func fetchItems(
        then completion: @escaping (Result<[ExampleItem], ExampleDataManagerError>) -> Void
    )
}

struct ExampleDataManager: ExampleDataManagerProtocol {
    private let itemsService: ItemsServiceProtocol
    
    init(itemsService: ItemsServiceProtocol) {
        self.itemsService = itemsService
    }
    
    func fetchItems(
        then completion: @escaping (Result<[ExampleItem], ExampleDataManagerError>) -> Void
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
