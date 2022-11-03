import Foundation
import UIKit

protocol ExampleRoutingLogic: AnyObject {
    func routeToErrorAlert(_ data: ExampleScene.AlertData)
    func routeToSelectedItem()
}

protocol ExampleDataPassing: AnyObject {
    var dataStore: ExampleDataStore? { get set }
}

final class ExampleRouter: ExampleRoutingLogic, ExampleDataPassing {
    // MARK: - Dependencies
    
    typealias ViewController = UIViewController
    private weak var viewController: ViewController!
    
    // MARK: - Properties
    
    var dataStore: ExampleDataStore?
    
    // MARK: - Initialization
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    // MARK: - ExampleRoutingLogic
    
    func routeToErrorAlert(_ data: ExampleScene.AlertData) {
        let alertController = UIAlertController(
            title: data.title,
            message: data.message,
            preferredStyle: .alert
        )
        let okAction: UIAlertAction = .init(
            title: "OK",
            style: .default,
            handler: nil
        )
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true)
    }
    
    func routeToSelectedItem() {
        guard let selectedItem = dataStore?.selectedItem else { return }
        let data: ExampleScene.AlertData = .init(
            title: selectedItem.name,
            message: selectedItem.fullDescription
        )
        let alertController = UIAlertController(
            title: data.title,
            message: data.message,
            preferredStyle: .alert
        )
        let okAction: UIAlertAction = .init(
            title: "OK",
            style: .default,
            handler: { [weak self] _ in
                self?.dataStore?.selectedItem = nil
            }
        )
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true)
    }
}
