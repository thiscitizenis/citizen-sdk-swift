import Foundation

public struct Name : JsonObject
{
    let TAG: String = "Name: "
    
    public var title: String?
    
    public var firstName: String?
    
    public var lastName: String?
    
    public var middleName: String?
    
    public var gender: String?
    
    public init() {}
    
    public init?(string: String) { return nil }
    
    public init?(jsonDictionary: [String: Any]) {
        guard let firstName = jsonDictionary["firstName"] as? String,
              let lastName = jsonDictionary["lastName"] as? String
        else {
            NSLog(TAG + ResourceError.jsonMissingRequiredFields.localizedDescription)
            return nil
        }
        
        self.firstName = firstName
        self.lastName = lastName
        
        self.title = jsonDictionary["title"] as? String
        self.middleName = jsonDictionary["middleName"] as? String
        self.gender = jsonDictionary["gender"] as? String
    }
    
    public func toJson() -> String? {
        var dict: Dictionary = [String:Any]()
        
        if self.title != nil { dict["title"] = self.title! }
        if self.firstName != nil { dict["firstName"] = self.firstName! }
        if self.middleName != nil { dict["middleName"] = self.middleName! }
        if self.lastName != nil { dict["lastName"] = self.lastName! }
        if self.gender != nil { dict["gender"] = self.gender! }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:jsonData, encoding:.utf8)
        } catch {
            NSLog(TAG + ResourceError.unableToConvertDictionaryToJson.localizedDescription)
            return nil
        }
    }
}
