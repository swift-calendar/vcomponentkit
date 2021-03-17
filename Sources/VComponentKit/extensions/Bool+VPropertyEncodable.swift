extension Bool: VPropertyEncodable {
    public var vEncoded: String {
        self ? "1" : "0"
    }
}
