import Foundation

/// The V object is organized into individual lines of text,
/// called content lines.  Content lines are delimited by a line break,
/// which is a CRLF sequence (CR character followed by LF character).
///
/// See https://tools.ietf.org/html/rfc5545#section-3.1
public struct VContentLine: VEncodable {
    private static let maxLength: Int = 75

    public let key: String
    public let value: VPropertyEncodable

    public var vEncoded: String {
        let params = value.parameters
        let raw = "\(key)\(params.map { ";\($0.0)=\(quote($0.1.joined(separator: ","), if: $0.1.count > 1))" }.joined()):\(value.vEncoded)"
        let chunks = raw.chunks(ofLength: Self.maxLength)
        assert(!chunks.isEmpty)

        // From the RFC (section 3.1):
        //
        // Lines of text SHOULD NOT be longer than 75 octets, excluding the line
        // break.  Long content lines SHOULD be split into a multiple line
        // representations using a line "folding" technique.  That is, a long
        // line can be split between any two characters by inserting a CRLF
        // immediately followed by a single linear white-space character (i.e.,
        // SPACE or HTAB).  Any sequence of CRLF followed immediately by a
        // single linear white-space character is ignored (i.e., removed) when
        // processing the content type.

        return chunks
            .enumerated()
            .map { (i, c) in i > 0 ? " \(c)" : c }
            .map { "\($0)\r\n" }
            .joined()
    }

    public init(key: String, value: VPropertyEncodable) {
        self.key = key
        self.value = value
    }

    public static func line(_ key: String, _ value: VPropertyEncodable?) -> VContentLine? {
        guard let value = value else { return nil }
        return VContentLine(key: key, value: value)
    }
}

fileprivate func quote(_ s: String, if predicate: Bool) -> String {
    predicate ? "\"\(s)\"" : s
}
