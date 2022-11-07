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
    
    struct AlertData: Equatable {
        let title: String
        let message: String
    }
}

#if DEBUG
extension ExampleScene.List.ViewModel.Item {
    static func fixture(
        title: String = "title",
        description: String = "description"
    ) -> Self {
        .init(title: title, description: description)
    }
}

#endif
