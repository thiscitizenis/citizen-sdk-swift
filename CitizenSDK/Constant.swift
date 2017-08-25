public struct Constant
{
    public static let CITIZEN_API_URL: String           = "http://192.168.1.76:8443/"
    
    public static let CITIZEN_USER_RESOURCE: String     = "users"
    public static let CITIZEN_SESSION_RESOURCE: String  = "sessions"
    public static let CITIZEN_TOKEN_RESOURCE: String    = "tokens"
    public static let CITIZEN_PERSON_RESOURCE: String   = "persons"
    public static let CITIZEN_PHONE_RESOURCE: String    = "phones"
    
    public static let CITIZEN_API_KEY_HEADER: String    = "AuthorizationCitizen"
    public static let CITIZEN_XCODE_HEADER: String      = "X-code"
    public static let CITIZEN_XSIGNATURE_HEADER: String = "X-signature"
    
    public static let CITIZEN_USE_SECURE_ENCLAVE: Bool  = true
}
