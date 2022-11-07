import SnapshotTesting
import XCTest
@testable import VIPExample

final class ExampleViewTests: XCTestCase {
    private let isRecordModeOn = false
    
    func test_view_shouldShowCells_asExpected() {
        // Given
        let dataSource: ExampleTableViewDataSource = .init()
        let delegate: ExampleTableViewDelegate = .init()
        dataSource.items = [
            .fixture(),
            .fixture(),
            .fixture()
        ]
        let frame: CGRect = UIScreen.main.bounds
        let sut: ExampleView = .init(
            frame: frame,
            tableViewDataSource: dataSource,
            tableViewDelegate: delegate
        )
        
        // When / Then
        assertSnapshots(
            matching: sut,
            as: [.image],
            record: isRecordModeOn
        )
    }
}
