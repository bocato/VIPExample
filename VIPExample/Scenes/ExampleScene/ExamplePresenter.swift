import UIKit

final class ExamplePresenter: ExamplePresenterProtocol, ExampleInteractorOutputProtocol {
    // MARK: - Dependencies
    
    weak var viewController: ExampleViewControllerProtocol?
    var interactor: ExampleInteractorInputProtocol?
    var router: ExampleRouterProtocol?
    
    // MARK: - ExamplePresenterProtocol
    
    func viewDidLoad() {
        interactor?.loadExampleItemsList()
    }
    
    func selectExampleItemAtIndex(_ index: Int) {
        interactor?.selectExampleItemAtIndex(index)
    }
    
    // MARK: - ExampleInteractorOutputProtocol
    
    func presentExampleItemsList(_ items: [ExampleItem]) {
        let listItems: [ListItem] = items.map {
            .init(
                title: $0.name.capitalized,
                description: $0.fullDescription
            )
        }
        viewController?.displayExampleItems(listItems)
    }
    
    func presentExampleItemsListError(_ error: Error) {
        let alertData: AlertData = .init(
            title: "Error",
            message: "Could not load example items."
        )
        router?.routeToErrorAlert(alertData)
    }
    
    func presentSelectedItem(_ item: ExampleItem) {
        router?.routeToSelectedItem(
            item,
            onDismiss: { [interactor] in
                interactor?.deselectExampleItem(item)
            }
        )
    }
}
