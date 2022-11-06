import UIKit

// MARK: - Protocols

protocol ExampleViewControllerProtocol: AnyObject {
    var presenter: ExamplePresenterProtocol? { get set }
    func displayExampleItems(_ items: [ListItem])
}

protocol ExamplePresenterProtocol: AnyObject {
    var viewController: ExampleViewControllerProtocol? { get set }
    var interactor: ExampleInteractorInputProtocol? { get set }
    var router: ExampleRouterProtocol? { get set }
    
    func viewDidLoad()
    func selectExampleItemAtIndex(_ index: Int)
}

protocol ExampleInteractorInputProtocol: AnyObject {
    var presenter: ExampleInteractorOutputProtocol? { get set }
    
    func loadExampleItemsList()
    func selectExampleItemAtIndex(_ index: Int)
    func deselectExampleItem(_ item: ExampleItem)
}

protocol ExampleInteractorOutputProtocol: AnyObject {
    func presentExampleItemsList(_ items: [ExampleItem])
    func presentExampleItemsListError(_ error: Error)
    func presentSelectedItem(_ item: ExampleItem)
}

protocol ExampleRouterProtocol: AnyObject {
    func routeToErrorAlert(_ data: AlertData)
    func routeToSelectedItem(
        _ item: ExampleItem,
        onDismiss: @escaping () -> Void
    )
    static func makeExampleModule(
        dependencyResolver: Resolver
    ) -> UIViewController
}

// MARK: - Models

struct ListItem {
    let title: String
    let description: String
}

struct AlertData: Equatable {
    let title: String
    let message: String
}
