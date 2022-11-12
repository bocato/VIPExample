import XCTest
@testable import VIPExample

final class ExamplePresenterTests: XCTestCase {
    // MARK: - Test Doubles
    
    private lazy var exampleViewDisplayLogicSpy: ExampleViewDisplayLogicSpy = .init()
    
    // MARK: - Tests
    
    func test_presentExampleItemsListError_whenAnErrorIsPassed_itShouldPresentTheExpectMessage() throws {
        // Given
        let sut: ExamplePresenter = .init()
        sut.viewController = exampleViewDisplayLogicSpy
        let response: ExampleScene.Error = NSError(
            domain: "Test",
            code: -13,
            userInfo: nil
        )
        let expectedErrorModel = ExampleScene.List.Error(
            title: "Error",
            message: "Could not load example items."
        )
        
        // When
        sut.presentExampleItemsListError(response)
        
        // Then
        XCTAssertEqual(
            exampleViewDisplayLogicSpy.displayExampleItemsErrorViewModelPassed,
            expectedErrorModel
        )
    }
}

final class ExampleViewDisplayLogicSpy: ExampleViewDisplayLogic {
    func displayExampleItems(_ viewModel: VIPExample.ExampleScene.List.ViewModel) {
        XCTFail("displayExampleItems not implemented.")
    }
    
    private(set) var displayExampleItemsErrorCalled = false
    private(set) var displayExampleItemsErrorViewModelPassed: VIPExample.ExampleScene.List.Error?
    func displayExampleItemsError(_ viewModel: VIPExample.ExampleScene.List.Error) {
        displayExampleItemsErrorCalled = true
        displayExampleItemsErrorViewModelPassed = viewModel
    }
    
    func displayExampleItemsSelection() {
        XCTFail("displayExampleItemsSelection not implemented.")
    }
}
