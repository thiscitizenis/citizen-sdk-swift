import Foundation

public struct Person : JsonObject
{
    let TAG: String = "Person: "
    
    public var id: String?
    
    public var title: String?
    
    public var firstName: String?
    
    public var middleName: String?
    
    public var lastName: String?
    
    public var gender: String?
    
    public var dateOfBirth: Date?
    
    public var placeOfBirth: String?
    
    public var countryNationality: CountryName?
    
    public var profilePicId: String?
    
    public var phone: Phone?
    
    public var address: Address?
    
    public var addressHistory: [Address]?
    
    public var entityId: String?
    
    public init() {}
    
    public init?(string: String) { return nil }
    
    public init?(jsonDictionary: [String: Any]) {
        guard let id = jsonDictionary["id"] as? String
            else {
                NSLog(TAG + ResourceError.jsonMissingRequiredFields.localizedDescription)
                return nil
        }
        
        self.id = id
        
        self.title = jsonDictionary["title"] as? String
        self.firstName = jsonDictionary["firstName"] as? String
        self.middleName = jsonDictionary["middleName"] as? String
        self.lastName = jsonDictionary["lastName"] as? String
        self.gender = jsonDictionary["gender"] as? String
        
        self.dateOfBirth = DateUtils.importFromJodaOptionalString(jodaString: jsonDictionary["dateOfBirth"] as? String)
        
        self.countryNationality = CountryName.fromOptionalString(constant: jsonDictionary["countryNationality"] as? String)
        
        self.profilePicId = jsonDictionary["profilePicId"] as? String
        
        if jsonDictionary["phone"] != nil {
            let phoneJsonDictionary: [String: Any]? = jsonDictionary["phone"] as? [String: Any]
            if phoneJsonDictionary != nil {
                self.phone = Phone(jsonDictionary: phoneJsonDictionary!)
            }
        }
        
        if jsonDictionary["address"] != nil {
            let addressJsonDictionary: [String: Any]? = jsonDictionary["address"] as? [String: Any]
            if addressJsonDictionary != nil {
                self.address = Address(jsonDictionary: addressJsonDictionary!)
            }
        }
        
        if jsonDictionary["addressHistory"] != nil {
            let addressHistoryList: [[String: Any]]? = jsonDictionary["addressHistory"] as? [[String: Any]]
            if addressHistoryList != nil {
                var addressHistory: [Address] = []
                for addressJson in addressHistoryList! {
                    let address: Address? = Address(jsonDictionary: addressJson)
                    if address != nil {
                        addressHistory.append(address!)
                    }
                }
                self.addressHistory = addressHistory
                
            }
        }
        
        self.entityId = jsonDictionary["entityId"] as? String
    }
    
    public func toJson() -> String? {
        var dict: Dictionary = [String:Any]()
        
        if self.id != nil { dict["id"] = self.id! }
        if self.title != nil { dict["title"] = self.title! }
        if self.firstName != nil { dict["firstName"] = self.firstName! }
        if self.middleName != nil { dict["middleName"] = self.middleName! }
        if self.lastName != nil { dict["lastName"] = self.lastName! }
        if self.gender != nil { dict["gender"] = self.gender! }
        
        if self.dateOfBirth != nil { dict["dateOfBirth"] = DateUtils.exportToJodaString(date: self.dateOfBirth!) }
        
        if self.placeOfBirth != nil { dict["placeOfBirth"] = self.placeOfBirth! }
        
        if self.countryNationality != nil { dict["countryNationality"] = countryNationality?.toString() }
        
        if self.profilePicId != nil { dict["profilePicId"] = self.profilePicId! }
        
        if self.phone != nil { dict["phone"] = self.phone?.toJson() }
        
        if self.address != nil { dict["address"] = self.address?.toJson() }
        
        if self.addressHistory != nil {
            var addressHistoryList: [String] = [String]()
            for address in self.addressHistory! {
                let addressJson = address.toJson()
                if addressJson != nil {
                    addressHistoryList.append(addressJson!)
                }
            }
            if addressHistoryList.count > 0 {
                dict["addressHistory"] = addressHistoryList
            }
        }
        
        if self.entityId != nil { dict["entityId"] = self.entityId! }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:jsonData, encoding:.utf8)
        } catch {
            NSLog(TAG + ResourceError.unableToConvertDictionaryToJson.localizedDescription)
            return nil
        }
    }
}
