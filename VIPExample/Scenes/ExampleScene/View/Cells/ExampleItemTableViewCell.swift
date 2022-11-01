import UIKit

final class ExampleItemTableViewCell: CodedTableViewCell, ViewModelConfigurable {
    // MARK: - Aliases
    
    typealias ViewModel = ExampleScene.List.ViewModel.Item
    
    // MARK: - Properties
       
    private(set) var viewModel: ViewModel?
    
    // MARK: - Layout Items
    
    private lazy var _titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var _descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView: UIStackView = .init(
            arrangedSubviews: [
                _titleLabel,
                _descriptionLabel
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
       
    // MARK: - Layout Setup
    
    override func addSubviews() {
        contentView.addSubview(stackView)
    }
    
    override func constrainSubviews() {
        stackView.layout(
            using: [
                stackView.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: DS.Padding.default
                ),
                stackView.leftAnchor.constraint(
                    equalTo: contentView.leftAnchor,
                    constant: DS.Padding.default
                ),
                stackView.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: -DS.Padding.default
                ),
                stackView.rightAnchor.constraint(
                    equalTo: contentView.rightAnchor,
                    constant: -DS.Padding.default
                ),
            ]
        )
    }
    
    // MARK: - Configuration
    
    func configure(with viewModel: ExampleScene.List.ViewModel.Item) {
        self.viewModel = viewModel
        _titleLabel.text = viewModel.title
        _descriptionLabel.text = viewModel.description
    }
}
