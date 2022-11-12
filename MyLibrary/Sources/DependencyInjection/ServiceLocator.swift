import Foundation

public protocol Resolver {
    func resolve<T>(_ metaType: T.Type) -> T?
    func autoResolve<T>() -> T?
}

public protocol Container {
    func register<T>(instance: T, forMetaType metaType: T.Type)
    func register<T>(
        factory: @escaping (Resolver) -> T,
        forMetaType metaType: T.Type
    )
}
extension Container {
    public func register<T>(
        factory: @escaping () -> T,
        forMetaType metaType: T.Type
    ) {
        self.register(
            factory: { _ in factory() },
            forMetaType: metaType
        )
    }
}

public typealias ServiceLocatorInterface = Resolver & Container
public final class ServiceLocator {
    public static let shared: ServiceLocatorInterface = ServiceLocator()
    
    var instances: [String: Any] = [:]
    var lazyInstances: NSMapTable<NSString, LazyInstanceWrapper> = .init(
        keyOptions: .strongMemory,
        valueOptions: .weakMemory
    )
    
    typealias LazyDependencyFactory = () -> Any
    var factories: [String: LazyDependencyFactory] = [:]
    
    final class LazyInstanceWrapper {
        let instance: Any
        init(instance: Any) {
            self.instance = instance
        }
    }
    
    private func getKey<T>(for metaType: T.Type) -> String {
        let key = String(describing: T.self)
        return key
    }
}

extension ServiceLocator: Container {
    public func register<T>(instance: T, forMetaType metaType: T.Type) {
        let key = getKey(for: metaType)
        guard instances[key] == nil else {
            fatalError("You must not register something twice!")
        }
        instances[key] = instance
    }
    
    public func register<T>(factory: @escaping (Resolver) -> T, forMetaType metaType: T.Type) {
        let key = getKey(for: metaType)
        guard factories[key] == nil else {
            fatalError("You must not register something twice!")
        }
        factories[key] = { factory(self) }
    }
}

extension ServiceLocator: Resolver {
    public func resolve<T>(_ metaType: T.Type) -> T? {
        getInstance(forMetatype: T.self)
    }
    
    public func autoResolve<T>() -> T? {
        getInstance(forMetatype: T.self)
    }
}

extension ServiceLocator {
    private func getInstance<T>(forMetatype: T.Type) -> T? {
        let key = getKey(for: T.self)
        if let instance = instances[key] as? T {
            return instance
        } else if let lazyInstance = getLazyInstance(for: T.self, key: key)  {
            return lazyInstance
        } else {
            return nil
        }
    }
    
    private func getLazyInstance<T>(for _: T.Type, key: String) -> T? {
        let objectKey = key as NSString
        
        if let instanceInMemory = lazyInstances.object(forKey: objectKey)?.instance as? T {
            return instanceInMemory
        }
        
        guard
            let factory: LazyDependencyFactory = factories[key],
            let newInstance = factory() as? T
        else { return nil }
        
        let wrappedInstance = LazyInstanceWrapper(instance: newInstance)
        lazyInstances.setObject(wrappedInstance, forKey: objectKey)
        
        return newInstance
    }
}