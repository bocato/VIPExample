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
    var router: Router!
    
    // MARK: - Properties
    
    private var viewModel: ExampleScene.List.ViewModel = .init(items: [])
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(
            ExampleItemTableViewCell.self,
            forCellReuseIdentifier: ExampleItemTableViewCell.className
        )
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    
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
        super.loadView()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Example View Controller"
        addSubviews()
        constrainSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func constrainSubviews() {
        constrainTableView()
    }
    
    private func constrainTableView() {
        tableView.layout(
            using: [
                tableView.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor
                ),
                tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                tableView.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor
                ),
                tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ]
        )
    }
}

// MARK: - ExampleViewDisplayLogic

extension ExampleViewController: ExampleViewDisplayLogic {
    func displayExampleItems(_ viewModel: ExampleScene.List.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayExampleItemsError(_ viewModel: ExampleScene.List.Error) {
        router.routeToErrorAlert(viewModel)
    }
    
    func displayExampleItemsSelection() {
        router.routeToSelectedItem()
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
