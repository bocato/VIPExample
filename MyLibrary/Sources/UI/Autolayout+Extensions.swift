import UIKit

extension UIView {
    /// Simplifies layouting with a constraint array
    /// - Parameter constraints: the constraints to apply to the view
    public func layout(using constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
