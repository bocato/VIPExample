import Foundation

protocol ExampleBusinessLogic {
    func loadExampleItemsList(_ request: ExampleScene.List.Request)
    func selectExampleItem(_ request: ExampleScene.Selection.Request)
}

protocol ExampleDataStore {
    var selectedItem: ExampleItem? { get set }
}

final class ExampleInteractor: ExampleBusinessLogic, ExampleDataStore {
    
    // MARK: - Dependencies
    
    private let presenter: ExamplePresentationLogic
    private let getExampleItemsWorker: GetExampleItemsWorkerProtocol
    
    // MARK: - Private Properties
    
    private var exampleItems = [ExampleItem]()
    var selectedItem: ExampleItem?
    
    // MARK: - Initialization
    
    init(
        presenter: ExamplePresentationLogic,
        getExampleItemsWorker: GetExampleItemsWorkerProtocol
    ) {
        self.presenter = presenter
        self.getExampleItemsWorker = getExampleItemsWorker
    }
    
    // MARK: - ExampleBusinessLogic
    
    func loadExampleItemsList(_ request: ExampleScene.List.Request) {
        getExampleItemsWorker.fetchItems { [weak self] result in
            switch result {
            case let .success(items):
                self?.exampleItems = items
                let request: ExampleScene.List.Response = .init(
                    items: items
                )
                self?.presenter.presentExampleItemsList(request)
            case let .failure(error):
                self?.presenter.presentExampleItemsListError(error)
            }
        }
    }
    
    func selectExampleItem(_ request: ExampleScene.Selection.Request) {
        let selectedItem = exampleItems[request.index]
        let response: ExampleScene.Selection.Response = selectedItem
        self.selectedItem = selectedItem
        presenter.presentExampleItemsSelection(response)
    }
}
