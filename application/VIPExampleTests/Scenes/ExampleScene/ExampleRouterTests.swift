import XCTest
@testable import VIPExample

final class ExampleRouterTests: XCTestCase {
    // MARK: - Properties and Doubles
    private lazy var viewControllerSpy: ViewControllerSpy = .init()
    private lazy var alertBuilderMock: AlertBuilderMock = .init()
    private lazy var sut: ExampleRouter = {
        let alertBuilder = alertBuilderMock
        return .init(
            viewController: viewControllerSpy,
            makeAlertBuilder: { alertBuilder }
        )
    }()
    
    // MARK: - Tests
    func testExample_routeToErrorAlert_showsAlert() throws {
        // Given
        let alertData: ExampleScene.AlertData = .init(
            title: "title",
            message: "message"
        )

        // When
        sut.routeToErrorAlert(alertData)

        // Then
        XCTAssertTrue(
            viewControllerSpy.viewControllerToPresentPassed is UIAlertController
        )
        XCTAssertTrue(viewControllerSpy.animatedFlagPassed == true)
    }
    
    func testExample_routeToSelectedItem_whenOkIsTapped_itShouldSetSelectedToNil() throws {
        // Given
        let dataStore: ExampleDataStoreMock = .init()
        sut.dataStore = dataStore
        sut.dataStore?.selectedItem = .fixture(
            name: "Important Name",
            fullDescription: "Very large description"
        )

        sut.routeToSelectedItem()
        XCTAssertNotNil(sut.dataStore?.selectedItem)
        
        // When
        let alertHandler = alertBuilderMock.actionsPassed.last?.handler
        alertHandler?()

        // Then
        XCTAssertNil(sut.dataStore?.selectedItem)
    }
}

final class ViewControllerSpy: UIViewController {
    private(set) var viewControllerToPresentPassed: UIViewController?
    private(set) var animatedFlagPassed: Bool?
    private(set) var completionPassed: (() -> Void)?
    override func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        viewControllerToPresentPassed = viewControllerToPresent
        animatedFlagPassed = flag
        completionPassed = completion
        super.present(
            viewControllerToPresent,
            animated: flag,
            completion: completion
        )
    }
}

struct ExampleDataStoreMock: ExampleDataStore {
    var selectedItem: VIPExample.ExampleItem?
}
