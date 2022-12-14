import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupRootViewController(windowScene: windowScene)
    }
}

// MARK: - RootView Configuration
extension SceneDelegate {
    private func setupRootViewController(windowScene: UIWindowScene?) {
        let rootViewController = makeExampleViewController()
        
        let frame = windowScene?.coordinateSpace.bounds ?? UIScreen.main.bounds
        window = .init(frame: frame)
        window?.windowScene = windowScene
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func makeExampleViewController() -> UIViewController {
        let itemsService: ItemsService = .init()
        
        let viewModel: ExampleViewModel = .init(
            itemsService: itemsService
        )
        
        let viewController: ExampleViewController = .init(
            viewModel: viewModel
        )
        
        viewModel.delegate = viewController
        
        return UINavigationController(
            rootViewController: viewController
        )
    }
}
