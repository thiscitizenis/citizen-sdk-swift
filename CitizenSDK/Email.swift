import Foundation

public struct Email : JsonObject
{
    let TAG: String = "Email: "
    
    public var encryptedEmail: String?
    
    public var isPrimary: Bool?
    
    public var isEntityEmail: Bool?
    
    public var isEntityAdmin: Bool?
    
    public init() {}
    
    public init?(string: String) { return nil }
    
    public init?(jsonDictionary: [String: Any]) {
        
        guard let encryptedEmail = jsonDictionary["encryptedEmail"] as? String,
            let isPrimary = jsonDictionary["isPrimary"] as? Bool,
            let isEntityEmail = jsonDictionary["isEntityEmail"] as? Bool,
            let isEntityAdmin = jsonDictionary["isEntityAdmin"] as? Bool
            else {
                NSLog(TAG + ResourceError.jsonMissingRequiredFields.localizedDescription)
                return nil;
        }
        
        self.encryptedEmail = encryptedEmail
        self.isPrimary = isPrimary
        self.isEntityEmail = isEntityEmail
        self.isEntityAdmin = isEntityAdmin
    }
    
    public func toJson() -> String? {
        var dict: Dictionary = [String:Any]()
        
        if self.encryptedEmail != nil { dict["encryptedEmail"] = self.encryptedEmail! }
        if self.isPrimary != nil { dict["isPrimary"] = self.isPrimary! }
        if self.isEntityEmail != nil { dict["isEntityEmail"] = self.isEntityEmail! }
        if self.isEntityAdmin != nil { dict["isEntityAdmin"] = self.isEntityAdmin! }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:jsonData, encoding:.utf8)
        } catch {
            NSLog(TAG + ResourceError.unableToConvertDictionaryToJson.localizedDescription)
            return nil
        }
    }
}
