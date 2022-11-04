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

#if DEBUG
import XCTestDynamicOverlay

struct ExamplePresentationFailing: ExamplePresentationLogic {
    func presentExampleItemsList(_ response: ExampleScene.List.Response) {
        XCTFail("presentExampleItemsList was not implemented.")
    }
    
    func presentExampleItemsListError(_ response: ExampleScene.Error) {
        XCTFail("presentExampleItemsListError was not implemented.")
    }
    
    func presentExampleItemsSelection(_ response: ExampleScene.Selection.Response) {
        XCTFail("presentExampleItemsSelection was not implemented.")
    }
}

final class ExamplePresentationSpy: ExamplePresentationLogic {
    private(set) var presentExampleItemsListCalled = false
    private(set) var presentExampleItemsListResponsePassed: ExampleScene.List.Response?
    func presentExampleItemsList(_ response: ExampleScene.List.Response) {
        presentExampleItemsListCalled = true
        presentExampleItemsListResponsePassed = response
    }

    func presentExampleItemsListError(_ response: ExampleScene.Error) {
        XCTFail("presentExampleItemsListError was not implemented.")
    }

    func presentExampleItemsSelection(_ response: ExampleScene.Selection.Response) {
        XCTFail("presentExampleItemsSelection was not implemented.")
    }
}
#endif
