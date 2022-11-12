import UIKit
import MyFoundation

protocol ExampleViewDisplayLogic: AnyObject {
    func displayExampleItems(_ viewModel: ExampleScene.List.ViewModel)
    func displayExampleItemsError(_ viewModel: ExampleScene.List.Error)
    func displayExampleItemsSelection()
}

final class ExampleViewController: UIViewController {
    // MARK: - Dependencies
    
    typealias Router = ExampleRoutingLogic & ExampleDataPassing
    private let interactor: ExampleBusinessLogic
    var router: Router?
    private let tableViewDataSource: ExampleTableViewDataSource
    private let tableViewDelegate: ExampleTableViewDelegate
    private let mainQueue: Dispatching
    
    // MARK: - Properties
    
    typealias CustomView = ExampleViewInterface
    var customView: ExampleViewInterface? {
        get { view as? CustomView }
        set { view = newValue }
    }
    
    // MARK: - Initialization
    
    init(
        interactor: ExampleBusinessLogic,
        tableViewDataSource: ExampleTableViewDataSource,
        tableViewDelegate: ExampleTableViewDelegate,
        mainQueue: Dispatching = AsyncQueue.main
    ) {
        self.interactor = interactor
        self.tableViewDataSource = tableViewDataSource
        self.tableViewDelegate = tableViewDelegate
        self.mainQueue = mainQueue
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadExampleItemsList(.init())
    }
    
    override func loadView() {
        view = ExampleView(
            tableViewDataSource: tableViewDataSource,
            tableViewDelegate: tableViewDelegate
        )
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Example View Controller"
        bindTableViewActions()
    }
    
    private func bindTableViewActions() {
        tableViewDelegate.actions = .init(
            onDidSelectRowAtIndexPath: { [interactor] indexPath in
                interactor.selectExampleItem(.init(index: indexPath.row))
            }
        )
    }
}

// MARK: - ExampleViewDisplayLogic

extension ExampleViewController: ExampleViewDisplayLogic {
    func displayExampleItems(_ viewModel: ExampleScene.List.ViewModel) {
        tableViewDataSource.items = viewModel.items
        mainQueue.dispatch {
            self.customView?.reloadTableView()
        }
    }
    
    func displayExampleItemsError(_ viewModel: ExampleScene.List.Error) {
        router?.routeToErrorAlert(viewModel)
    }
    
    func displayExampleItemsSelection() {
        router?.routeToSelectedItem()
    }
}
