import Foundation

public struct User : JsonObject
{
    let TAG: String = "User: "
    
    public var id: String?
    
    public var personId: String?
    
    public var primaryEmail: String?
    
    public var username: String?
    
    public var password: String?
    
    public var apiKey: String?
    
    public var passPhrase: String?
    
    public var passwordTemporary: Bool?
    
    public var authPublicKey: String?
    
    public var mnemonicCode: String?
    
    public var publicKey: String?
    
    public var notificationsToken: String?
    
    public var entityEmail: String?
    
    public var emails: [Email]?
    
    public init() {}
    
    public init?(string: String) { return nil }
    
    public init?(jsonDictionary: [String: Any]) {
        
        guard let id = jsonDictionary["id"] as? String,
              let personId = jsonDictionary["personId"] as? String,
              let username = jsonDictionary["username"] as? String,
              let primaryEmail = jsonDictionary["primaryEmail"] as? String
            else {
                NSLog(TAG + ResourceError.jsonMissingRequiredFields.localizedDescription)
                return nil;
        }
        
        self.id = id
        self.personId = personId
        self.username = username
        self.primaryEmail = primaryEmail
        
        self.password = jsonDictionary["password"] as? String
        self.apiKey = jsonDictionary["apiKey"] as? String
        self.passPhrase = jsonDictionary["passphrase"] as? String
        self.passwordTemporary = jsonDictionary["passwordTemporary"] as? Bool
        self.authPublicKey = jsonDictionary["authPublicKey"] as? String
        self.mnemonicCode = jsonDictionary["mnemonicCode"] as? String
        self.publicKey = jsonDictionary["publicKey"] as? String
        self.notificationsToken = jsonDictionary["notificationsToken"] as? String
        self.entityEmail = jsonDictionary["entityEmail"] as? String
        
        if jsonDictionary["emails"] != nil {
            if let emailsJson = jsonDictionary["emails"] as? [[String: Any]] {
                var emails: [Email] = []
                for emailJson in emailsJson {
                    let email: Email? = Email(jsonDictionary: emailJson)
                    if email != nil {
                        emails.append(email!)
                    }
                }
                self.emails = emails
            } else {
                NSLog(TAG + ResourceError.unableToParseEmailList.localizedDescription)
                return nil
            }
        }
    }
    
    public func toJson() -> String? {
        // Both the API Key and mnemonic code are sent in headers rather than
        // a user object, so they are not included in JSON generated from here.
        
        var dict: Dictionary = [String:Any]()
        
        if self.id != nil { dict["id"] = self.id! }
        if self.personId != nil { dict["personId"] = self.personId! }
        if self.primaryEmail != nil { dict["primaryEmail"] = self.primaryEmail! }
        if self.password != nil { dict["password"] = self.password! }
        if self.passPhrase != nil { dict["passPhrase"] = self.passPhrase! }
        if self.passwordTemporary != nil { dict["passwordTemporary"] = self.passwordTemporary! }
        if self.authPublicKey != nil { dict["authPublicKey"] = self.authPublicKey! }
        if self.publicKey != nil { dict["publicKey"] = self.publicKey! }
        
        if self.emails != nil {
            var emailList: [String] = [String]()
            for email in self.emails! {
                let emailJson: String? = email.toJson()
                if emailJson != nil {
                    emailList.append(email.toJson()!)
                } else {
                    return nil
                }
            }
            if emailList.count > 0 {
                dict["emails"] = emailList
            }
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:jsonData, encoding:.utf8)
        } catch {
            NSLog(TAG + ResourceError.unableToConvertDictionaryToJson.localizedDescription)
            return nil
        }
    }
}
