import Foundation

enum ItemsServiceError: Error {
    case serialization(_ error: Error)
}

protocol ItemsServiceProtocol {
    func getItems(then: @escaping (Result<[ItemEntity], ItemsServiceError>) -> Void)
}

struct ItemsService: ItemsServiceProtocol {
    // Simulating a service...
    func getItems(then: @escaping (Result<[ItemEntity], ItemsServiceError>) -> Void) {
        let jsonData = """
                    [
                        {
                            "id": 1,
                            "name": "Item 1",
                            "simpleDescription": "I'm Item 1.",
                            "fullDescription": "I'm the great Item 1's FULL description."
                        },
                        {
                            "id": 2,
                            "name": "Item 2",
                            "simpleDescription": "I'm Item 2.",
                            "fullDescription": "I'm the great Item 2's FULL description."
                        },
                        {
                            "id": 3,
                            "name": "Item 3",
                            "simpleDescription": "I'm Item 3.",
                            "fullDescription": "I'm the great Item 3's FULL description."
                        }
                    ]
        """.data(using: .utf8)!
        do {
            let value = try JSONDecoder().decode([ItemEntity].self, from: jsonData)
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                then(.success(value))
            }
        } catch {
            then(.failure(.serialization(error)))
        }
    }    
}
