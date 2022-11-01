import UIKit

protocol ___VARIABLE_sceneName___Assembling {
    func makeViewController(
        with arguments: Any
    ) -> UIViewController
}

struct ___VARIABLE_sceneName___Assembler: ___VARIABLE_sceneName___Assembling {
    // MARK: - Dependencies

    @Dependency var someDependency: SomeDependencyProtocol

    // MARK: - Public API

    func makeViewController(
        with arguments: Any
    ) -> UIViewController {
        
        let presenter: ___VARIABLE_sceneName___Presenter = .init()

        let interactorDependencies: ___VARIABLE_sceneName___Interactor.Dependencies = .init(
            someDependency: someDependency
        )
        let interactor: ___VARIABLE_sceneName___Interactor = .init(
            presenter: presenter,
            dependencies: interactorDependencies
        )

        let viewController: ___VARIABLE_sceneName___ViewController = .init(
            interactor: interactor
        )

        let router: ___VARIABLE_sceneName___Router = .init(
            viewController: viewController
        )

        router.dataStore = interactor
        presenter.viewController = viewController
        viewController.router = router

        return viewController
    }
}
