import Foundation

public struct Address : JsonObject
{
    let TAG: String = "Address: "
    
    public var id: String?
    
    public var personId: String?
    
    public var addressLine1: String?
    
    public var addressLine2: String?
    
    public var addressLine3: String?
    
    public var city: String?

    public var state: String?
    
    public var countryName: CountryName?
    
    public var addressType: AddressType?
    
    public var postCode: String?
    
    public var validTo: String?
    
    public var validFrom: String?

    public var confirmCode: String?
    
    public var confirmedByCode: Bool?
    
    public var addressLatitude: String?
    
    public var addressLongitude: String?
    
    public var confirmedByLocation: Bool?
    
    public var confirmedLatitude: String?
    
    public var confirmedLongitude: String?
    
    public init() {}
    
    public init?(string: String) { return nil }
    
    public init?(jsonDictionary: [String: Any]) {
        
        self.id = jsonDictionary["id"] as? String
        self.personId = jsonDictionary["personId"] as? String
        self.addressLine1 = jsonDictionary["addressLine1"] as? String
        self.addressLine2 = jsonDictionary["addressLine2"] as? String
        self.addressLine3 = jsonDictionary["addressLine3"] as? String
        self.city = jsonDictionary["city"] as? String
        self.state = jsonDictionary["state"] as? String
        
        self.countryName = CountryName.fromOptionalString(constant: jsonDictionary["countryName"] as? String)
        
        self.addressType = AddressType.fromOptionalString(constant: jsonDictionary["addressType"] as? String)
        
        self.postCode = jsonDictionary["postCode"] as? String
        self.validTo = jsonDictionary["validTo"] as? String
        self.validFrom = jsonDictionary["validFrom"] as? String
        self.confirmCode = jsonDictionary["confirmCode"] as? String
        self.confirmedByCode = jsonDictionary["confirmedByCode"] as? Bool
        self.addressLatitude = jsonDictionary["addressLatitude"] as? String
        self.addressLongitude = jsonDictionary["addressLongitude"] as? String
        self.confirmedByLocation = jsonDictionary["confirmedByLocation"] as? Bool
        self.confirmedLatitude = jsonDictionary["confirmedLatitude"] as? String
        self.confirmedLongitude = jsonDictionary["confirmedLongitude"] as? String
    }
    
    public func toJson() -> String? {
        var dict: Dictionary = [String:Any]()
        
        if self.id != nil { dict["id"] = self.id! }
        if self.personId != nil { dict["personId"] = self.personId! }
        if self.addressLine1 != nil { dict["addressLine1"] = self.addressLine1! }
        if self.addressLine2 != nil { dict["addressLine2"] = self.addressLine2! }
        if self.addressLine3 != nil { dict["addressLine3"] = self.addressLine3! }
        if self.city != nil { dict["city"] = self.city! }
        if self.state != nil { dict["state"] = self.state! }
        if self.countryName != nil { dict["countryName"] = self.countryName?.toString() }
        if self.addressType != nil { dict["addressType"] = self.addressType?.toString() }
        if self.postCode != nil { dict["postCode"] = self.postCode! }
        if self.validTo != nil { dict["validTo"] = self.validTo! }
        if self.validFrom != nil { dict["validFrom"] = self.validFrom! }
        if self.confirmCode != nil { dict["confirmCode"] = self.confirmCode! }
        if self.confirmedByCode != nil { dict["confirmedByCode"] = self.confirmedByCode! }
        if self.addressLatitude != nil { dict["addressLatitude"] = self.addressLatitude! }
        if self.addressLongitude != nil { dict["addressLongitude"] = self.addressLongitude! }
        if self.confirmedByLocation != nil { dict["confirmedByLocation"] = self.confirmedByLocation! }
        if self.confirmedLatitude != nil { dict["confirmedLatitude"] = self.confirmedLatitude! }
        if self.confirmedLongitude != nil { dict["confirmedLongitude"] = self.confirmedLongitude! }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:jsonData, encoding:.utf8)
        } catch {
            NSLog(TAG + ResourceError.unableToConvertDictionaryToJson.localizedDescription)
            return nil
        }
    }
}
