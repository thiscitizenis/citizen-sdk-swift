import Foundation

public struct Token : JsonObject
{
    let TAG: String = "Token: "
    
    public var id: String?
    
    public var tokenStatus: TokenStatus?
    
    public var hashedUserEmail: String?
    
    public var userEmail: String?
    
    public var duration: Int?
    
    public var access: Int?
    
    public var imageId: String?
    
    public var durationType: TokenDurationType?
    
    public var expiryDate: Int?
    
    public var hashedRequesterEmail: String?
    
    public var requesterEmail: String?
    
    public var creationDate: Int?
    
    public var metaData: [PropertyType: Any]?
    
    
    public init() {}
    
    public init?(string: String) { return nil }
    
    public init?(jsonDictionary: [String: Any]) {
        guard let id = jsonDictionary["id"] as? String
            else {
                NSLog(TAG + ResourceError.jsonMissingRequiredFields.localizedDescription)
                return nil
        }
        
        self.id = id
        
        self.tokenStatus = TokenStatus.fromOptionalString(constant: jsonDictionary["tokenStatus"] as? String)
        
        self.hashedUserEmail = jsonDictionary["hashedUserEmail"] as? String
        self.userEmail = jsonDictionary["userEmail"] as? String
        self.duration = jsonDictionary["duration"] as? Int
        self.access = jsonDictionary["access"] as? Int
        self.imageId = jsonDictionary["imageId"] as? String
        
        self.durationType = TokenDurationType.fromOptionalString(constant: jsonDictionary["durationType"] as? String)
        
        self.expiryDate = jsonDictionary["expiryDate"] as? Int
        self.hashedRequesterEmail = jsonDictionary["hashedRequesterEmail"] as? String
        self.requesterEmail = jsonDictionary["requesterEmail"] as? String
        self.creationDate = jsonDictionary["creationDate"] as? Int
        
        if jsonDictionary["metaData"] != nil {
            guard let metaDataDict = jsonDictionary["metaData"] as? [String: Any]
                else {
                    NSLog(TAG + ResourceError.unableToCastMetaData.localizedDescription)
                    return nil
                }
        
            self.metaData = [PropertyType:String]()
            for (jsonKey, jsonValue) in metaDataDict {
                guard let key: PropertyType = PropertyType.fromString(constant: jsonKey)
                    else {
                        NSLog(TAG + ResourceError.unrecognisedPropertyType.localizedDescription + ": " + jsonKey)
                        return nil
                }
                self.metaData?[key] = jsonValue
            }
        }
    }
    
    public func toJson() -> String? {
        var dict: [String:Any] = [String:Any]()
        
        if self.id != nil { dict["id"] = self.id! }
        if self.tokenStatus != nil { dict["tokenStatus"] = self.tokenStatus?.toString() }
        if self.hashedUserEmail != nil { dict["hashedUserEmail"] = self.hashedUserEmail! }
        if self.userEmail != nil { dict["userEmail"] = self.userEmail! }
        if self.access != nil { dict["access"] = self.access! }
        if self.imageId != nil { dict["imageId"] = self.imageId! }
        if self.durationType != nil { dict["durationType"] = self.durationType?.toString() }
        if self.expiryDate != nil { dict["expiryDate"] = self.expiryDate }
        if self.hashedRequesterEmail != nil { dict["hashedRequesterEmail"] = self.hashedRequesterEmail! }
        if self.creationDate != nil { dict["creationDate"] = self.creationDate! }
        
        if self.metaData != nil {
            var metaDataDict: [String:Any] = [String:Any]()
            for (key, value) in self.metaData! {
                metaDataDict[key.toString()] = value
            }
            dict["metaData"] = metaDataDict
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:jsonData, encoding:.utf8)
        } catch {
            NSLog(TAG + ResourceError.unableToConvertDictionaryToJson.localizedDescription)
            return nil
        }
    }
    
    
    public func propertiesToJson() -> String? {
        if self.metaData == nil {
            return nil
        }
        
        var dict: [String:Any] = [String:Any]()
        
        for (key, value) in self.metaData! {
            dict[key.toString()] = value
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:jsonData, encoding:.utf8)
        } catch {
            NSLog(TAG + ResourceError.unableToConvertDictionaryToJson.localizedDescription)
            return nil
        }
    }

    
    public func getStringProperty(property: PropertyType) -> String? {
        if self.metaData == nil {
            return nil
        }
        
        guard let val = self.metaData?[property] as? String else {
            return nil
        }
        
        return val
    }
    
    
    public func getIntProperty(property: PropertyType) -> Int? {
        if self.metaData == nil {
            return nil
        }
        
        guard let val = self.metaData?[property] as? Int else {
            return nil
        }
        
        return val
    }
    
    
    public func getBoolProperty(property: PropertyType) -> Bool? {
        if self.metaData == nil {
            return nil
        }
        
        guard let val = self.metaData?[property] as? Bool else {
            return nil
        }
        
        return val
    }
    
    
    public mutating func setProperty (property: PropertyType, value: Any) -> Void {
        if self.metaData == nil {
            self.metaData = [PropertyType:Any]()
        }
        
        self.metaData![property] = value
    }
    
    
    static var MAX_DOCUMENTS_REQUEST: Int = 5
    
    static func getMaxRequestedAmountOfDocuments() -> Int {
        return Token.MAX_DOCUMENTS_REQUEST
    }
    
    public static func getRequestedAmountOfPhotoIDs(access: Int) -> Int {
        if AccessType.contains(access: access, accessType: AccessType.PHOTO_ID_1) {
            return 1
        }
        if AccessType.contains(access: access, accessType: AccessType.PHOTO_ID_2) {
            return 2
        }
        if AccessType.contains(access: access, accessType: AccessType.PHOTO_ID_3) {
            return 3
        }
        if AccessType.contains(access: access, accessType: AccessType.PHOTO_ID_4) {
            return 4
        }
        if AccessType.contains(access: access, accessType: AccessType.PHOTO_ID_5) {
            return 5
        }
        
        return 0
    }
    
    public static func getRequestedAmountOfAddresses(access: Int) -> Int {
        if AccessType.contains(access: access, accessType: AccessType.ADDRESS_VALID1) {
            return 1
        }
        if AccessType.contains(access: access, accessType: AccessType.ADDRESS_VALID2) {
            return 2
        }
        if AccessType.contains(access: access, accessType: AccessType.ADDRESS_VALID3) {
            return 3
        }
        if AccessType.contains(access: access, accessType: AccessType.ADDRESS_VALID4) {
            return 4
        }
        if AccessType.contains(access: access, accessType: AccessType.ADDRESS_VALID5) {
            return 5
        }
        
        return 0
    }
    
    public static func hasAccessToPhotoID(access: Int) -> Bool {
        let count: Int = Token.getRequestedAmountOfPhotoIDs(access: access)
        
        if count > 0 {
            return true
        }
        
        return false
    }
    
    public static func hasAccessToAddressValidation(access: Int) -> Bool {
        let count: Int = Token.getRequestedAmountOfAddresses(access: access)
        
        if count > 0 {
            return true
        }
        
        return false
    }
}
