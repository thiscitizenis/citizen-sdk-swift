import Foundation

public enum TokenServiceError {
    case unableToConvertTokenObjectToJson
    case tokenObjectMissingRequiredFields
    case unableToGenerateWebLoginParameters
    case webAccessTokenHasNoMetaData
    case webAccessTokenBrowserPublicKeyMissing
    case webAccessTokenServicePublicKeyMissing
    case unableToGenerateWebLoginCryptoParameters
    case phoneECDHPublicKeyIsNotSet
    case servicePassphraseCipherIsNotSet
    case servicePassphraseCipherIvIsNotSet
    case browserPassphraseCipherIvIsNotSet
    
}

extension TokenServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .unableToConvertTokenObjectToJson:
                return NSLocalizedString("Unable to convert token object to JSON", comment: "TokenServiceError")
            case .tokenObjectMissingRequiredFields:
                return NSLocalizedString("Token object missing required fields", comment: "TokenServiceError")
            case .unableToGenerateWebLoginParameters:
                return NSLocalizedString("Unable to generate web login parameters", comment: "TokenServiceError")
            case .webAccessTokenHasNoMetaData:
                return NSLocalizedString("Web access token has no meta-data", comment: "TokenServiceError")
            case .webAccessTokenBrowserPublicKeyMissing:
                return NSLocalizedString("Web access token has no browser public key", comment: "TokenServiceError")
            case .webAccessTokenServicePublicKeyMissing:
                return NSLocalizedString("Web access token has no service public key", comment: "TokenServiceError")
            case .unableToGenerateWebLoginCryptoParameters:
                return NSLocalizedString("Unable to generate crypto parameters for web access token", comment: "TokenServiceError")
            case .phoneECDHPublicKeyIsNotSet:
                return NSLocalizedString("Phone ECDH public key is not set for web access token", comment: "TokenServiceError")
            case .servicePassphraseCipherIsNotSet:
                return NSLocalizedString("Service passphrase cipher is not set for web access token", comment: "TokenServiceError")
            case .servicePassphraseCipherIvIsNotSet:
                return NSLocalizedString("Service passphrase cipher IV is not set for web access token", comment: "TokenServiceError")
            case .browserPassphraseCipherIvIsNotSet:
                return NSLocalizedString("Browser passphrase cipher IV is not set for web access token", comment: "TokenServiceError")
        }
    }
}
