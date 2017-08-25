import Foundation

public struct TokenService
{
    let TAG: String = "TokenService: "
    
    let cryptoService: CryptoService = CryptoService()
    
    public init() { }
    
    public func issueToken(token: Token,
                           apiKey: String,
                           secret: String,
                           completionHandler: @escaping (Token?, Error?) -> Void)
    {
        guard let tokenJson: String = token.toJson() else {
            completionHandler(nil, TokenServiceError.unableToConvertTokenObjectToJson)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.secret = secret
        
        restClient.restCall(uri: Constant.CITIZEN_TOKEN_RESOURCE, method: "POST", data: tokenJson, completionHandler: completionHandler)
    }
    
    
    public func getToken(tokenId: String,
                         apiKey: String,
                         secret: String,
                         completionHandler: @escaping (Token?, Error?) -> Void)
    {
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.secret = secret
        
        restClient.restCall(uri: Constant.CITIZEN_TOKEN_RESOURCE + "/" + tokenId, method: "GET", completionHandler: completionHandler)
    }
    
    
    public func getTokensRequested(apiKey: String,
                                   secret: String,
                                   completionHandler: @escaping (TokenWrapper?, Error?) -> Void)
    {
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.secret = secret
        
        restClient.restCall(uri: Constant.CITIZEN_TOKEN_RESOURCE + "/user", method: "GET", completionHandler: completionHandler)
    }
    
    
    public func getTokensIssued(apiKey: String,
                                secret: String,
                                completionHandler: @escaping (TokenWrapper?, Error?) -> Void)
    {
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.secret = secret
        
        restClient.restCall(uri: Constant.CITIZEN_TOKEN_RESOURCE + "/requester", method: "GET", completionHandler: completionHandler)
    }
    
    
    public func getTokensIssuedByStatus(tokenStatus: TokenStatus?,
                                        apiKey: String,
                                        secret: String,
                                        completionHandler: @escaping (TokenWrapper?, Error?) -> Void)
    {
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.secret = secret
        
        var tokenStatusString: String = ""
        if tokenStatus == nil {
            tokenStatusString = "all"
        } else {
            tokenStatusString = (tokenStatus?.toString())!
        }
        
        restClient.restCall(uri: Constant.CITIZEN_TOKEN_RESOURCE + "/sent/" + tokenStatusString, method: "GET", completionHandler: completionHandler)
    }

    
    public func grantToken(token: Token,
                           apiKey: String,
                           secret: String,
                           completionHandler: @escaping (Token?, Error?) -> Void)
    {
        var tokenToGrant: Token = token
        
        if token.access != nil && AccessType.contains(access: token.access!, accessType: AccessType.WEB_ACCESS) {
        
            let tokenWithWebLoginDetails: Token? = addPropertiesForWebLoginRequest(passphrase: secret, token: token)
            
            if tokenWithWebLoginDetails != nil {
                tokenToGrant = tokenWithWebLoginDetails!
            } else {
                completionHandler(nil, TokenServiceError.unableToGenerateWebLoginParameters)
                return
            }
        }
        
        guard let tokenId: String = tokenToGrant.id else {
            completionHandler(nil, TokenServiceError.tokenObjectMissingRequiredFields)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.secret = secret
        
        let propertiesJson = tokenToGrant.propertiesToJson()
        
        if propertiesJson != nil {
            restClient.restCall(uri: Constant.CITIZEN_TOKEN_RESOURCE + "/" + tokenId + "/GRANTED", method: "PUT", data: propertiesJson, completionHandler: completionHandler)
        } else {
            restClient.restCall(uri: Constant.CITIZEN_TOKEN_RESOURCE + "/" + tokenId + "/GRANTED", method: "PUT", completionHandler: completionHandler)
        }
    }
    
    
    public func declineToken(token: Token,
                             apiKey: String,
                             secret: String,
                             completionHandler: @escaping (Token?, Error?) -> Void)
    {
        guard let tokenJson: String = token.toJson() else {
            completionHandler(nil, TokenServiceError.unableToConvertTokenObjectToJson)
            return
        }
        guard let tokenId: String = token.id else {
            completionHandler(nil, TokenServiceError.tokenObjectMissingRequiredFields)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.secret = secret
        
        restClient.restCall(uri: Constant.CITIZEN_TOKEN_RESOURCE + "/" + tokenId + "/DECLINED", method: "PUT", data: tokenJson, completionHandler: completionHandler)
    }
    
    
    public func deleteToken(tokenId: String,
                            apiKey: String,
                            completionHandler: @escaping (Token?, Error?) -> Void)
    {
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        
         restClient.restCall(uri: Constant.CITIZEN_TOKEN_RESOURCE + "/" + tokenId, method: "DELETE", completionHandler: completionHandler)
    }
    
    
    public func canIssueToken(token: Token,
                              apiKey: String,
                              completionHandler: @escaping (CanIssueToken?, Error?) -> Void)
    {
        guard let tokenId: String = token.id else {
            completionHandler(nil, TokenServiceError.tokenObjectMissingRequiredFields)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        
        restClient.restCall(uri: Constant.CITIZEN_TOKEN_RESOURCE + "/" + tokenId + "/canissue", method: "GET", completionHandler: completionHandler)
    }
    
    
    func addPropertiesForWebLoginRequest(passphrase: String, token: Token) -> Token? {
        
        if token.metaData == nil {
            NSLog(TokenServiceError.webAccessTokenHasNoMetaData.localizedDescription)
            return nil
        }
        
        let browserECDHPublicKeyXY: String? = token.getStringProperty(property: PropertyType.WEB_ACCESS_BROWSER_ECDH_PUB_KEY)
        
        let serviceECDHPublicKeyXY: String? = token.getStringProperty(property: PropertyType.WEB_ACCESS_SERVICE_ECDH_PUB_KEY)
        
        if browserECDHPublicKeyXY == nil {
            NSLog(TokenServiceError.webAccessTokenBrowserPublicKeyMissing.localizedDescription)
            return nil
        }
        
        if serviceECDHPublicKeyXY == nil {
            NSLog(TokenServiceError.webAccessTokenServicePublicKeyMissing.localizedDescription)
            return nil
        }
        
        let webLoginPhoneParameters: WebLoginPhoneParameters? = self.cryptoService.generateEcdhKeyAndSecret(passPhrase: passphrase, browserEcdhPublicKeyCoordinates: browserECDHPublicKeyXY!, serviceEcdhPublicKeyCoordinates: serviceECDHPublicKeyXY!)
        
        if webLoginPhoneParameters == nil {
            NSLog(TokenServiceError.unableToGenerateWebLoginCryptoParameters.localizedDescription)
            return nil
        }
        
        let phoneECDHPublicKey: String? = webLoginPhoneParameters!.phoneECDHPublicKey
        let servicePassphraseCipher: String? = webLoginPhoneParameters?.serviceCipher
        let servicePassphraseCipherIv: String? = webLoginPhoneParameters?.serviceCipherIv
        let browserPassphraseCipherIv: String? = webLoginPhoneParameters?.browserCipherIv
        
        if phoneECDHPublicKey == nil {
            NSLog(TokenServiceError.phoneECDHPublicKeyIsNotSet.localizedDescription)
            return nil
        }
        
        if servicePassphraseCipher == nil {
            NSLog(TokenServiceError.servicePassphraseCipherIsNotSet.localizedDescription)
            return nil
        }
        
        if servicePassphraseCipherIv == nil {
            NSLog(TokenServiceError.servicePassphraseCipherIvIsNotSet.localizedDescription)
            return nil
        }
        
        if browserPassphraseCipherIv == nil {
            NSLog(TokenServiceError.browserPassphraseCipherIvIsNotSet.localizedDescription)
            return nil
        }
        
        var tokenWithWebLoginDetails = token
        
        tokenWithWebLoginDetails.setProperty(property: PropertyType.WEB_ACCESS_PHONE_ECDH_PUB_KEY, value: phoneECDHPublicKey!)
        tokenWithWebLoginDetails.setProperty(property: PropertyType.WEB_ACCESS_SERVICE_PASSPHRASE_CIPHER, value: servicePassphraseCipher!)
        tokenWithWebLoginDetails.setProperty(property: PropertyType.WEB_ACCESS_SERVICE_PASSPHRASE_CIPHER_IV, value: servicePassphraseCipherIv!)
        tokenWithWebLoginDetails.setProperty(property: PropertyType.WEB_ACCESS_BROWSER_PASSPHRASE_CIPHER_IV, value: browserPassphraseCipherIv!)
        
        return tokenWithWebLoginDetails
    }
}
