import UIKit
import Services
import Domain
import DependencyInjection

public func bootstrap(container: Container) {
    container.register(
        factory: Example2Assembler.init,
        forMetaType: Example2Assembling.self
    )
}

public protocol Example2Assembling {
    func makeViewController() -> UIViewController
}

import SwiftUI

struct Example2Assembler: Example2Assembling {
//    @Dependency var itemsService: ItemsServiceProtocol
    
    func makeViewController() -> UIViewController {
        let scene = Text("Wow!")
        return UIHostingController(rootView: scene)
//        let presenter: ExamplePresenter = .init()
//
//        let getExampleItemsWorker: GetExampleItemsWorker = .init(
//            itemsService: itemsService
//        )
//
//        let interactor: ExampleInteractor = .init(
//            presenter: presenter,
//            getExampleItemsWorker: getExampleItemsWorker
//        )
//
//        let tableViewDataSource: ExampleTableViewDataSource = .init()
//        let tableViewDelegate: ExampleTableViewDelegate = .init()
//        let viewController: ExampleViewController = .init(
//            interactor: interactor,
//            tableViewDataSource: tableViewDataSource,
//            tableViewDelegate: tableViewDelegate
//        )
//
//        let router: ExampleRouter = .init(
//            viewController: viewController
//        )
//
//        router.dataStore = interactor
//        presenter.viewController = viewController
//        viewController.router = router
//
//        return UINavigationController(
//            rootViewController: viewController
//        )
    }
}
