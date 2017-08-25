import Foundation

protocol JsonObject
{
    init()
    
    init?(jsonDictionary: [String: Any])
    
    init?(string: String)
    
    func toJson() -> String?
}
