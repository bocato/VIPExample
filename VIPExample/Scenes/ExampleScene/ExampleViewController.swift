import UIKit

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
    
    // MARK: - Properties
    
    typealias CustomView = ExampleViewInterface
    var customView: CustomView? {
        get { view as? CustomView }
        set { view = newValue }
    }
    
    // MARK: - Initialization
    
    init(
        interactor: ExampleBusinessLogic,
        tableViewDataSource: ExampleTableViewDataSource
    ) {
        self.interactor = interactor
        self.tableViewDataSource = tableViewDataSource
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
            tableViewDelegate: self
        )
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Example View Controller"
    }
}

// MARK: - ExampleViewDisplayLogic

extension ExampleViewController: ExampleViewDisplayLogic {
    func displayExampleItems(_ viewModel: ExampleScene.List.ViewModel) {
        tableViewDataSource.items = viewModel.items
        DispatchQueue.main.async {
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

// MARK: - UITableViewDelegate

extension ExampleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        interactor.selectExampleItem(.init(index: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
