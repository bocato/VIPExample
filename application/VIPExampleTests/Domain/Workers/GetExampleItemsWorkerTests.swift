import XCTest
@testable import VIPExample
import SnapshotTesting

final class GetExampleItemsWorkerTests: XCTestCase {
    private let isRecordModeOn = false
    
    func testExample() throws {
        // Given
        let itemsServiceStub: ItemsServiceStub = .init()
        itemsServiceStub.getItemsResultToBeReturned = .success(
            [
                .fixture(name: "Item 1"),
                .fixture(name: "Item 2"),
                .fixture(name: "Item 3")
            ]
        )
        let sut: GetExampleItemsWorker = .init(
            itemsService: itemsServiceStub
        )
        
        // When
        let fetchItemsExpectation = expectation(description: "Expecting items to be fetched.")
        var itemsReturned: [ExampleItem]?
        sut.fetchItems { result in
            if let items = try? result.get() {
                itemsReturned = items
            }
            fetchItemsExpectation.fulfill()
        }
        
        // Then
        wait(for: [fetchItemsExpectation], timeout: 0.1)
        assertSnapshot(
            matching: itemsReturned,
            as: .dump,
            record: isRecordModeOn
        )
    }
}
