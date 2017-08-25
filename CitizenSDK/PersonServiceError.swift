import Foundation

public enum PersonServiceError {
    case unableToConvertPersonObjectToJson
    case unableToConvertPhoneObjectToJson
    case unableToConvertAddressObjectToJson
    case personObjectMissingRequiredFields
    case phoneObjectMissingRequiredFields
}

extension PersonServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToConvertPersonObjectToJson:
            return NSLocalizedString("Unable to convert person object to JSON", comment: "PersonServiceError")
        case .unableToConvertPhoneObjectToJson:
            return NSLocalizedString("Unable to convert phone object to JSON", comment: "PersonServiceError")
        case .unableToConvertAddressObjectToJson:
            return NSLocalizedString("Unable to convert address object to JSON", comment: "PersonServiceError")
        case .personObjectMissingRequiredFields:
            return NSLocalizedString("Person object missing required fields", comment: "PersonServiceError")
        case .phoneObjectMissingRequiredFields:
            return NSLocalizedString("Phone object missing required fields", comment: "PersonServiceError")
        }
    }
}
