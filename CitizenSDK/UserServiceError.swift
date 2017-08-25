import Foundation

public enum UserServiceError {
    case unableToConvertUserObjectToJson
    case unableToConvertLoginTransactionObjectToJson
    case userObjectMissingRequiredFields
}

extension UserServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .unableToConvertUserObjectToJson:
                return NSLocalizedString("Unable to convert user object to JSON", comment: "UserServiceError")
            case .unableToConvertLoginTransactionObjectToJson:
                return NSLocalizedString("Unable to convert login transaction object to JSON", comment: "UserServiceError")
            case .userObjectMissingRequiredFields:
                return NSLocalizedString("User object missing required fields", comment: "UserServiceError")
        }
    }
}
