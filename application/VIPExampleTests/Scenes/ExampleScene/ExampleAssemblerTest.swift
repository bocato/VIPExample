import XCTest
@testable import VIPExample

final class ExampleAssemblerTest: XCTestCase {
    func test_makeViewController_returnsUINavigationController_withTheCorrectController() throws {
        // Given
        var sut: ExampleAssembler = .init()
//        sut.itemsService = .resolved(ItemsServiceDummy())
        
        // When
        let value = sut.makeViewController()
        
        // Then
        let navigation = try XCTUnwrap(value as? UINavigationController)
        XCTAssertTrue(navigation.viewControllers.first is ExampleViewController)
    }
}

struct ItemsServiceDummy: ItemsServiceProtocol {
    func getItems(then: @escaping (Result<[ItemEntity], ItemsServiceError>) -> Void) {}
}
