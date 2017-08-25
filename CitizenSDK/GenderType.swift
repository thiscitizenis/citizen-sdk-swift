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

public enum GenderType : Int
{
    case MALE   = 0
    case FEMALE = 1
    
    var description: String {
        switch self {
            case .MALE:   return "MALE"
            case .FEMALE: return "FEMALE"
        }
    }
    
    public static func fromString(constant: String) -> GenderType? {
        var i = 0
        while let enumItem = GenderType(rawValue: i) {
            if String(describing: enumItem) == constant {
                return enumItem
            }
            i = i + 1
        }
        
        return nil
    }
    
    public static func fromOptionalString(constant: String?) -> GenderType? {
        if constant == nil {
            return nil
        }
        
        var i = 0
        while let enumItem = GenderType(rawValue: i) {
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
        
        while let enumItem = GenderType(rawValue: i) {
            enumItems.append(String(describing: enumItem))
            i = i + 1
        }
        
        return enumItems
    }
    
    public static func allDescriptions() -> [String] {
        var enumDescriptions = [String]()
        var i = 0
        
        while let enumItem = GenderType(rawValue: i) {
            enumDescriptions.append(enumItem.description)
            i = i + 1
        }
        
        return enumDescriptions
    }
}
