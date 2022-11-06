import UIKit

final class ExampleViewController: UIViewController, ExampleViewControllerProtocol {
    
    // MARK: - Dependencies
    
    var presenter: ExamplePresenterProtocol?
    private let tableViewDataSource: ExampleTableViewDataSource
    private let tableViewDelegate: ExampleTableViewDelegate
    
    // MARK: - Properties
    
    typealias CustomView = ExampleViewInterface
    var customView: CustomView? {
        get { view as? CustomView }
        set { view = newValue }
    }
    
    // MARK: - Initialization
    
    init(
        tableViewDataSource: ExampleTableViewDataSource,
        tableViewDelegate: ExampleTableViewDelegate
    ) {
        self.tableViewDataSource = tableViewDataSource
        self.tableViewDelegate = tableViewDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
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
            onDidSelectRowAtIndexPath: { [presenter] indexPath in
                presenter?.selectExampleItemAtIndex(indexPath.row)
            }
        )
    }
}

// MARK: - ExampleViewControllerProtocol

extension ExampleViewController {
    func displayExampleItems(_ items: [ListItem]) {
        tableViewDataSource.items = items
        DispatchQueue.main.async {
            self.customView?.reloadTableView()
        }
    }
}
