import Foundation

public struct PersonService
{
    let TAG: String = "PersonService: "
    
    public init() { }
    
    public func updateName(personId: String,
                           name: Name,
                           apiKey: String,
                           completionHandler: @escaping (Person?, Error?) -> Void)
    {
        guard let nameJson: String = name.toJson() else {
            completionHandler(nil, PersonServiceError.unableToConvertPersonObjectToJson)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        
        restClient.restCall(uri: Constant.CITIZEN_PERSON_RESOURCE + "/" + personId + "/name", method: "POST", data: nameJson, completionHandler: completionHandler)
    }
    
    
    public func addPhone(personId: String,
                         phone: Phone,
                         apiKey: String,
                         completionHandler: @escaping (Phone?, Error?) -> Void)
    {
        guard let phoneJson: String = phone.toJson() else {
            completionHandler(nil, PersonServiceError.unableToConvertPersonObjectToJson)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        
        restClient.restCall(uri: Constant.CITIZEN_PERSON_RESOURCE + "/" + personId + "/phones", method: "POST", data: phoneJson, completionHandler: completionHandler)
    }
    
    
    public func confirmPhone(phone: Phone,
                             apiKey: String,
                             completionHandler: @escaping (Phone?, Error?) -> Void)
    {
        guard let phoneId: String = phone.id else {
            completionHandler(nil, PersonServiceError.phoneObjectMissingRequiredFields)
            return
        }
        guard let phoneJson: String = phone.toJson() else {
            completionHandler(nil, PersonServiceError.unableToConvertPhoneObjectToJson)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey

        restClient.restCall(uri: Constant.CITIZEN_PHONE_RESOURCE + "/" + phoneId + "/confirm", method: "POST", data: phoneJson, completionHandler: completionHandler)
    }
    
    
    public func updateOrigin(person: Person,
                             apiKey: String,
                             completionHandler: @escaping (Person?, Error?) -> Void)
    {
        guard let personJson: String = person.toJson() else {
            completionHandler(nil, PersonServiceError.unableToConvertPersonObjectToJson)
            return
        }
        guard let personId: String = person.id else {
            completionHandler(nil, PersonServiceError.personObjectMissingRequiredFields)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        
        restClient.restCall(uri: Constant.CITIZEN_PERSON_RESOURCE + "/" + personId + "/origin", method: "PUT", data: personJson, completionHandler: completionHandler)
    }
    
    
    public func addAddress(personId: String,
                           address: Address,
                           apiKey: String,
                           completionHandler: @escaping (Address?, Error?) -> Void)
    {
        guard let addressJson: String = address.toJson() else {
            completionHandler(nil, PersonServiceError.unableToConvertAddressObjectToJson)
            return
        }
        
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        
        restClient.restCall(uri: Constant.CITIZEN_PERSON_RESOURCE + "/" + personId + "/address", method: "POST", data: addressJson, completionHandler: completionHandler)
    }
    
    
    public func getPerson(apiKey: String,
                          secret: String,
                          completionHandler: @escaping (Person?, Error?) -> Void)
    {
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.secret = secret
        
        restClient.restCall(uri: Constant.CITIZEN_PERSON_RESOURCE, method: "GET", completionHandler: completionHandler)
    }
    
    
    public func getAddress(personId: String,
                           apiKey: String,
                           secret: String,
                           completionHandler: @escaping (Address?, Error?) -> Void)
    {
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.secret = secret
        
        restClient.restCall(uri: Constant.CITIZEN_PERSON_RESOURCE + "/" + personId + "/address", method: "GET", completionHandler: completionHandler)
    }
    
    
    public func getPhone(personId: String,
                         apiKey: String,
                         secret: String,
                         completionHandler: @escaping (Phone?, Error?) -> Void)
    {
        var restClient: RestClient = RestClient()
        restClient.apiKey = apiKey
        restClient.secret = secret
        
        restClient.restCall(uri: Constant.CITIZEN_PERSON_RESOURCE + "/" + personId + "/phone", method: "GET", completionHandler: completionHandler)
    }
}
