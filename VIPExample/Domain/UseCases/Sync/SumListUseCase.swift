import Foundation

protocol SumListUseCaseProtocol {
    func execute(_ list: [Int]) -> Int
}

struct SumListUseCase: SumListUseCaseProtocol {
    func execute(_ list: [Int]) -> Int {
        return list.reduce(0, +)
    }
}
