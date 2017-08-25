import Foundation

public struct WebLoginPhoneParameters : JsonObject
{
    let TAG: String = "WebLoginPhoneParameters: "
    
    var serviceCipher: String?
    var serviceCipherIv: String?
    var browserCipherIv: String?
    var phoneECDHPublicKey: String?
    
    init() {}
    
    init?(string: String) { return nil }
    
    init?(jsonDictionary: [String: Any]) {
        self.serviceCipher = jsonDictionary["serviceCipher"] as? String
        self.serviceCipherIv = jsonDictionary["serviceCipherIv"] as? String
        self.browserCipherIv = jsonDictionary["browserCipherIv"] as? String
        self.phoneECDHPublicKey = jsonDictionary["phoneECDHPublicKey"] as? String
    }
    
    func toJson() -> String? {
        var dict: Dictionary = [String:Any]()
        
        if self.serviceCipher != nil { dict["serviceCipher"] = self.serviceCipher! }
        if self.serviceCipherIv != nil { dict["serviceCipherIv"] = self.serviceCipherIv! }
        if self.browserCipherIv != nil { dict["browserCipherIv"] = self.browserCipherIv! }
        if self.phoneECDHPublicKey != nil { dict["phoneECDHPublicKey"] = self.phoneECDHPublicKey! }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data:jsonData, encoding:.utf8)
        } catch {
            NSLog(TAG + ResourceError.unableToConvertDictionaryToJson.localizedDescription)
            return nil
        }
    }
}
