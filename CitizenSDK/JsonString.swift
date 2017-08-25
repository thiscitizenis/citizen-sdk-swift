public struct JsonString : JsonObject
{
    let TAG: String = "JsonString: "
    
    public var string: String?
    
    public init() {}
    
    public init?(string: String) { self.string = string }
    
    public init?(jsonDictionary: [String: Any]) { return nil }
    
    public func toJson() -> String? { return string }
}
