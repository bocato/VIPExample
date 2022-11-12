import Foundation

public struct ItemEntity: Decodable {
    public let id: Int
    public let name: String
    public let simpleDescription: String
    public let fullDescription: String
}

#if DEBUG
extension ItemEntity {
    public static func fixture(
        id: Int = 0,
        name: String = "name",
        simpleDescription: String = "simpleDescription",
        fullDescription: String = "fullDescription"
    ) -> Self {
        .init(
            id: id,
            name: name,
            simpleDescription: simpleDescription,
            fullDescription: fullDescription
        )
    }
}
#endif
