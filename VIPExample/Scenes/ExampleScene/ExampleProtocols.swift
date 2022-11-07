import UIKit

// Full Cycle
// ViewController -> Presenter -> Interactor -> Presenter -> ViewController
// ViewController -> Presenter -> Interactor -> Presenter -> Router -> Outside World

// MARK: - Protocols

protocol ExampleViewControllerProtocol: AnyObject {
    var presenter: ExamplePresenterProtocol? { get set } // User Inputs: ViewController -> Presenter
    func displayExampleItems(_ items: [ListItem]) // DisplayLogic: Presenter -> ViewController
}

protocol ExamplePresenterProtocol: AnyObject {
    var viewController: ExampleViewControllerProtocol? { get set } // DisplayLogic: Presenter -> ViewController
    var interactor: ExampleInteractorInputProtocol? { get set } // BusinessLogic: Presenter -> Interactor
    var router: ExampleRouterProtocol? { get set } // RoutingLogic: Presenter -> Outside World
    
    func viewDidLoad()
    func selectExampleItemAtIndex(_ index: Int)
}

protocol ExampleInteractorInputProtocol: AnyObject {
    var presenter: ExampleInteractorOutputProtocol? { get set } // BusinessLogic: Presenter -> Interactor
    
    func loadExampleItemsList()
    func selectExampleItemAtIndex(_ index: Int)
    func deselectExampleItem(_ item: ExampleItem)
}

protocol ExampleInteractorOutputProtocol: AnyObject { // BusinessLogic:  Interactor -> Presenter
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
