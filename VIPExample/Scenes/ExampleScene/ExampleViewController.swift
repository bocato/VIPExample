import UIKit

protocol ExampleViewDisplayLogic: AnyObject {
    func displayExampleItems(_ viewModel: ExampleScene.List.ViewModel)
    func displayExampleItemsError(_ viewModel: ExampleScene.List.Error)
    func displayExampleItemsSelection()
}

final class ExampleViewController: UIViewController {
    // MARK: - Dependencies
    
    private let interactor: ExampleBusinessLogic
    
    typealias Router = ExampleRoutingLogic & ExampleDataPassing
    var router: Router?
    
    // MARK: - Properties
    
    private var viewModel: ExampleScene.List.ViewModel = .init(items: [])
    
    typealias CustomView = ExampleViewInterface
    var customView: CustomView? {
        get { view as? CustomView }
        set { view = newValue }
    }
    
    // MARK: - Initialization
    
    init(
        interactor: ExampleBusinessLogic
    ) {
        self.interactor = interactor
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
            tableViewDataSource: self,
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
        self.viewModel = viewModel
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

// MARK: - UITableViewDataSource

extension ExampleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(
            ExampleItemTableViewCell.self,
            indexPath: indexPath
        )
        let itemCellModel = viewModel.items[indexPath.row]
        cell.configure(with: itemCellModel)
        return cell
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
