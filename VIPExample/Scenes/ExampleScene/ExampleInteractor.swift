import Foundation

//protocol ExampleDataStore {
//    var selectedItem: ExampleItem? { get set }
//}

final class ExampleInteractor: ExampleInteractorInputProtocol {
    
    // MARK: - Dependencies
    
    private let dataManager: ExampleDataManagerProtocol
    var presenter: ExampleInteractorOutputProtocol?
    
    // MARK: - Private Properties
    
    private var exampleItems = [ExampleItem]()
    var selectedItem: ExampleItem?
    
    // MARK: - Initialization
    
    init(dataManager: ExampleDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    // MARK: - ExampleBusinessLogic

    func loadExampleItemsList() {
        dataManager.fetchItems { [weak self] result in
            switch result {
            case let .success(items):
                self?.exampleItems = items
                self?.presenter?.presentExampleItemsList(items)
            case let .failure(error):
                self?.presenter?.presentExampleItemsListError(error)
            }
        }
    }
    
    func selectExampleItemAtIndex(_ index: Int) {
        let selectedItem = exampleItems[index]
        self.selectedItem = selectedItem
        presenter?.presentSelectedItem(selectedItem)
    }
    
    func deselectExampleItem(_ item: ExampleItem) {
        guard selectedItem == item else { return }
        selectedItem = nil
    }
}
