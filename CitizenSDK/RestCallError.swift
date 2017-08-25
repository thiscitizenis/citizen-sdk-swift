import Foundation

public enum RestCallError: Error {
    case unableToDetermineMimeType
    case unableToDeseriliseJson
    case unableToConvertJsonToDictionary
    case unableToInitialiseJsonObject
    case invalidUrl
    case unsupportedMimeType
    case emptyResponse
    case unauthorised
    case notFound
    case httpError
}

extension RestCallError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .unableToDetermineMimeType:
                return NSLocalizedString("Unable to determine MIME type", comment: "RestCallError")
            case .unableToDeseriliseJson:
                return NSLocalizedString("Unable to deserialise JSON", comment: "RestCallError")
            case .unableToConvertJsonToDictionary:
                return NSLocalizedString("Unable to convert JSON to Dictionary", comment: "RestCallError")
            case .unableToInitialiseJsonObject:
                return NSLocalizedString("Unable to initialise JSON object", comment: "RestCallError")
            case .invalidUrl:
                return NSLocalizedString("Invalid URL", comment: "RestCallError")
            case .unsupportedMimeType:
                return NSLocalizedString("Unsupported MIME type", comment: "RestCallError")
            case .emptyResponse:
                return NSLocalizedString("Empty response", comment: "RestCallError")
            case .unauthorised:
                return NSLocalizedString("Unauthorised", comment: "RestCallError")
            case .notFound:
                return NSLocalizedString("Not found", comment: "RestCallError")
            case .httpError:
                return NSLocalizedString("HTTP error", comment: "RestCallError")
        }
    }
}
