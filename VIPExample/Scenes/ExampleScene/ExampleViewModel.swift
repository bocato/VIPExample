import Foundation

protocol ExampleViewModelDelegate: AnyObject {
    func listDataDidFinishLoading()
    func itemsServiceErrorDidFail(_ error: ItemsServiceError)
    func shouldPresentSelectedItem(_ item: ItemViewData)
}

final class ExampleViewModel {
    // MARK: - Dependencies
    
    private let itemsService: ItemsServiceProtocol
    weak var delegate: ExampleViewModelDelegate?
    
    // MARK: - Properties
    
    private var backendItems: [ItemEntity] = []
    var items: [ItemViewData] {
        backendItems.map {
            .init(
                title: $0.name,
                description: $0.fullDescription
            )
        }
    }
    
    // MARK: - Initialization
    
    init(itemsService: ItemsServiceProtocol) {
        self.itemsService = itemsService
    }
    
    func loadExampleItemsList() {
        itemsService.getItems { [weak self] result in
            switch result {
            case let .success(data):
                self?.backendItems = data
                self?.delegate?.listDataDidFinishLoading()
                
            case let .failure(error):
                self?.delegate?.itemsServiceErrorDidFail(error)
            }
        }
    }
    
    func selectExampleItemAtIndex(_ index: Int) {
        let selectedItem = items[index]
        delegate?.shouldPresentSelectedItem(selectedItem)
    }
}

// MARK: - Helper Models

struct AlertData {
    let title: String
    let message: String
}

struct ItemViewData {
    let title: String
    let description: String
}
