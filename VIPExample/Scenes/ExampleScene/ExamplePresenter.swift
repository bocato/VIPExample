import UIKit

protocol ExamplePresentationLogic {
    func presentExampleItemsList(_ response: ExampleScene.List.Response)
    func presentExampleItemsListError(_ response: ExampleScene.Error)
    func presentExampleItemsSelection(_ response: ExampleScene.Selection.Response)
}

final class ExamplePresenter: ExamplePresentationLogic {
    // MARK: - Private Properties
    
    weak var viewController: ExampleViewDisplayLogic?
    
    // MARK: - ExamplePresentationLogic
    
    func presentExampleItemsList(_ response: ExampleScene.List.Response) {
        let presentedItems = response.items.map {
            ExampleScene.List.ViewModel.Item(
                title: $0.name.capitalized,
                description: $0.fullDescription
            )
        }
        let viewModel = ExampleScene.List.ViewModel(items: presentedItems)
        viewController?.displayExampleItems(viewModel)
    }
    
    func presentExampleItemsListError(_ response: ExampleScene.Error) {
        let errorModel = ExampleScene.List.Error(
            title: "Error",
            message: "Could not load example items."
        )
        viewController?.displayExampleItemsError(errorModel)
    }
    
    func presentExampleItemsSelection(_ response: ExampleScene.Selection.Response) {
        viewController?.displayExampleItemsSelection()
    }
    
}
