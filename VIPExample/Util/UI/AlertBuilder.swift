import UIKit

struct AlertAction {
    let title: String
    let style: UIAlertAction.Style
    let handler: (() -> Void)?
}

protocol AlertBuilding {
    @discardableResult func setTitle(_ title: String?) -> Self
    @discardableResult func setMessage(_ message: String?) -> Self
    @discardableResult func setStyle(_ style: UIAlertController.Style) -> Self
    @discardableResult func addAction(_ action: AlertAction) -> Self
    func build() -> UIAlertController
}

final class AlertBuilder: AlertBuilding {
    // MARK: - Properties
    
    private var title: String?
    private var message: String?
    private var style: UIAlertController.Style = .alert
    private var actions: [AlertAction] = []
    
    // MARK: - Initialization
    
    init() {}
    
    @discardableResult func setTitle(_ title: String?) -> Self {
        self.title = title
        return self
    }
    
    @discardableResult func setMessage(_ message: String?) -> Self {
        self.message = message
        return self
    }
    
    @discardableResult func setStyle(_ style: UIAlertController.Style) -> Self {
        self.style = style
        return self
    }
    
    @discardableResult func addAction(_ action: AlertAction) -> Self {
        actions.append(action)
        return self
    }
    
    func build() -> UIAlertController {
        let alertController: UIAlertController = .init(
            title: title,
            message: message,
            preferredStyle: style
        )
        actions.forEach {
            alertController.addAction($0.asUIAlertAction())
        }
        return alertController
    }
}

extension AlertAction {
    func asUIAlertAction() -> UIAlertAction {
        .init(
            title: title,
            style: style,
            handler: { [handler] _ in handler?() }
        )
    }
}

#if DEBUG
final class AlertBuilderMock: AlertBuilding {
    private var realBuilder: AlertBuilder = .init()
    
    init() {}
    
    private(set) var titlePassed: String?
    func setTitle(_ title: String?) -> AlertBuilderMock {
        titlePassed = title
        realBuilder.setTitle(title)
        return self
    }
    
    private(set) var messagePassed: String?
    func setMessage(_ message: String?) -> AlertBuilderMock {
        messagePassed = message
        realBuilder.setMessage(message)
        return self
    }
    
    private(set) var stylePassed: UIAlertController.Style?
    func setStyle(_ style: UIAlertController.Style) -> AlertBuilderMock {
        stylePassed = style
        realBuilder.setStyle(style)
        return self
    }
    
    var addActionCalled: Bool { addActionCalledTimes > 0 }
    var addActionCalledTimes: Int { actionsPassed.count }
    private(set) var actionsPassed: [AlertAction] = []
    func addAction(_ action: AlertAction) -> AlertBuilderMock {
        actionsPassed.append(action)
        realBuilder.addAction(action)
        return self
    }
    
    private(set) var buildCalled = false
    func build() -> UIAlertController {
        buildCalled = true
        return realBuilder.build()
    }
}
#endif
