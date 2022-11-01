import UIKit

protocol ___VARIABLE_sceneName___RoutingLogic {
	func routeToSomewhere()
}

protocol ___VARIABLE_sceneName___DataPassing {
	var dataStore: ___VARIABLE_sceneName___DataStore? { get }
}

final class ___VARIABLE_sceneName___Router: NSObject, ___VARIABLE_sceneName___RoutingLogic, ___VARIABLE_sceneName___DataPassing {
	// MARK: - Dependencies
	// swiftlint:disable:next implicitly_unwrapped_optional
	private weak var viewController: UIViewController!

	// MARK: - Properties

	var dataStore: ___VARIABLE_sceneName___DataStore?

	// MARK: - Initialization

	init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
    }
	
	// MARK: - ___VARIABLE_sceneName___RoutingLogic

	func routeToSomewhere() {
		// Implement your routing logic
	}
}
