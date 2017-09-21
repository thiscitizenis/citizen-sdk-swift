import Foundation

public struct LoginTransaction : JsonObject
{
    let TAG: String = "LoginTransaction: "
    
    public var id: String?
    
    public var username: String?
    
    public var token: String?
    
    public init() {}
    
    public init?(string: String) { return nil }
    
    public init?(jsonDictionary: [String: Any]) {
        guard let id = jsonDictionary["id"] as? String,
              let username = jsonDictionary["username"] as? String,
              let token = jsonDictionary["token"] as? String
            else {
                NSLog(TAG + ResourceError.jsonMissingRequiredFields.localizedDescription)
                return nil
        }
        
        self.id = id
        self.username = username
        self.token = token
    }
    
    public func toJson() -> String? {
        var dict: Dictionary = [String:Any]()
        
        if self.id != nil { dict["id"] = self.id! }
        if self.username != nil { dict["username"] = self.username! }
        if self.token != nil { dict["token"] = self.token! }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:jsonData, encoding:.utf8)
        } catch {
            NSLog(TAG + ResourceError.unableToConvertDictionaryToJson.localizedDescription)
            return nil
        }
    }
    
    public func toByteArray() -> [UInt8]? {
        if self.username != nil && self.token != nil {
            let combinedString: String = self.username! + self.token!
            return Array(combinedString.utf8)
        }
        
        return nil
    }
    
    public func toString() -> String? {
        if self.username != nil && self.token != nil {
            let combinedString: String = self.username! + self.token!
            return combinedString
        }
        
        return nil
    }
}
