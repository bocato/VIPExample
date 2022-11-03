import Foundation

// MARK: - Models
enum ExampleScene {
    enum List {
        struct Request {}
        struct Response {
            let items: [ExampleItem]
        }
        struct ViewModel {
            let items: [Item]
            struct Item {
                let title: String
                let description: String
            }
        }
        typealias Error = AlertData
    }
    
    enum Selection {
        struct Request {
            let index: Int
        }
        typealias Response = ExampleItem
        struct ViewModel {}
    }

    // Common
    
    typealias Error = Swift.Error
    
    struct AlertData {
        let title: String
        let message: String
    }
}
