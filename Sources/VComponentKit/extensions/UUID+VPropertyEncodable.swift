import Foundation

extension UUID: VPropertyEncodable {
    public var vEncoded: String {
        uuidString
    }
}
