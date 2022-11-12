import UIKit
import JMSUIKit

protocol ___VARIABLE_sceneName___ViewInterface where Self: UIView {
	func displaySomething(_ viewModel: ___VARIABLE_sceneName___Scene.Something.ViewModel)
}

final class ___VARIABLE_sceneName___View: CodedView, ___VARIABLE_sceneName___ViewProtocol {
	// MARK: - Constants

    private enum Metrics {
        static let topMargin: CGFloat = 20
    }

	// MARK: - UI Components

    private lazy var someView: UIView = {
        let view = UIView()
        return view
    }()

	// MARK: - Initialization

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewCode Setup

    override func addSubviews() {
        addSubview(someView)
    }

    override func constrainSubviews() {
        constrainSomeView()
    }

    override func configureAdditionalSettings() {
        backgroundColor = .white
    }

	// MARK: - Constraints Setup

    private func constrainSomeView() {
        someView.layout(
            using: [
                someView.topAnchor.constraint(equalTo: topAnchor,  constant: Metrics.topMargin),
                someView.leadingAnchor.constraint(equalTo: leadingAnchor),
                someView.trailingAnchor.constraint(equalTo: trailingAnchor),
                someView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }

    // MARK: - Public API
    
    func doSomething(_ viewModel: ___VARIABLE_sceneName___Scene.Something.ViewModel) {
        // Do something
    }
}
