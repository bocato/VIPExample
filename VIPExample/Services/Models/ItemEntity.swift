import Foundation

struct ItemEntity: Decodable {
    let id: Int
    let name: String
    let simpleDescription: String
    let fullDescription: String
}

#if DEBUG
extension ItemEntity {
    static func fixture(
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
