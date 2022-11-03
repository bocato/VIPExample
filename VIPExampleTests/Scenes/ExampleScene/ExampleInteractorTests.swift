//import XCTest
//@testable import VIPExample
//
//final class ExampleInteractorTests: XCTestCase {
//    // MARK: - Test Doubles
//    
//    private lazy var getExampleItemsWorkerStub: GetExampleItemsWorkerStub = .init()
//    private lazy var examplePresentationSpy: ExamplePresentationSpy = .init()
//    
//    // MARK: - Tests
//    
//    func test_loadExampleItemsList_whenItSucceeds_itShouldCallThePresenter() throws {
//        // Given
//        let items: [ExampleItem] = [
//            .init(
//                name: "Name 1",
//                description: "SimpleDescription 1",
//                fullDescription: "Full Description 1"
//            )
//        ]
//        getExampleItemsWorkerStub.resultToBeReturned = .success(items)
//        let sut: ExampleInteractor = .init(
//            presenter: examplePresentationSpy,
//            getExampleItemsWorker: getExampleItemsWorkerStub
//        )
//        let request: ExampleScene.List.Request = .init()
//        
//        // When
//        sut.loadExampleItemsList(request)
//    
//        // Then
//        XCTAssertEqual(examplePresentationSpy.presentExampleItemsListResponsePassed?.items, items)
//    }
//}
//
//struct ExamplePresentationFailing: ExamplePresentationLogic {
//    func presentExampleItemsList(_ response: ExampleScene.List.Response) {
//        XCTFail("presentExampleItemsList was not implemented.")
//    }
//    
//    func presentExampleItemsListError(_ response: ExampleScene.Error) {
//        XCTFail("presentExampleItemsListError was not implemented.")
//    }
//    
//    func presentExampleItemsSelection(_ response: ExampleScene.Selection.Response) {
//        XCTFail("presentExampleItemsSelection was not implemented.")
//    }
//}
//
//final class ExamplePresentationSpy: ExamplePresentationLogic {
//    private(set) var presentExampleItemsListCalled = false
//    private(set) var presentExampleItemsListResponsePassed: ExampleScene.List.Response?
//    func presentExampleItemsList(_ response: ExampleScene.List.Response) {
//        presentExampleItemsListCalled = true
//        presentExampleItemsListResponsePassed = response
//    }
//
//    func presentExampleItemsListError(_ response: ExampleScene.Error) {
//        XCTFail("presentExampleItemsListError was not implemented.")
//    }
//
//    func presentExampleItemsSelection(_ response: ExampleScene.Selection.Response) {
//        XCTFail("presentExampleItemsSelection was not implemented.")
//    }
//}
