
import Foundation

/// Describes something that can dispatch a work to be done.
public protocol Dispatching {
    /// Dispatches the work to be done.
    /// - Parameter work: the work closure.
    func dispatch(_ work: @escaping () -> Void)
    func dispatch(after time: DispatchTimeInterval, _ work: @escaping () -> Void)
}

/// Describes a queue that will run asynchronously.
public struct AsyncQueue: Dispatching {
    let queue: DispatchQueue
    public init(queue: DispatchQueue) {
        self.queue = queue
    }
    
    public func dispatch(_ work: @escaping () -> Void) {
        queue.async(execute: work)
    }
    
    public func dispatch(after time: DispatchTimeInterval, _ work: @escaping () -> Void) {
        queue.asyncAfter(deadline: DispatchTime.now() + time, execute: work)
    }
}

public extension AsyncQueue {
    /// Same as DispatchQueue.main
    static let main: AsyncQueue = .init(queue: .main)
    /// Same as DispatchQueue.global()
    static let global: AsyncQueue = .init(queue: .global())
    /// Same as DispatchQueue.background
    static let background: AsyncQueue = .init(queue: .global(qos: .background))
}

/// Describes a queue that will run synchronously.
public struct SyncQueue: Dispatching {
    let queue: DispatchQueue
    public init(queue: DispatchQueue) {
        self.queue = queue
    }
    
    public func dispatch(_ work: @escaping () -> Void) {
        queue.sync(execute: work)
    }
    
    public func dispatch(after time: DispatchTimeInterval, _ work: @escaping () -> Void) {
        fatalError("You are trying to perform asyc operations on a synchronous queue. Consider using an AsyncQueue.")
    }
}

extension SyncQueue {
    /// Same as DispatchQueue.main
    static let main: SyncQueue = .init(queue: .main)
    /// Same as DispatchQueue.global()
    static let global: SyncQueue = .init(queue: .global())
    /// Same as DispatchQueue.background
    static let background: SyncQueue = .init(queue: .global(qos: .background))
}

#if DEBUG
import XCTestDynamicOverlay

final class FailingQueue: Dispatching {
    func dispatch(_ work: @escaping () -> Void) {
        XCTFail("FailingQueue always fails!")
    }
    
    func dispatch(after time: DispatchTimeInterval, _ work: @escaping () -> Void) {
        XCTFail("FailingQueue always fails!")
    }
}

extension SyncQueue {
    /// A sync queue that always fails.
    static let failing: FailingQueue = .init()
}

extension AsyncQueue {
    /// An async queue that always fails.
    static let failing: FailingQueue = .init()
}
#endif
