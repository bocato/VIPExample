import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell>(_ reusable: T.Type = T.self, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Cell \(T.className) is not registered - call tableView.register(Cell.Type) to register first before using.")
        }
        return cell
    }
}
