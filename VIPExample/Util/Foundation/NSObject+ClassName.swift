import Foundation

extension NSObject {
    /// String describing the class name.
    static var className: String {
        return String(describing: self)
    }
}
