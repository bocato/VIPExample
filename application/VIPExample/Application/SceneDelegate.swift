import UIKit
import DependencyInjection
import Services
import Feature_ExampleScene
import Feature_ExampleScene2

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var serviceLocator: ServiceLocatorInterface = ServiceLocator.shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        registerDependencies()
        setupRootViewController(windowScene: windowScene)
    }
}

// MARK: - RootView Configuration
extension SceneDelegate {
    private func registerDependencies() {
        // Data Modules
        Services.bootstrap(container: serviceLocator)
        // Feature Modules
        Feature_ExampleScene.bootstrap(container: serviceLocator)
        Feature_ExampleScene2.bootstrap(container: serviceLocator)
    }
    
    private func setupRootViewController(windowScene: UIWindowScene?) {
        let rootViewController = getRootViewController()
        let frame = windowScene?.coordinateSpace.bounds ?? UIScreen.main.bounds
        window = .init(frame: frame)
        window?.windowScene = windowScene
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func getRootViewController() -> UIViewController {
        let exampleAssembler: ExampleAssembling = serviceLocator.autoResolve()!
        return exampleAssembler.makeViewController()
    }
}
