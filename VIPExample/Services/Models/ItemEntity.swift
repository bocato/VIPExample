import Foundation

struct ItemEntity: Decodable {
    let id: Int
    let name: String
    let simpleDescription: String
    let fullDescription: String
}
