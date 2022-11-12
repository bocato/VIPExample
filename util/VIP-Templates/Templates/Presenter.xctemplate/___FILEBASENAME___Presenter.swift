import UIKit

protocol ___VARIABLE_sceneName___PresentationLogic {
	func presentSomething(_ response: ___VARIABLE_sceneName___Scene.Something.Response)
}

final class ___VARIABLE_sceneName___Presenter: ___VARIABLE_sceneName___PresentationLogic {
	// MARK: - Dependencies
	
	weak var viewController: ___VARIABLE_sceneName___DisplayLogic?
	
	// MARK: - ___VARIABLE_sceneName___PresentationLogic
	
	func presentSomething(_ response: ___VARIABLE_sceneName___Scene.Something.Response) {
		let viewModel: ___VARIABLE_sceneName___Scene.Something.ViewModel = .init()
		viewController?.displaySomething(viewModel)
	}
}