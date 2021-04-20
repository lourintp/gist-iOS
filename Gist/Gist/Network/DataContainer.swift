import Foundation

public struct DataContainer<Results: Decodable> : Decodable {
    public let results: Results
}
