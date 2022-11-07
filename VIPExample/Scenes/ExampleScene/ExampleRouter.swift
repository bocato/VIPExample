import Foundation
import UIKit

final class ExampleRouter: ExampleRouterProtocol {
    
    // MARK: - Dependencies
    
    typealias ViewController = UIViewController
    private weak var viewController: ViewController!
    private let makeAlertBuilder: () -> AlertBuilding
    
    // MARK: - Initialization

    init(
        viewController: ViewController,
        makeAlertBuilder: @escaping () -> AlertBuilding = AlertBuilder.init
    ) {
        self.viewController = viewController
        self.makeAlertBuilder = makeAlertBuilder
    }

    // MARK: - ExampleRoutingLogic

    func routeToErrorAlert(_ data: AlertData) {
        let alertController = makeOKAlert(with: data)
        viewController.present(alertController, animated: true)
    }
    
    func routeToSelectedItem(_ item: ExampleItem, onDismiss: @escaping () -> Void) {
        let alertData: AlertData = .init(
            title: item.name,
            message: item.fullDescription
        )
        let alertController = makeOKAlert(
            with: alertData,
            okActionHandler: onDismiss
        )
        viewController.present(alertController, animated: true)
    }

    // MARK: - Helpers

    private func makeOKAlert(
        with data: AlertData,
        okActionHandler: (() -> Void)? = nil
    ) -> UIAlertController {
        let okAction: AlertAction = .init(
            title: "OK",
            style: .default,
            handler: okActionHandler
        )
        let builder = makeAlertBuilder()
        return builder
            .setTitle(data.title)
            .setMessage(data.message)
            .setStyle(.alert)
            .addAction(okAction)
            .build()
    }
    
    static func makeExampleModule(
        dependencyResolver: Resolver
    ) -> UIViewController {
        
        typealias Presenter = ExamplePresenterProtocol & ExampleInteractorOutputProtocol
        let presenter: Presenter = ExamplePresenter()
        
        let itemsService = dependencyResolver.resolve(ItemsServiceProtocol.self)!
        let dataManager: ExampleDataManager = .init(
            itemsService: itemsService
        )
        let interactor: ExampleInteractorInputProtocol = ExampleInteractor(
            dataManager: dataManager
        )
        
        let tableViewDataSource: ExampleTableViewDataSource = .init()
        let tableViewDelegate: ExampleTableViewDelegate = .init()
        let viewController: ExampleViewController = .init(
            tableViewDataSource: tableViewDataSource,
            tableViewDelegate: tableViewDelegate
        )
        
        let router: ExampleRouter = .init(
            viewController: viewController
        )
        
        // Connecting the components
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return UINavigationController(
            rootViewController: viewController
        )
    }
}
