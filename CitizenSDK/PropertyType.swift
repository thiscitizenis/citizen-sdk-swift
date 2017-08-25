// Enums for Swift lack the following properties of their Java counterparts:
//
//   * No support for multiple enumeration types pointing to the same value
//   * No straightforward method to iterate through all types
//
// With these constraints in mind, the design below was used to support the
// following functionality:
//
//   * Allowing multiple enumeration types to point to the same value
//   * Have methods to iterate all enumeration types and their values
//   * Set an enumeration type from a string
//   * Export enumeration type and value as strings
//
// This currently requires that the enumeration items be listed twice, but there
// is a compiler check in the 'description' variable to ensure that all cases
// are covered.
//
// This design is used in most of the enumerations here to ensure consistency.

public enum PropertyType : Int
{
    case HOME_POST_CODE                          = 0
    case HOME_CITY                               = 1
    case HOME_ADDRESS1                           = 2
    case HOME_ADDRESS2                           = 3
    case HOME_ADDRESS3                           = 4
    case HOME_STATE                              = 5
    case HOME_COUNTRY_CODE                       = 6
    case FIRST_NAME                              = 7
    case MIDDLE_NAME                             = 8
    case LAST_NAME                               = 9
    case TITLE                                   = 10
    case PHONE                                   = 11
    case DOB                                     = 12
    case POB                                     = 13
    case NATIONALITY                             = 14
    case PROFILEPIC                              = 15
    case NAMESPACE                               = 16
    case REQUESTER_LAT                           = 17
    case REQUESTER_LNG                           = 18
    case RESPONDER_LAT                           = 19
    case RESPONDER_LNG                           = 20
    case SET_PHOTO_IDS                           = 21
    case SET_ADDRESS_VALIDATION_IDS              = 22
    case SIGNED_TOKEN_ID                         = 23
    case TOKEN_SIGNATURE_PUBLIC_KEY              = 24
    case TOKEN_SIGNATURE_VERIFICATION_RESULT     = 25
    case WEB_ACCESS_NONCE                        = 26
    case WEB_ACCESS_SIGNED_NONCE                 = 27
    case WEB_ACCESS_BROWSER_ECDH_PUB_KEY         = 28
    case WEB_ACCESS_SERVICE_ECDH_PUB_KEY         = 29
    case WEB_ACCESS_PHONE_ECDH_PUB_KEY           = 30
    case WEB_ACCESS_SERVICE_PASSPHRASE_CIPHER    = 31
    case WEB_ACCESS_SERVICE_PASSPHRASE_CIPHER_IV = 32
    case WEB_ACCESS_BROWSER_PASSPHRASE_CIPHER_IV = 33
    
    public var description: String {
        switch self {
            case .HOME_POST_CODE:                          return "HOME_POST_CODE"
            case .HOME_CITY:                               return "HOME_CITY"
            case .HOME_ADDRESS1:                           return "HOME_ADDRESS1"
            case .HOME_ADDRESS2:                           return "HOME_ADDRESS2"
            case .HOME_ADDRESS3:                           return "HOME_ADDRESS3"
            case .HOME_STATE:                              return "HOME_STATE"
            case .HOME_COUNTRY_CODE:                       return "HOME_COUNTRY_CODE"
            case .FIRST_NAME:                              return "FIRST_NAME"
            case .MIDDLE_NAME:                             return "MIDDLE_NAME"
            case .LAST_NAME:                               return "LAST_NAME"
            case .TITLE:                                   return "TITLE"
            case .PHONE:                                   return "PHONE"
            case .DOB:                                     return "DOB"
            case .POB:                                     return "POB"
            case .NATIONALITY:                             return "NATIONALITY"
            case .PROFILEPIC:                              return "PROFILEPIC"
            case .NAMESPACE:                               return "NAMESPACE"
            case .REQUESTER_LAT:                           return "REQUESTER_LAT"
            case .REQUESTER_LNG:                           return "REQUESTER_LNG"
            case .RESPONDER_LAT:                           return "RESPONDER_LAT"
            case .RESPONDER_LNG:                           return "RESPONDER_LNG"
            case .SET_PHOTO_IDS:                           return "SET_PHOTO_IDS"
            case .SET_ADDRESS_VALIDATION_IDS:              return "SET_ADDRESS_VALIDATION_IDS"
            case .SIGNED_TOKEN_ID:                         return "SIGNED_TOKEN_ID"
            case .TOKEN_SIGNATURE_PUBLIC_KEY:              return "TOKEN_SIGNATURE_PUBLIC_KEY"
            case .TOKEN_SIGNATURE_VERIFICATION_RESULT:     return "TOKEN_SIGNATURE_VERIFICATION_RESULT"
            case .WEB_ACCESS_NONCE:                        return "WEB_ACCESS_NONCE"
            case .WEB_ACCESS_SIGNED_NONCE:                 return "WEB_ACCESS_SIGNED_NONCE"
            case .WEB_ACCESS_BROWSER_ECDH_PUB_KEY:         return "WEB_ACCESS_BROWSER_ECDH_PUB_KEY"
            case .WEB_ACCESS_SERVICE_ECDH_PUB_KEY:         return "WEB_ACCESS_SERVICE_ECDH_PUB_KEY"
            case .WEB_ACCESS_PHONE_ECDH_PUB_KEY:           return "WEB_ACCESS_PHONE_ECDH_PUB_KEY"
            case .WEB_ACCESS_SERVICE_PASSPHRASE_CIPHER:    return "WEB_ACCESS_SERVICE_PASSPHRASE_CIPHER"
            case .WEB_ACCESS_SERVICE_PASSPHRASE_CIPHER_IV: return "WEB_ACCESS_SERVICE_PASSPHRASE_CIPHER_IV"
            case .WEB_ACCESS_BROWSER_PASSPHRASE_CIPHER_IV: return "WEB_ACCESS_BROWSER_PASSPHRASE_CIPHER_IV"
        }
    }
    
    public static func fromString(constant: String) -> PropertyType? {
        var i = 0
        while let enumItem = PropertyType(rawValue: i) {
            if String(describing: enumItem) == constant {
                return enumItem
            }
            i = i + 1
        }
        
        return nil
    }
    
    public static func fromOptionalString(constant: String?) -> PropertyType? {
        if constant == nil {
            return nil
        }
        
        var i = 0
        while let enumItem = PropertyType(rawValue: i) {
            if String(describing: enumItem) == constant! {
                return enumItem
            }
            i = i + 1
        }
        
        return nil
    }
    
    public func toString() -> String {
        return String(describing: self)
    }
    
    public static func allItems() -> [String] {
        var enumItems = [String]()
        var i = 0
        
        while let enumItem = PropertyType(rawValue: i) {
            enumItems.append(String(describing: enumItem))
            i = i + 1
        }
        
        return enumItems
    }
    
    public static func allDescriptions() -> [String] {
        var enumDescriptions = [String]()
        var i = 0
        
        while let enumItem = PropertyType(rawValue: i) {
            enumDescriptions.append(enumItem.description)
            i = i + 1
        }
        
        return enumDescriptions
    }
}
