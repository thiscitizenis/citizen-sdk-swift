import Foundation

public enum CryptoServiceError {
    case unableToSignLoginTransaction
    case unableToGenerateKeyForKeyChain
    case unableToGenerateAccessControl
    case unableToGenerateKeyPairFromSecureEnclave
    case unableToSavePublicKey
    case unableToGenerateDERFormatFromBytes
    case unableToGetPublicKeyData
    case unableToGetPrivateKeyData
    case unableToGetPrivateKeyFromKeyChain
    case unableToGetPrivateKeyFromSecureEnclave
    case unableToSignData
    case unableToCreatePublicKeyFromDERFormat
    case unableToVerifySignature
    case unableToStripHeaderFromKey
    case unableToGenerateECDHParameters
    case unableToGenerateSharedSecret
    case unableToGetPhonePublicKeyData
    case publicKeyXYStringHasIncorrectFormat
    case unableToConvertPublicKeyXYStringToUncompressedFormat
    case unableToGenerateECDHKeyPair
    case unableToGenerateWebLoginIVs
    case unableToEncryptUsingAES
    case uncompressedFormatHasIncorrectLength
    case uncompressedFormatHasInvaidType
}

extension CryptoServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToSignLoginTransaction:
            return NSLocalizedString("Unable to sign login transaction", comment: "CryptoServiceError")
        case .unableToGenerateKeyForKeyChain:
            return NSLocalizedString("Unable to generate key for key chain", comment: "CryptoServiceError")
        case .unableToGenerateAccessControl:
           return NSLocalizedString("Unable to generate access control", comment: "CryptoServiceError")
        case .unableToGenerateKeyPairFromSecureEnclave:
            return NSLocalizedString("Unable to get key pair from secure enclave", comment: "CryptoServiceError")
        case .unableToSavePublicKey:
            return NSLocalizedString("Unable to save public key", comment: "CryptoServiceError")
        case .unableToGenerateDERFormatFromBytes:
            return NSLocalizedString("Unable to generate DER format from bytes", comment: "CryptoServiceError")
        case .unableToGetPublicKeyData:
            return NSLocalizedString("Unable to get public key data", comment: "CryptoServiceError")
        case .unableToGetPrivateKeyData:
            return NSLocalizedString("Unable to get private key data", comment: "CryptoServiceError")
        case .unableToGetPrivateKeyFromKeyChain:
            return NSLocalizedString("Unable to get private key from key chain", comment: "CryptoServiceError")
        case .unableToGetPrivateKeyFromSecureEnclave:
            return NSLocalizedString("Unable to get private key from secure enclave", comment: "CryptoServiceError")
        case .unableToSignData:
            return NSLocalizedString("Unable to sign data", comment: "CryptoServiceError")
        case .unableToCreatePublicKeyFromDERFormat:
            return NSLocalizedString("Unable to create public key from DER format", comment: "CryptoServiceError")
        case .unableToVerifySignature:
            return NSLocalizedString("Unable to verify signature", comment: "CryptoServiceError")
        case .unableToStripHeaderFromKey:
            return NSLocalizedString("Unable to strip header from key", comment: "CryptoServiceError")
        case .unableToGenerateECDHParameters:
            return NSLocalizedString("Unable to generate ECDH parameters", comment: "CryptoServiceError")
        case .unableToGenerateSharedSecret:
            return NSLocalizedString("Unable to generate shared secret", comment: "CryptoServiceError")
        case .unableToGetPhonePublicKeyData:
            return NSLocalizedString("Unable to get phone public key data", comment: "CryptoServiceError")
        case .publicKeyXYStringHasIncorrectFormat:
            return NSLocalizedString("Public key XY string has incorrect format", comment: "CryptoServiceError")
        case .unableToConvertPublicKeyXYStringToUncompressedFormat:
            return NSLocalizedString("Unable to convert public key XY string to uncompressed format", comment: "CryptoServiceError")
        case .unableToGenerateECDHKeyPair:
            return NSLocalizedString("Unable to generate ECDH key pair", comment: "CryptoServiceError")
        case .unableToGenerateWebLoginIVs:
            return NSLocalizedString("Unable to generate web login IVs", comment: "CryptoServiceError")
        case .unableToEncryptUsingAES:
            return NSLocalizedString("Unable to encrypt using AES", comment: "CryptoServiceError")
        case .uncompressedFormatHasIncorrectLength:
            return NSLocalizedString("Uncompressed format has invalid length", comment: "CryptoServiceError")
        case .uncompressedFormatHasInvaidType:
            return NSLocalizedString("Uncompressed fromat has invalid type", comment: "CryptoServiceError")
        }
    }
}
