import UIKit

protocol ExampleAssembling {
    func makeViewController() -> UIViewController
}

struct ExampleAssembler: ExampleAssembling {
    func makeViewController() -> UIViewController {
        let presenter: ExamplePresenter = .init()
        
        let itemsService: ItemsService = .init()
        let getExampleItemsWorker: GetExampleItemsWorker = .init(
            itemsService: itemsService
        )
        
        let interactor: ExampleInteractor = .init(
            presenter: presenter,
            getExampleItemsWorker: getExampleItemsWorker
        )
        
        let tableViewDataSource: ExampleTableViewDataSource = .init()
        let viewController: ExampleViewController = .init(
            interactor: interactor,
            tableViewDataSource: tableViewDataSource
        )
        
        let router: ExampleRouter = .init(
            viewController: viewController
        )
        
        router.dataStore = interactor
        presenter.viewController = viewController
        viewController.router = router
        
        return UINavigationController(
            rootViewController: viewController
        )
    }
}
