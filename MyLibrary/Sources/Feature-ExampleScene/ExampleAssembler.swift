import UIKit
import Services
import Domain
import DependencyInjection
import Feature_ExampleScene2

public func bootstrap(container: Container) {
    container.register(
        factory: ExampleAssembler.init,
        forMetaType: ExampleAssembling.self
    )
}

public protocol ExampleAssembling {
    func makeViewController() -> UIViewController
}

struct ExampleAssembler: ExampleAssembling {
    @Dependency var itemsService: ItemsServiceProtocol
    @Dependency var example2Assembler: Example2Assembling
    
    func makeViewController() -> UIViewController {
        
        let presenter: ExamplePresenter = .init()
        
        let getExampleItemsWorker: GetExampleItemsWorker = .init(
            itemsService: itemsService
        )
        
        let interactor: ExampleInteractor = .init(
            presenter: presenter,
            getExampleItemsWorker: getExampleItemsWorker
        )
        
        let tableViewDataSource: ExampleTableViewDataSource = .init()
        let tableViewDelegate: ExampleTableViewDelegate = .init()
        let viewController: ExampleViewController = .init(
            interactor: interactor,
            tableViewDataSource: tableViewDataSource,
            tableViewDelegate: tableViewDelegate
        )
        
        let router: ExampleRouter = .init(
            viewController: viewController,
            example2Assembler: example2Assembler
        )
        
        router.dataStore = interactor
        presenter.viewController = viewController
        viewController.router = router
        
        return UINavigationController(
            rootViewController: viewController
        )
    }
}
