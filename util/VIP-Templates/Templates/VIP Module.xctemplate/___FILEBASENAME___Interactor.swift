import UIKit

protocol ___VARIABLE_sceneName___BusinessLogic {
	func doSomething(_ request: ___VARIABLE_sceneName___Scene.Something.Request)
}

protocol ___VARIABLE_sceneName___DataStore {
  var value: String? { get set }
}

final class ___VARIABLE_sceneName___Interactor: ___VARIABLE_sceneName___BusinessLogic, ___VARIABLE_sceneName___DataStore {
	// MARK: - Inner Types

	struct Dependencies {
		let someDependency: SomeDependencyProtocol
	}

	// MARK: - Dependencies

    private let presenter: ___VARIABLE_sceneName___PresentationLogic
	private let dependencies: Dependencies
	
	// MARK: - Data Store

	var value: String?

	// MARK: - Initialization

	init(
		presenter: ___VARIABLE_sceneName___PresentationLogic,
		dependencies: Dependencies
	) {
		self.presenter = presenter
		self.dependencies = dependencies
	}

	// MARK: - ___VARIABLE_sceneName___BusinessLogic
	
	func doSomething(_ request: ___VARIABLE_sceneName___Scene.Something.Request) {
		let response: ___VARIABLE_sceneName___Scene.Something.Response = .init()
		presenter.presentSomething(response)
	}
}
