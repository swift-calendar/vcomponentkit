extension Bool: VPropertyEncodable {
    public var vEncoded: String {
        self ? "TRUE" : "FALSE"
    }
}
