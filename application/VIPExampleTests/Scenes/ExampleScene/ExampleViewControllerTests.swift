import XCTest
@testable import VIPExample

final class ExampleViewControllerTests: XCTestCase {
    func test_displayExampleItems_setsDataSource_andReloadsTableView() {
        // Given
        let dataSource: ExampleTableViewDataSource = .init()
        let delegate: ExampleTableViewDelegate = .init()
        let sut: ExampleViewController = .init(
            interactor: ExampleBusinessLogicDummy(),
            tableViewDataSource: dataSource,
            tableViewDelegate: delegate,
            mainQueue: SyncQueue.global
        )
        let viewModelMock: ExampleScene.List.ViewModel = .init(
            items: [
                .fixture(title: "Item 1"),
                .fixture(title: "Item 2")
            ]
        )
        let exampleViewInterfaceSpy: ExampleViewInterfaceSpy = .init()
        sut.view = exampleViewInterfaceSpy
        
        // When
        sut.displayExampleItems(viewModelMock)
        
        // Then
        XCTAssertEqual(viewModelMock.items, dataSource.items)
        XCTAssertTrue(exampleViewInterfaceSpy.reloadTableViewCalled)
    }
}

struct ExampleBusinessLogicDummy: ExampleBusinessLogic {
    func loadExampleItemsList(_ request: ExampleScene.List.Request) {}
    func selectExampleItem(_ request: ExampleScene.Selection.Request) {}
}

final class ExampleViewInterfaceSpy: UIView, ExampleViewInterface {
    private(set) var reloadTableViewCalled = false
    func reloadTableView() {
        reloadTableViewCalled = true
    }
}
