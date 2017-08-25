public enum AccessType : Int
{
    case NAME            = 0b00000000000000000000000000000001 // 1 << 0
    case DOB             = 0b00000000000000000000000000000010 // 1 << 1
    case POB             = 0b00000000000000000000000000000100 // 1 << 2
    case NATIONALITY     = 0b00000000000000000000000000001000 // 1 << 3
    case ADDRESS         = 0b00000000000000000000000000010000 // 1 << 4
    case PHONE           = 0b00000000000000000000000000100000 // 1 << 5
    
    case WEB_ACCESS      = 0b00000000000000000000010000000000 // 1 << 10
    
    case TOKEN_SIGNATURE = 0b00000000000000000001000000000000 // 1 << 12
    
    case DISTANCE_10KM   = 0b00000000000000000100000000000000 // 1 << 14
    
    case PHOTO_ID_1      = 0b00000000000000100000000000000000 // 1 << 17
    case PHOTO_ID_2      = 0b00000000000001000000000000000000 // 1 << 18
    case PHOTO_ID_3      = 0b00000000000010000000000000000000 // 1 << 19
    case PHOTO_ID_4      = 0b00000000000100000000000000000000 // 1 << 20
    case PHOTO_ID_5      = 0b00000000001000000000000000000000 // 1 << 21
    
    case ADDRESS_VALID1  = 0b00000100000000000000000000000000 // 1 << 26
    case ADDRESS_VALID2  = 0b00001000000000000000000000000000 // 1 << 27
    case ADDRESS_VALID3  = 0b00010000000000000000000000000000 // 1 << 28
    case ADDRESS_VALID4  = 0b00100000000000000000000000000000 // 1 << 29
    case ADDRESS_VALID5  = 0b01000000000000000000000000000000 // 1 << 30
    
    static let allAccessTypes =
        [
            NAME,
            DOB,
            POB,
            NATIONALITY,
            ADDRESS,
            PHONE,
            WEB_ACCESS,
            TOKEN_SIGNATURE,
            DISTANCE_10KM,
            PHOTO_ID_1,
            PHOTO_ID_2,
            PHOTO_ID_3,
            PHOTO_ID_4,
            PHOTO_ID_5,
            ADDRESS_VALID1,
            ADDRESS_VALID2,
            ADDRESS_VALID3,
            ADDRESS_VALID4,
            ADDRESS_VALID5
        ]
    
    public static func fromString(constant: String) -> AccessType? {
        var i = 0
        while let enumItem = AccessType(rawValue: i) {
            if String(describing: enumItem) == constant {
                return enumItem
            }
            i = i + 1
        }
        
        return nil
    }
    
    public static func fromOptionalString(constant: String?) -> AccessType? {
        if constant == nil {
            return nil
        }
        
        var i = 0
        while let enumItem = AccessType(rawValue: i) {
            if String(describing: enumItem) == constant! {
                return enumItem
            }
            i = i + 1
        }
        
        return nil
    }

    public static func contains(access: Int, accessType: AccessType) -> Bool {
        if access & accessType.rawValue > 0 {
            return true
        }
        
        return false
    }
    
    public static func add(access: Int, accessType: AccessType) -> Int {
        if access & accessType.rawValue > 0 {
            return access
        }
        
        return access + accessType.rawValue
    }
    
    public static func remove(access: Int, accessType: AccessType) -> Int {
        if access & accessType.rawValue > 0 {
            return access - accessType.rawValue
        }
        
        return access
    }
    
    public static func all() -> Int {
        var val: Int = 0
        for accessType in allAccessTypes {
            val = val + accessType.rawValue
        }
        
        return val
    }
    
    public static func none() -> Int {
        return 0
    }
    
    public static func verify(access: Int) -> Bool {
        if access < 0 {
            return false
        }
        
        var checkAccessTypes = access
        for accessType in allAccessTypes {
            if checkAccessTypes & accessType.rawValue > 0 {
                checkAccessTypes = checkAccessTypes - accessType.rawValue
            }
        }
        
        if checkAccessTypes != 0 {
            return false
        }
        
        return true
    }
    
    public func toString() -> String {
        return String(describing: self)
    }
    
    public static func toString(access: Int) -> String {
        var accessString: String = ""
        
        for accessType in allAccessTypes {
            if access & accessType.rawValue > 0 {
                if accessString.characters.count == 0 {
                    accessString = String(describing: accessType)
                } else {
                    accessString = accessString + "," + String(describing: accessType)
                }
            }
        }
        
        return accessString
    }
}
