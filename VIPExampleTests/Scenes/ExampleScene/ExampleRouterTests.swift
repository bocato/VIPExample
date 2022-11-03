import XCTest
@testable import VIPExample

final class ExampleRouterTests: XCTestCase {

    func testExample_routeToErrorAlert_showsAlert() throws {
        // Given
        let viewController: UIViewController = .init()
        let sut: ExampleRouter = .init(
            viewController: viewController
        )
        let alertData: ExampleScene.AlertData = .init(
            title: "title"
            message: "message"
        )
        
        // When
        sut.routeToErrorAlert(alertData)
        
        // Then
        
    }
}

final class ViewControllerSpy: UIViewController {
    
}
