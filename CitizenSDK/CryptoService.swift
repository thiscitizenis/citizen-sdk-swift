import Foundation
import CommonCrypto


@available(iOS 10.0, *)

public class CryptoService: NSObject
{
    let TAG: String = "CryptoService: "

    private let publicLabel = "is.citizen.key.public"
    private let privateLabel = "is.citizen.key.private"
    private let ecdhKeyName = ".tmp.ecdh"
    private let fingerprintPrompt = "Authenticate with Fingerprint"
    
    private let exportImportManager = CryptoExportImportManager()
    private var secureEnclaveHelper: SecureEnclaveHelper

  
    public override init() {
        secureEnclaveHelper = SecureEnclaveHelper(publicLabel: self.publicLabel,
                                                  privateLabel: self.privateLabel,
                                                  operationPrompt: self.fingerprintPrompt)
    }
    
    func getKeyType() -> String {
        return kSecAttrKeyTypeEC as String
    }
  
    
    func getKeyLength() -> Int {
        return 256 // EC key length
    }
  
    
    func generateKeysForKeychain() -> String? {
        let keyType = getKeyType()
        if let publicKeyData = getPublicKeyData(publicLabel + keyType) {
            return self.exportKeyFromRawBytes(rawBytes: publicKeyData)
        } else {
            let pubKeyData: Data? = createSecureKeyPair(keyTag: keyType)
            if pubKeyData != nil {
                return self.exportKeyFromRawBytes(rawBytes: pubKeyData!)
            } else {
                NSLog(TAG + CryptoServiceError.unableToGenerateKeyForKeyChain.localizedDescription)
            }
        }
        return nil
    }
    
    
    func generateKeysForSecureEnclave() -> String? {
        
        if let publicKeyRef = try? self.secureEnclaveHelper.getPublicKey() {
                return exportKeyFromRawBytes(rawBytes: publicKeyRef.data)
        } else {
            // Create the key.
            let accessControl = try? secureEnclaveHelper.accessControl(with: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
            
            if accessControl == nil {
                NSLog(TAG + CryptoServiceError.unableToGenerateAccessControl.localizedDescription)
                return nil
            }
        
            let keypairResult = try? secureEnclaveHelper.generateKeyPair(accessControl: accessControl!)
            
            if keypairResult == nil {
                NSLog(TAG + CryptoServiceError.unableToGenerateKeyPairFromSecureEnclave.localizedDescription)
                return nil
            }
            
            if ((try? secureEnclaveHelper.forceSavePublicKey((keypairResult?.public)!)) == nil) {
                NSLog(TAG + CryptoServiceError.unableToSavePublicKey.localizedDescription)
                return nil
            }
            
            if let encodedPublicKey = try? exportKeyFromRawBytes(rawBytes: secureEnclaveHelper.getPublicKey().data) {
                NSLog(TAG + CryptoServiceError.unableToGenerateDERFormatFromBytes.localizedDescription)
                return encodedPublicKey
            }
            
            return nil
        }
    }
    
    
    public func generateKeys() -> String? {
        if Constant.CITIZEN_USE_SECURE_ENCLAVE {
            return generateKeysForSecureEnclave()
        } else {
            return generateKeysForKeychain()
        }
    }
    
    
    func exportKeyFromRawBytes(rawBytes: Data) -> String? {
        let keyType = getKeyType()
        let keySize = getKeyLength()
        if let exportableDERKey = exportImportManager.exportPublicKeyToDER(rawBytes, keyType: keyType, keySize: keySize) {
      
            let encodedKey = exportableDERKey.base64EncodedString(options: [])
      
            return encodedKey
        } else {
            NSLog(TAG + CryptoServiceError.unableToGenerateDERFormatFromBytes.localizedDescription)
            return nil
        }
    }
  
    
    func getPublicKeyData(_ keyTag: String) -> Data? {
        let parameters = [
            kSecClass as String: kSecClassKey,
            kSecAttrKeyType as String: getKeyType(),
            kSecAttrKeyClass as String: kSecAttrKeyClassPublic,
            kSecAttrApplicationTag as String: keyTag,
            kSecReturnData as String: true
        ] as [String : Any]
        var data: AnyObject?
        let status = SecItemCopyMatching(parameters as CFDictionary, &data)
        if status == errSecSuccess {
            return data as? Data
        } else {
            NSLog(TAG + CryptoServiceError.unableToGetPublicKeyData.localizedDescription)
            return nil
        }
    }
  
    
    func createSecureKeyPair(keyTag: String) -> Data? {
        // let access =
        //     SecAccessControlCreateWithFlags(kCFAllocatorDefault,
        //                                      kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
        //                                      .privateKeyUsage,
        //                                      nil)!
    
        // private key parameters
        let privateKeyParams: [String: AnyObject] = [
            kSecAttrIsPermanent as String: true as AnyObject,
            kSecAttrApplicationTag as String: (self.privateLabel + keyTag) as AnyObject,
            // kSecAttrAccessControl as String:  access
        ]
    
        // public key parameters
        let publicKeyParams: [String: AnyObject] = [
            kSecAttrIsPermanent as String: true as AnyObject,
            kSecAttrApplicationTag as String: (publicLabel + keyTag) as AnyObject
        ]
    
        // global parameters for our key generation
        let parameters: [String: AnyObject] = [
            kSecAttrKeyType as String:          getKeyType() as AnyObject,
            kSecAttrKeySizeInBits as String:    getKeyLength() as AnyObject,
            // kSecAttrTokenID as String:          kSecAttrTokenIDSecureEnclave,
            kSecAttrTokenID as String:          kSecAttrTokenIDSecureEnclave,
            kSecPublicKeyAttrs as String:       publicKeyParams as AnyObject,
            kSecPrivateKeyAttrs as String:      privateKeyParams as AnyObject
        ]
    
        var pubKey, privKey: SecKey?
        let status = SecKeyGeneratePair(parameters as CFDictionary, &pubKey, &privKey)
        if status == errSecSuccess {
            let publicKeyData = self.getPublicKeyData(self.publicLabel + self.getKeyType())
            return publicKeyData
        } else {
            NSLog(TAG + CryptoServiceError.unableToGenerateKeyForKeyChain.localizedDescription)
            return nil
        }
    }

  
    func signStringWithPrivateKeyFromKeychain(value: String) -> String? {
        
        guard let privateKey = getPrivateKeyFromKeyChain() else {
            NSLog("Unable to get private key")
            return nil
        }
  
        let digest = CC.digest(value.data(using: String.Encoding.utf8)!, alg: .sha256)
        
        let signed = try? CC.EC.signHash(privateKey, hash: digest)

        if (signed != nil) {
            return signed?.base64EncodedString()
        } else {
            NSLog(TAG + CryptoServiceError.unableToSignData.localizedDescription)
            return nil
        }
    }
    
    
    func signStringWithPrivateKeyFromEnclave(value: String) -> String? {
        
        let privateKey = getPrivateKeyFromSecureEnclave()
        
        if privateKey == nil {
            NSLog(TAG + CryptoServiceError.unableToGetPrivateKeyFromSecureEnclave.localizedDescription)
            return nil
        }
        
        let digest = CC.digest(value.data(using: String.Encoding.utf8)!, alg: .sha256)
        
        let signed = try? self.secureEnclaveHelper.sign(digest, privateKey: privateKey!)
        
        if (signed != nil) {
            return signed?.base64EncodedString()
        } else {
            NSLog(TAG + CryptoServiceError.unableToSignData.localizedDescription)
            return nil
        }
    }
    
    
    public func signString(value: String) -> String? {
        if Constant.CITIZEN_USE_SECURE_ENCLAVE {
            return signStringWithPrivateKeyFromEnclave(value: value)
        } else {
            return signStringWithPrivateKeyFromKeychain(value: value)
        }
    }
    
    
    public func signLoginTransaction(username: String, token: String) -> String? {
        
        var loginTransaction: LoginTransaction = LoginTransaction()
        loginTransaction.username = username
        loginTransaction.token = token
        
        let stringToSign: String? = loginTransaction.toString()
        
        if stringToSign != nil {
            return signString(value: stringToSign!)
        }
        
        NSLog(TAG + CryptoServiceError.unableToSignLoginTransaction.localizedDescription)
        return nil
    }
  
    
    func getPrivateKeyFromKeyChain() -> Data? {
        let parameters = [
            kSecClass as String: kSecClassKey,
            kSecAttrKeyType as String: getKeyType(),
            kSecAttrKeyClass as String: kSecAttrKeyClassPrivate,
            kSecAttrApplicationTag as String: self.privateLabel + self.getKeyType(),
            kSecReturnData as String: true
        ] as [String : Any]
        var data: AnyObject?
        let status = SecItemCopyMatching(parameters as CFDictionary, &data)
        if status == errSecSuccess {
            return data as? Data
        } else {
            NSLog(TAG + CryptoServiceError.unableToGetPrivateKeyFromKeyChain.localizedDescription)
            return nil
        }
    }
    
    
    func getPrivateKeyFromSecureEnclave() -> SecureEnclaveKeyReference? {
        
        let privateKey = try? self.secureEnclaveHelper.getPrivateKey()
        
        if privateKey == nil {
            NSLog(TAG + CryptoServiceError.unableToGetPrivateKeyFromSecureEnclave.localizedDescription)
            return nil
        }
        
        return privateKey!
    }
    
    
    public func verifySignature(publicKey: String, value: String, signature: String) -> Bool? {
        do {
            if let publicKeyDataDER = Data(base64Encoded: publicKey) {
                let publicKeyDataRaw = stripKeyHeader(keyData: publicKeyDataDER)
                let hash = CC.digest(value.data(using: String.Encoding.utf8)!, alg: .sha256)
                let verified: Bool = try CC.EC.verifyHash(publicKeyDataRaw, hash: hash, signedData: Data(base64Encoded: signature)!)
                return verified
            } else {
                NSLog(TAG + CryptoServiceError.unableToGenerateDERFormatFromBytes.localizedDescription)
                return nil
            }
        } catch {
            NSLog(TAG + CryptoServiceError.unableToVerifySignature.localizedDescription)
            return nil
        }
    }
  
  
    func stripKeyHeader(keyData: Data) -> Data {
    
        let node: Asn1Parser.Node
        do {
            node = try Asn1Parser.parse(data: keyData)
        } catch {
            NSLog(TAG + CryptoServiceError.unableToStripHeaderFromKey.localizedDescription)
            return Data()
            //throw SwiftyRSAError.asn1ParsingFailed
        }
    
        // Ensure the raw data is an ASN1 sequence
        guard case .sequence(let nodes) = node
            else {
                NSLog(TAG + CryptoServiceError.unableToStripHeaderFromKey.localizedDescription)
                return Data()
                //throw SwiftyRSAError.invalidAsn1RootNode
        }
    
        // Detect whether the sequence only has integers, in which case it's a headerless key
        let onlyHasIntegers = nodes.filter { node -> Bool in
            if case .integer(_) = node { // swiftlint:disable:this unused_optional_binding
                return false
            }
            return true
        }.isEmpty
    
        // Headerless key
        if onlyHasIntegers {
            return keyData
        }
    
        // If last element of the sequence is a bit string, return its data
        if let last = nodes.last, case .bitString(let data) = last {
            return data
        }
    
        // If last element of the sequence is an octet string, return its data
        if let last = nodes.last, case .octetString(let data) = last {
            return data
        }
    
        // Unable to extract bit/octet string or raw integer sequence
        //throw SwiftyRSAError.invalidAsn1Structure
        NSLog(TAG + CryptoServiceError.unableToStripHeaderFromKey.localizedDescription)
        return Data()
    }
  
    
    func generateEcdhKeyAndSecret(passPhrase: String, browserEcdhPublicKeyCoordinates: String, serviceEcdhPublicKeyCoordinates: String) -> WebLoginPhoneParameters? {
        
        if getNamedPublicKeyData(self.publicLabel + self.ecdhKeyName) != nil {
            deleteNamedKey(self.publicLabel + self.ecdhKeyName)
            deleteNamedKey(self.privateLabel + self.ecdhKeyName)
        }
        
        let ecdhPublicKeyData = createNonEnclaveECDHKeyPair(keyTag: self.ecdhKeyName)
        
        if ecdhPublicKeyData != nil {
            let webLoginParameters = generateSecrets(passPhrase: passPhrase, phoneEcdhPublicKeyData:  ecdhPublicKeyData!, browserEcdhPublicKeyCoordinates:  browserEcdhPublicKeyCoordinates, serviceEcdhPublicKeyCoordinates: serviceEcdhPublicKeyCoordinates)
            
            return webLoginParameters
        }
        
        NSLog(TAG + CryptoServiceError.unableToGenerateECDHParameters.localizedDescription)
        return nil
    }
  
    
    func generateSecrets(passPhrase: String, phoneEcdhPublicKeyData: Data?, browserEcdhPublicKeyCoordinates: String, serviceEcdhPublicKeyCoordinates: String) -> WebLoginPhoneParameters? {
    
        if phoneEcdhPublicKeyData != nil {
    
            //We have to turn the browser and service public kets from an x/y coordinate format into an uncompressed format (Which is how swift wants them)
            let browserUncompressedFormatBytes = getUncompressedFormat(ecdhPublicKeyCoordinates: browserEcdhPublicKeyCoordinates)
            let serviceUncompressedFormatBytes = getUncompressedFormat(ecdhPublicKeyCoordinates: serviceEcdhPublicKeyCoordinates)
    
            let phoneEcdhPrivateKey = self.getNamedPrivateKey(self.privateLabel + self.ecdhKeyName)
      
            if (phoneEcdhPrivateKey == nil) {
                NSLog(TAG + CryptoServiceError.unableToGetPrivateKeyFromKeyChain.localizedDescription)
            } else {
                do {
                    //these shared secrets are not in the correct form. We need to convert them into a hex string then back to a data object. We do this in the encryptWithAESKeys function
                    let browserSharedSecret = try CC.EC.computeSharedSecret(phoneEcdhPrivateKey!, publicKey:browserUncompressedFormatBytes!)
                    let serviceSharedSecret = try CC.EC.computeSharedSecret(phoneEcdhPrivateKey!, publicKey:serviceUncompressedFormatBytes!)
        
                    return encryptWithAESKeys(passPhrase: passPhrase, browserSharedSecret: browserSharedSecret, serviceSharedSecret: serviceSharedSecret, phoneEcdhPublicKeyData: phoneEcdhPublicKeyData!)
        
                } catch {
                    NSLog(TAG + CryptoServiceError.unableToGenerateSharedSecret.localizedDescription + " \(error)")
                    return nil
                }
            }
        } else {
            NSLog(TAG + CryptoServiceError.unableToGetPhonePublicKeyData.localizedDescription)
        }
        
        NSLog(TAG + CryptoServiceError.unableToGenerateSharedSecret.localizedDescription)
        return nil
    }
  
    
    func getUncompressedFormat(ecdhPublicKeyCoordinates: String) -> Data? {
        let publicKeyStringCoordinateLength: Int = 96
    
        // Import the public key from XY coordinte string to uncompressed format.
        //
        // Uncompressed format for a P-384 public key looks like the following
        //
        //   0x04{384 bit X coordinate}{384 bit Y coordinate}
        //
        // The public key is passed as a string which as the following format:
        //
        //   x{X coordinate hex chars}y{Y coordinate hex chars}
        //
        // Both the X and Y coordinates should be 96 chars long, but may be missing
        // leading zeroes - these must be added if needed.
    
        let prefixString: String = "04"
    
        var coordinateArray: Array = Array(ecdhPublicKeyCoordinates.characters)
        var xi: Int = 0
        var yi: Int = 0
    
        // Get the location of the 'x' and 'y' chars in the public key string, which
        // mark the start of the X and Y coordinates respectively.
    
        for i in 0...(coordinateArray.count - 1) {
            if (coordinateArray[i] == "x") {
                xi = i
            } else if (coordinateArray[i] == "y") {
                yi = i
            }
        }
    
        if (!(xi == 0 && yi > xi + 2 && yi < (coordinateArray.count - 2))) {
            NSLog(TAG + CryptoServiceError.publicKeyXYStringHasIncorrectFormat.localizedDescription)
            return nil
        }
    
        var xArray: Array = Array(coordinateArray[(xi + 1)...(yi - 1)])
        var yArray: Array = Array(coordinateArray[(yi + 1)...(coordinateArray.count - 1)])
    
        // Prepend any leading zeroes if needed.
    
        var i: Int
    
        i = 0
        while (i < (publicKeyStringCoordinateLength - xArray.count)) {
            xArray = ["0"] + xArray
        }
    
        i = 0
        while (i < (publicKeyStringCoordinateLength - yArray.count)) {
            yArray = ["0"] + yArray
        }
    
        let uncompressedFormatString: String = prefixString + String(xArray + yArray)
    
        let uncompressedFormatBytes: Data? = hexDataFromString(hexString: uncompressedFormatString)
    
        if (uncompressedFormatBytes == nil) {
            NSLog(TAG + CryptoServiceError.unableToConvertPublicKeyXYStringToUncompressedFormat.localizedDescription)
            return nil
        }
    
        return uncompressedFormatBytes
    }
  
    
    func createNonEnclaveECDHKeyPair(keyTag: String) -> Data? {
    
        let keyLength: Int = 384
    
        // private key parameters
        let privateKeyParams: [String: AnyObject] = [
            kSecAttrIsPermanent as String: true as AnyObject,
            kSecAttrApplicationTag as String: (privateLabel + keyTag) as AnyObject,
            kSecAttrLabel as String : (self.privateLabel + keyTag) as AnyObject,
        ]

        // public key parameters
        let publicKeyParams: [String: AnyObject] = [
            kSecAttrIsPermanent as String: true as AnyObject,
            kSecAttrApplicationTag as String: (publicLabel + keyTag) as AnyObject,
            kSecAttrLabel as String : (self.publicLabel + keyTag) as AnyObject,
        ]
    
        // global parameters for our key generation
        let parameters: [String: AnyObject] = [
            kSecAttrKeyType as String:          getKeyType() as AnyObject,
            kSecAttrKeySizeInBits as String:    keyLength as AnyObject,
            kSecPublicKeyAttrs as String:       publicKeyParams as AnyObject,
            kSecPrivateKeyAttrs as String:      privateKeyParams as AnyObject
        ]

        // generate the key pair and call the completion block
       
        var pubKey, privKey: SecKey?
        let status = SecKeyGeneratePair(parameters as CFDictionary, &pubKey, &privKey)
        if status == errSecSuccess {
            let publicKeyData = self.getNamedPublicKeyData(self.publicLabel + keyTag)
            return publicKeyData
        } else {
            NSLog(TAG + CryptoServiceError.unableToGenerateKeyForKeyChain.localizedDescription + " \(status)")
            return nil
        }
    }
  
    
    func getNamedPrivateKey(_ keyTag: String) -> Data? {
    
        let parameters = [
            kSecClass as String: kSecClassKey,
            kSecAttrKeyType as String: getKeyType(),
            kSecAttrKeyClass as String: kSecAttrKeyClassPrivate,
            kSecAttrApplicationTag as String: keyTag,
            kSecAttrLabel as String : keyTag,
            kSecReturnData as String: true
        ] as [String : Any]
        var data: AnyObject?
        let status = SecItemCopyMatching(parameters as CFDictionary, &data)
        if status == errSecSuccess {
            return data as? Data
        } else {
            NSLog(TAG + CryptoServiceError.unableToGetPrivateKeyFromKeyChain.localizedDescription +  "\(status)")
            return nil
        }
    }
  
  
    //We need another version of the getPublicKeyData function. For some reason when using a different algorithm it doesn't work
    //without the kSecAttrLabel that 384 needs
    func getNamedPublicKeyData(_ keyTag: String) -> Data? {
        let parameters = [
            kSecClass as String: kSecClassKey,
            kSecAttrKeyType as String: getKeyType(),
            kSecAttrKeyClass as String: kSecAttrKeyClassPublic,
            kSecAttrApplicationTag as String: keyTag,
            kSecAttrLabel as String : keyTag,
            kSecReturnData as String: true
        ] as [String : Any]
        var data: AnyObject?
        let status = SecItemCopyMatching(parameters as CFDictionary, &data)
        if status == errSecSuccess {
            return data as? Data
        } else {
            NSLog(TAG + CryptoServiceError.unableToGetPublicKeyData.localizedDescription + "\(status)")
            return nil
        }
    }
    
    
    func deleteNamedKey(_ keyTag: String) -> Void {
        let parameters = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: keyTag,
            kSecAttrLabel as String : keyTag,
            ] as [String : Any]
        SecItemDelete(parameters as CFDictionary)
    }
    
    
    func hexDataFromString(hexString: String) -> Data? {
        var data = Data(capacity: hexString.characters.count / 2)
    
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: hexString, range: NSMakeRange(0, hexString.utf16.count)) { match, flags, stop in
            let byteString = (hexString as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
    
        guard data.count > 0 else { return nil }
    
        return data
    }
  
  
    func encryptWithAESKeys(passPhrase: String, browserSharedSecret: Data, serviceSharedSecret: Data, phoneEcdhPublicKeyData: Data) -> WebLoginPhoneParameters? {
        
        let passPhraseData = passPhrase.data(using: .utf8)
  
        //Generate some random IVs for the browser and service AES keys
        var browserIv = Data(count: kCCBlockSizeAES128)
        let browserIVResult = browserIv.withUnsafeMutableBytes {ivBytes in
            SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, ivBytes)
        }
        var serviceIv = Data(count: kCCBlockSizeAES128)
        let serviceIVResult = serviceIv.withUnsafeMutableBytes {ivBytes in
            SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, ivBytes)
        }
    
        if (browserIVResult == 0 && serviceIVResult == 0) {
      
            //We need to convert the shared secrets to hex first then back to a data object so that they can be used.
            let browserAESKey = sha256(data: Data(browserSharedSecret.hexDescription.utf8))
            let serviceAESKey = sha256(data: Data(serviceSharedSecret.hexDescription.utf8))
    
            //encrypt the passphrase with the browserAESkey then encrypt the result of that (the browserCipher) with the serviceAESKey
            let browserCipher = aesEncryptCrypt(data: passPhraseData!, keyData: browserAESKey, ivData: browserIv, operation: kCCEncrypt)
            let serviceCipher = aesEncryptCrypt(data: browserCipher, keyData: serviceAESKey, ivData: serviceIv, operation: kCCEncrypt)
    
            //We need to convert the IVs and the service cipher to base64 to that can be sent to ums
            let browserIvString = browserIv.base64EncodedString()
            let serviceIvString = serviceIv.base64EncodedString()
            let serviceCipherString = serviceCipher.base64EncodedString()
      
            //We need to convert the phone ecdh public into an x/y coordinate format as it is current in an uncomporessed format. As this is how
            //it is process in the backend
            let phonePublicKeyInCoordinates = convertECDHPublicKeyToXYString(phoneEcdhPublicKeyData)
      
            var webLoginPhoneParameters: WebLoginPhoneParameters = WebLoginPhoneParameters()
        
            webLoginPhoneParameters.browserCipherIv = browserIvString
            webLoginPhoneParameters.serviceCipherIv = serviceIvString
            webLoginPhoneParameters.serviceCipher = serviceCipherString
            webLoginPhoneParameters.phoneECDHPublicKey = phonePublicKeyInCoordinates
            
            return webLoginPhoneParameters
        } else {
            NSLog(TAG + CryptoServiceError.unableToGenerateWebLoginIVs.localizedDescription)
            return nil
        }
    }
  
    
    func sha256(data : Data) -> Data {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(data.count), &hash)
        }
        return Data(bytes: hash)
    }
  
    
    func aesEncryptCrypt(data:Data, keyData:Data, ivData: Data, operation: Int) -> Data {
    
        let cryptLength  = data.count + kCCBlockSizeAES128
        var cryptData = Data(count:cryptLength)
    
        let keyLength = kCCKeySizeAES256
        let options = CCOptions(kCCOptionPKCS7Padding)
    
        var numBytesEncrypted :size_t = 0
    
        let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
            data.withUnsafeBytes {dataBytes in
                ivData.withUnsafeBytes{ivBytes in
                    keyData.withUnsafeBytes {keyBytes in
                        CCCrypt(CCOperation(operation),
                        CCAlgorithm(kCCAlgorithmAES),
                        options,
                        keyBytes,
                        keyLength,
                        ivBytes,
                        dataBytes,
                        data.count,
                        cryptBytes,
                        cryptLength,
                        &numBytesEncrypted)
                    }
                }
            }
        }
      
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.count = numBytesEncrypted
        } else {
            NSLog(TAG + CryptoServiceError.unableToEncryptUsingAES.localizedDescription)
        }
  
        return cryptData
    }
  
    
    func convertECDHPublicKeyToXYString(_ keyData: Data) -> String? {
    
        let keyLength: Int = 384
    
        let coordinateStringLength: Int = keyLength / 4;
    
        var keyStringArray: Array = Array(keyData.hexDescription.characters)
    
        if (keyStringArray.count != (keyLength / 2) + 2) {
            NSLog(TAG + CryptoServiceError.uncompressedFormatHasIncorrectLength.localizedDescription)
            return nil
        }
    
        let format: String = String(Array(keyStringArray[0...1]))
    
        if (format != "04") {
            NSLog(TAG + CryptoServiceError.uncompressedFormatHasInvaidType.localizedDescription)
            return nil
        }
    
        let x: String = String(Array(keyStringArray[2...(coordinateStringLength + 1)]))
        let y: String = String(Array(keyStringArray[(coordinateStringLength + 2)...((2 * coordinateStringLength) + 1)]))
    
        return "x" + x + "y" + y
    }
}
