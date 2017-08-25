import Foundation

public struct CanIssueToken : JsonObject
{
    let TAG: String = "CanIssueToken: "
    
    public var numberOfNotConsideredOrMissedPhotoID: Int?
    
    public var numberOfNotConsideredOrMissedAddressValidations: Int?
    
    public var canIssueAddressValidation: Bool?
    
    public var canIssuePhotoID: Bool?
    
    public var unsatisfiedAccesses: [AccessType]?
    
    public init() {}
    
    public init?(string: String) { return nil }
    
    public init?(jsonDictionary: [String: Any]) {
        self.numberOfNotConsideredOrMissedPhotoID = jsonDictionary["numberOfNotConsideredOrMissedPhotoID"] as? Int
        
        self.numberOfNotConsideredOrMissedAddressValidations = jsonDictionary["numberOfNotConsideredOrMissedAddressValidations"] as? Int
        
        self.canIssueAddressValidation = jsonDictionary["canIssueAddressValidation"] as? Bool
        
        let unsatisfiedAccessesJson = jsonDictionary["unsatisfiedAccesses"] as? [String]
        if unsatisfiedAccessesJson != nil {
            var unsatisfiedAccesses: [AccessType] = []
            for unsatisfiedAccessJson in unsatisfiedAccessesJson! {
                let accessType = AccessType.fromString(constant: unsatisfiedAccessJson)
                if accessType != nil {
                    unsatisfiedAccesses.append(accessType!)
                }
            }
            self.unsatisfiedAccesses = unsatisfiedAccesses
        }
    }
    
    public func toJson() -> String? {
        var dict: Dictionary = [String:Any]()
        
        if self.numberOfNotConsideredOrMissedPhotoID != nil { dict["numberOfNotConsideredOrMissedPhotoID"] = self.numberOfNotConsideredOrMissedPhotoID! }
        if self.numberOfNotConsideredOrMissedAddressValidations != nil { dict["numberOfNotConsideredOrMissedAddressValidations"] = self.numberOfNotConsideredOrMissedAddressValidations! }
        if self.canIssueAddressValidation != nil { dict["canIssueAddressValidation"] = self.canIssueAddressValidation! }
        if self.canIssuePhotoID != nil { dict["canIssuePhotoID"] = self.canIssuePhotoID! }
        
        if self.unsatisfiedAccesses != nil {
            var accessTypleList: [String] = [String]()
            for accessType in self.unsatisfiedAccesses! {
                let accessTypeJson: String = accessType.toString()
                accessTypleList.append(accessTypeJson)
            }
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:jsonData, encoding:.utf8)
        } catch {
            NSLog(TAG + ResourceError.unableToConvertDictionaryToJson.localizedDescription)
            return nil
        }
    }
}
