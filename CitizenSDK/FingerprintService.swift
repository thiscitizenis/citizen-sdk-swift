import Foundation
import LocalAuthentication


public struct FingerprintService
{
    static let TAG: String = "FingerprintService"
 
    public init() { }
    
    public static func hasFingerprintIDConfigured() -> Bool {
        let authenticationContext = LAContext()
        var error: NSError?
        
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
            else {
                if error != nil {
                    NSLog(TAG + (error?.localizedDescription)!)
                }
                return false
        }
        
        return true
    }
}
