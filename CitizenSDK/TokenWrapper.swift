import Foundation

public struct TokenWrapper : JsonObject
{
    let TAG: String = "TokenWrapper: "
    
    public var tokens: [Token]?
    
    public init() {}
    
    public init?(string: String) { return nil }
    
    public init?(jsonDictionary: [String: Any]) {
        if jsonDictionary["tokens"] != nil {
            let tokenList: [[String: Any]]? = jsonDictionary["tokens"] as? [[String: Any]]
            if tokenList != nil {
                var tokens: [Token] = []
                for tokenJson in tokenList! {
                    let token: Token? = Token(jsonDictionary: tokenJson)
                    if token != nil {
                        tokens.append(token!)
                    }
                }
                self.tokens = tokens
            }
        }
    }
    
    public func toJson() -> String? {
        var dict: Dictionary = [String:Any]()
        
        if self.tokens != nil {
            var tokenList: [String] = [String]()
            for token in self.tokens! {
                let tokenJson = token.toJson()
                if tokenJson != nil {
                    tokenList.append(tokenJson!)
                }
            }
            if tokenList.count > 0 {
                dict["tokens"] = tokenList
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
    
    
    public func count() -> Int {
        if tokens == nil {
            return 0
        }
        
        let count: Int = tokens!.count
        
        return count
    }
    
    
    public func sort(sortType: TokenSortType) -> [Token]? {
        if tokens != nil {
            switch sortType {
                case .SORT_DATE:
                    for token in tokens! {
                        if token.creationDate == nil {
                            return nil
                        }
                    }
                    return self.tokens?.sorted(by: { $1.creationDate! > $0.creationDate! })
                
                case .SORT_STATUS:
                    for token in tokens! {
                        if token.tokenStatus == nil {
                            return nil
                        }
                    }
                    return self.tokens?.sorted(by: { ($1.tokenStatus?.toString())! > ($0.tokenStatus?.toString())! })
            }
        }
        
        return nil
    }
}
