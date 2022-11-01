import UIKit

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
        serviceLocator.register(
            factory: ItemsService.init,
            forMetaType: ItemsServiceProtocol.self
        )
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
        let exampleAssembler: ExampleAssembler = .init()
        return exampleAssembler.makeViewController()
    }
}
