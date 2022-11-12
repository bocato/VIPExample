import Foundation
import Combine

struct Product {
    let id: String
    /* more properties and stuff  */
}

enum ShoppingBagEvent {
    case productAdded(Product)
    case productRemoved(Product)
    case bagExpired
}

protocol ShoppingBagLogicControllerProtocol {
    var items: [Product] { get }
    var eventsPublisher: AnyPublisher<ShoppingBagEvent, Never> { get }
    func addProduct(_ product: Product)
    func removeProduct(_ product: Product)
}

final class ShoppingBagLogicController: ShoppingBagLogicControllerProtocol {
    // MARK: - Dependencies
    
    private let addToBagUseCase: AddToBagUseCase
    private let removeFromBagUseCase: RemoveFromBagUseCase
    
    // MARK: - Public Properties
    
    private(set) var items: [Product] = []
    var eventsPublisher: AnyPublisher<ShoppingBagEvent, Never> { eventsSubject.eraseToAnyPublisher() }
    
    // MARK: - Private Properties
    
    private var eventsSubject: PassthroughSubject<ShoppingBagEvent, Never> = .init()
    
    // MARK: - Initialization
    
    init(
        addToBagUseCase: AddToBagUseCase,
        removeFromBagUseCase: RemoveFromBagUseCase
    ) {
        self.addToBagUseCase = addToBagUseCase
        self.removeFromBagUseCase = removeFromBagUseCase
    }
    
    // MARK: - Public API
    
    func addProduct(_ product: Product) {
        if items.isEmpty {
            startExpirationTimer()
        }
        
        items.append(product) // let's imagine that there is some kind of logic to re-send in case of failure...
        
        addToBagUseCase.execute(product) { [eventsSubject]  suceeded in
            guard suceeded else { return }
            eventsSubject.send(.productAdded(product))
        }
    }
    
    func removeProduct(_ product: Product) {
        removeFromBagUseCase.execute(product) { [weak self] suceeded in
            guard suceeded else { return }
            
            guard let index = self?.items.firstIndex(where: { $0.id == product.id } ) else { return }
            self?.items.remove(at: index)
            
            self?.eventsSubject.send(.productRemoved(product))
        }
    }
    
    // MARK: - Private API
    
    private func startExpirationTimer() {
        // Lets imagine there is some logic here that starts a timer for expiration
        // When the timer is done, we send an event `.bagExpired`
    }
}

// Supporting elements for the example
protocol AddToBagUseCase {
    typealias Input = Product
    typealias Output = Bool
    func execute(_ input: Input, completion: @escaping (Output) -> Void)
}

protocol RemoveFromBagUseCase {
    typealias Input = Product
    typealias Output = Bool
    func execute(_ input: Input, completion: @escaping (Output) -> Void)
}
