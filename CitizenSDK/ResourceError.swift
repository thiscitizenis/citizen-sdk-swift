import Foundation

public enum ResourceError {
    case jsonMissingRequiredFields
    case unableToCastMetaData
    case unrecognisedPropertyType
    case unableToParseEmailList
    case unableToConvertDictionaryToJson
}

extension ResourceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .jsonMissingRequiredFields:
                return NSLocalizedString("JSON object missing required field", comment: "ResourceError")
            case .unableToCastMetaData:
                return NSLocalizedString("unable to cast meta data", comment: "ResourceError")
            case .unrecognisedPropertyType:
                return NSLocalizedString("unrecognised property type", comment: "ResourceError")
            case .unableToParseEmailList:
                return NSLocalizedString("unable to parse email list", comment: "ResourceError")
            case .unableToConvertDictionaryToJson:
                return NSLocalizedString("unable to convert dictionary to JSON", comment: "ResourceError")
        }
    }
}
