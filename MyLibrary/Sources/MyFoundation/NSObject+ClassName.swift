import Foundation

extension NSObject {
    /// String describing the class name.
    public static var className: String {
        return String(describing: self)
    }
}
