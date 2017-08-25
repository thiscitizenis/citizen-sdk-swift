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

public enum NameTitle : Int
{
    case MR  = 0
    case MRS = 1
    case MS  = 2
    case DR  = 3
    case SIR = 4
    
    public var description: String {
        switch self {
            case .MR:  return "Mr"
            case .MRS: return "Mrs"
            case .MS:  return "Ms"
            case .DR:  return "Dr"
            case .SIR: return "Sir"
        }
    }
    
    public static func fromString(constant: String) -> NameTitle? {
        var i = 0
        while let enumItem = NameTitle(rawValue: i) {
            if String(describing: enumItem) == constant {
                return enumItem
            }
            i = i + 1
        }
        
        return nil
    }
    
    public static func fromOptionalString(constant: String?) -> NameTitle? {
        if constant == nil {
            return nil
        }
        
        var i = 0
        while let enumItem = NameTitle(rawValue: i) {
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
        
        while let enumItem = NameTitle(rawValue: i) {
            enumItems.append(String(describing: enumItem))
            i = i + 1
        }
        
        return enumItems
    }
    
    public static func allDescriptions() -> [String] {
        var enumDescriptions = [String]()
        var i = 0
        
        while let enumItem = NameTitle(rawValue: i) {
            enumDescriptions.append(enumItem.description)
            i = i + 1
        }
        
        return enumDescriptions
    }
}
