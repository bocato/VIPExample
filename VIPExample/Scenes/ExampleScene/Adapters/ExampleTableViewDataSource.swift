import UIKit

final class ExampleTableViewDataSource: NSObject, UITableViewDataSource {
    typealias Item = ExampleScene.List.ViewModel.Item
    var items: [Item] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(
            ExampleItemTableViewCell.self,
            indexPath: indexPath
        )
        let itemCellModel = items[indexPath.row]
        cell.configure(with: itemCellModel)
        return cell
    }
}
