import Foundation

public struct Phone : JsonObject
{
    let TAG: String = "Phone: "
    
    public var id: String?
    
    public var personId: String?
    
    public var countryCode: CountryCode?
    
    public var phoneNumber: String?
    
    public var smsConfirmCode: String?
    
    public var smsConfirmTime: String?
    
    public var smsConfirmed: Bool?
    
    public var phoneType: PhoneType?
    
    public mutating func formatPhoneNumber() {
        if self.phoneNumber != nil && self.countryCode != nil {
            self.phoneNumber = "+" + (self.countryCode?.description)! + self.phoneNumber!
        }
    }
    
    public init() {}
    
    public init?(string: String) { return nil }
    
    public init?(jsonDictionary: [String: Any]) {
        
        self.id = jsonDictionary["id"] as? String
        
        self.countryCode = CountryCode.fromOptionalString(constant: jsonDictionary["countryCode"] as? String)
        
        self.phoneNumber = jsonDictionary["phoneNumber"] as? String
        self.personId = jsonDictionary["personId"] as? String
        self.smsConfirmCode = jsonDictionary["smsConfirmCode"] as? String
        self.smsConfirmTime = jsonDictionary["smsConfirmTime"] as? String
        self.smsConfirmed = jsonDictionary["smsConfirmed"] as? Bool
        
        self.phoneType = PhoneType.fromOptionalString(constant: jsonDictionary["phoneType"] as? String)
    }
    
    public func toJson() -> String? {
        var dict: Dictionary = [String:Any]()
        
        if self.id != nil { dict["id"] = self.id }
        if self.personId != nil { dict["personId"] = self.personId! }
        if self.countryCode != nil { dict["countryCode"] = self.countryCode?.toString() }
        if self.phoneNumber != nil { dict["phoneNumber"] = self.phoneNumber! }
        if self.smsConfirmCode != nil { dict["smsConfirmCode"] = self.smsConfirmCode! }
        if self.smsConfirmTime != nil { dict["smsConfirmTime"] = self.smsConfirmTime! }
        if self.smsConfirmed != nil { dict["smsConfirmed"] = self.smsConfirmed! }
        if self.phoneType != nil { dict["phoneType"] = self.phoneType?.toString() }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:jsonData, encoding:.utf8)
        } catch {
            NSLog(TAG + ResourceError.unableToConvertDictionaryToJson.localizedDescription)
            return nil
        }
    }
}
