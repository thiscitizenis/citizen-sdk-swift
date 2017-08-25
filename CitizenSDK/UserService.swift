import Foundation


public struct UserService
{
    let TAG: String = "UserService: "
    
    public init() { }

    public func createUser(username: String,
                           password: String,
                           passPhrase: String,
                           authPublicKey: String?,
                           completionHandler: @escaping (User?, Error?) -> Void)
    {
        var user: User = User()
        user.username = username
        user.password = password
        user.passPhrase = passPhrase
        
        if authPublicKey != nil {
            user.authPublicKey = authPublicKey
        }
        
        guard let userJson: String = user.toJson() else {
            completionHandler(nil, UserServiceError.unableToConvertUserObjectToJson)
            return
        }
        
        let restClient: RestClient = RestClient()
        
        restClient.restCall(uri: Constant.CITIZEN_USER_RESOURCE, method: "POST", data: userJson, completionHandler: completionHandler);
    }
    
    
    public func loginUserPass(username: String,
                              password: String,
                              completionHandler: @escaping (User?, Error?) -> Void)
    {
        var user: User = User()
        user.username = username
        user.password = password
        
        guard let userJson: String = user.toJson() else {
            completionHandler(nil, UserServiceError.unableToConvertUserObjectToJson)
            return
        }
        
        let restClient: RestClient = RestClient()
        
        restClient.restCall(uri: Constant.CITIZEN_SESSION_RESOURCE, method: "POST", data: userJson, completionHandler: completionHandler);
    }
    
    
    public func getMnemonic(user: User,
                            apiKey: String,
                            completionHandler: @escaping (JsonString?, Error?) -> Void)
    {
        guard let userJson: String = user.toJson() else {
            completionHandler(nil, UserServiceError.unableToConvertUserObjectToJson)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.receiveSingleString = true
        
        restClient.restCall(uri: Constant.CITIZEN_SESSION_RESOURCE + "/mnemonic", method: "POST", data: userJson, completionHandler: completionHandler)
    }
    
    
    public func enrollAuthPublicKey(userId: String,
                                    authPublicKey: String,
                                    apiKey: String,
                                    completionHandler: @escaping (User?, Error?) -> Void)
    {
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.sendSingleString = true
        
        restClient.restCall(uri: Constant.CITIZEN_USER_RESOURCE + "/" + userId + "/publicKey", method: "POST", data: authPublicKey, completionHandler: completionHandler)
    }
    
    
    public func updateNotificationsToken(user: User,
                                         notificationsToken: String,
                                         apiKey: String,
                                         completionHandler: @escaping (User?, Error?) -> Void)
    {
        guard let userId: String = user.id else {
                completionHandler(nil, UserServiceError.userObjectMissingRequiredFields)
                return
        }
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.sendSingleString = true
        
        restClient.restCall(uri: Constant.CITIZEN_USER_RESOURCE + "/" + userId + "/notificationsToken", method: "POST", data: userId, completionHandler: completionHandler)
    }
    
    
    public func getLoginNonce(completionHandler: @escaping (JsonString?, Error?) -> Void)
    {
        var restClient: RestClient = RestClient()
        restClient.receiveSingleString = true
        
        restClient.restCall(uri: Constant.CITIZEN_SESSION_RESOURCE + "/getLoginNonce", method: "GET", completionHandler: completionHandler)
    }
    
    
    public func loginWithSignedTransaction(loginTransaction: LoginTransaction,
                                           encodedTransactionSignature: String,
                                           completionHandler: @escaping (User?, Error?) -> Void)
    {
        guard let loginTransactionJson: String = loginTransaction.toJson() else {
            completionHandler(nil, UserServiceError.unableToConvertLoginTransactionObjectToJson)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.signature = encodedTransactionSignature
        
        restClient.restCall(uri: Constant.CITIZEN_SESSION_RESOURCE + "/auth", method: "POST", data: loginTransactionJson, completionHandler: completionHandler)
    }
    
    
    public func loginWithSignedTransaction(username: String,
                                           token: String,
                                           encodedTransactionSignature: String,
                                           completionHandler: @escaping (User?, Error?) -> Void)
    {
        var loginTransaction: LoginTransaction = LoginTransaction()
        loginTransaction.username = username
        loginTransaction.token = token
        
        guard let loginTransactionJson: String = loginTransaction.toJson() else {
            completionHandler(nil, UserServiceError.unableToConvertLoginTransactionObjectToJson)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.signature = encodedTransactionSignature
        
        restClient.restCall(uri: Constant.CITIZEN_SESSION_RESOURCE + "/auth", method: "POST", data: loginTransactionJson, completionHandler: completionHandler)
    }
    
    
    public func getDevicePublicKey(hashedUserEmail: String,
                                   apiKey: String,
                                   completionHandler: @escaping (JsonString?, Error?) -> Void)
    {
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.receiveSingleString = true
        
        restClient.restCall(uri: Constant.CITIZEN_USER_RESOURCE + "/" + hashedUserEmail + "/devicePublicKey", method: "GET", completionHandler: completionHandler)
    }
}
