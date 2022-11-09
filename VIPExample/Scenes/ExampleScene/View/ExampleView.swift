import Foundation
import UIKit

protocol ExampleViewInterface where Self: UIView {
    func reloadTableView()
}

final class ExampleView: CodedView, ExampleViewInterface {
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
        return tableView
    }()
    
    
    // MARK: - Initialization
    
    init(
        frame: CGRect = .zero,
        tableViewDataSource: UITableViewDataSource,
        tableViewDelegate: UITableViewDelegate
    ) {
        super.init(frame: frame)
        backgroundColor = .white
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    
    override func addSubviews() {
        addSubview(tableView)
    }
    
    override func constrainSubviews() {
        tableView.layout(
            using: [
                tableView.topAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.topAnchor
                ),
                tableView.leftAnchor.constraint(equalTo: leftAnchor),
                tableView.bottomAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.bottomAnchor
                ),
                tableView.rightAnchor.constraint(equalTo: rightAnchor)
            ]
        )
    }
    
    // MARK: - Public API
    
    func reloadTableView() {
        tableView.reloadData()
    }
}
