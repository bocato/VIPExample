import Foundation

protocol ViewModelConfigurable {
    associatedtype ViewModel
    var viewModel: ViewModel? { get }
    func configure(with viewModel: ViewModel)
}
