import UIKit

/// Defines the pattern for creating a ViewCode based layout
public protocol ViewCodeConfigurator {
    /// Where you add all your subviews.
    func addSubviews()
    /// Where you should place your constraint related functions / setup.
    func constrainSubviews()
}
extension ViewCodeConfigurator {
    fileprivate func initLayout() {
        addSubviews()
        constrainSubviews()
    }
}

open class CodedView: UIView, ViewCodeConfigurator {
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("This view cannot be instantiated from IB.")
    }
    
    // MARK: - Layout Setup
    
    open func addSubviews() {
        fatalError("You should override this function in order to setup your CodedView.")
    }
    
    open func constrainSubviews() {
        fatalError("You should override this function in order to setup your CodedView.")
    }
    
}

open class CodedTableViewCell: UITableViewCell, ViewCodeConfigurator {
    // MARK: - Initialization
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("This view cannot be instantiated from IB.")
    }
    
    // MARK: - Layout Setup
    
    open func addSubviews() {
        fatalError("You should override this function in order to setup your CodedView.")
    }
    
    open func constrainSubviews() {
        fatalError("You should override this function in order to setup your CodedView.")
    }
}

