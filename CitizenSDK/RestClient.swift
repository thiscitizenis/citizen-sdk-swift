import Foundation

struct RestClient
{
    let TAG = "Rest: "
    
    var contentType: String = "application/json"
    
    var apiKey: String?
    var secret: String?
    var signature: String?
    
    var sendSingleString: Bool = false
    var receiveSingleString: Bool = false
    
    func restCall<T: JsonObject>(uri: String, method: String, data: String? = nil, completionHandler: @escaping (T?, Error?) -> Void) {
        
        let url: String = Constant.CITIZEN_API_URL + uri
        let requestUrl: URL? = URL(string: url)
        if requestUrl == nil {
            NSLog(TAG + RestCallError.invalidUrl.localizedDescription + " : " + url)
            completionHandler(nil, RestCallError.invalidUrl)
            return
        }
        
        let request : NSMutableURLRequest = NSMutableURLRequest()
        
        if sendSingleString && data != nil {
            request.httpBody = ("\"" + data! + "\"").data(using: .utf8)
        } else if data != nil {
            request.httpBody = data!.data(using: .utf8)
        }
        
        request.url = requestUrl!
        request.httpMethod = method
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.addValue(contentType, forHTTPHeaderField: "Accept")
    
        
        if apiKey != nil {
            request.addValue(apiKey!, forHTTPHeaderField: Constant.CITIZEN_API_KEY_HEADER)
        }
        
        if secret != nil {
            request.addValue(secret!, forHTTPHeaderField: Constant.CITIZEN_XCODE_HEADER)
        }
        
        if signature != nil {
            request.addValue(signature!, forHTTPHeaderField: Constant.CITIZEN_XSIGNATURE_HEADER)
        }
        
        func restCallCompetionHandler(responseData: Data?, response: URLResponse?, error: Error?) {
            
            if error != nil {
                NSLog(TAG + error.debugDescription)
                completionHandler(nil, error)
                return
            }
            
            if response != nil && responseData != nil {
                
                guard let httpResponse = response as? HTTPURLResponse
                    else {
                    NSLog(TAG + RestCallError.httpError.localizedDescription)
                    completionHandler(nil, RestCallError.httpError)
                    return
                }
            
                if httpResponse.statusCode == 200 {
                    let responseDataString: String? = String(data: responseData!, encoding: String.Encoding.utf8)
                    if responseDataString != nil {
                        if responseDataString?.characters.count == 0 {
                            completionHandler(nil, nil)
                            return
                        }
                    }
                } else if httpResponse.statusCode == 400 {
                    NSLog(TAG + RestCallError.notFound.localizedDescription)
                    completionHandler(nil, RestCallError.notFound)
                    return
                } else if httpResponse.statusCode == 401 {
                    NSLog(TAG + RestCallError.unauthorised.localizedDescription)
                    completionHandler(nil, RestCallError.unauthorised)
                    return
                } else if httpResponse.statusCode != 200 {
                    NSLog(TAG + RestCallError.httpError.localizedDescription)
                    completionHandler(nil, RestCallError.httpError)
                    return
                }

                guard let mimeType = response?.mimeType else {
                    NSLog(TAG + RestCallError.unableToDetermineMimeType.localizedDescription)
                    completionHandler(nil, RestCallError.unableToDetermineMimeType)
                    return
                }
                
                if mimeType != "application/json" {
                    NSLog(TAG + RestCallError.unsupportedMimeType.localizedDescription)
                    completionHandler(nil, RestCallError.unsupportedMimeType)
                    return
                }
                    
                if receiveSingleString {
                    guard let resultString = String(data: responseData!, encoding: String.Encoding.utf8)! as String?
                        else {
                            NSLog(TAG + RestCallError.unableToDeseriliseJson.localizedDescription)
                            completionHandler(nil, RestCallError.unableToDeseriliseJson)
                            return
                    }
                        
                    guard let jsonObject: T = T.init(string: resultString)
                        else {
                            NSLog(TAG + RestCallError.unableToInitialiseJsonObject.localizedDescription)
                            completionHandler(nil, RestCallError.unableToInitialiseJsonObject)
                            return
                        }
                        
                    completionHandler(jsonObject, nil)
                        
                } else {
                        
                    guard let jsonResult = try?JSONSerialization.jsonObject(with: responseData!, options:JSONSerialization.ReadingOptions.mutableContainers) else {
                        NSLog(TAG + RestCallError.unableToDeseriliseJson.localizedDescription)
                        completionHandler(nil, RestCallError.unableToDeseriliseJson)
                        return
                    }
                        
                    guard let jsonDictionary: [String : Any] = jsonResult as? [String : Any] else {
                            NSLog(TAG + RestCallError.unableToConvertJsonToDictionary.localizedDescription)
                        completionHandler(nil, RestCallError.unableToConvertJsonToDictionary)
                        return
                    }
                    
                    guard let jsonObject: T = T.init(jsonDictionary: jsonDictionary)
                        else {
                            NSLog(TAG + RestCallError.unableToInitialiseJsonObject.localizedDescription)
                            completionHandler(nil, RestCallError.unableToInitialiseJsonObject)
                            return
                    }

                    completionHandler(jsonObject, nil)
                }
                
            } else if response == nil {
                NSLog(TAG + RestCallError.emptyResponse.localizedDescription)
                completionHandler(nil, RestCallError.emptyResponse)
                return
            } else {
                NSLog(TAG + RestCallError.httpError.localizedDescription)
                completionHandler(nil, RestCallError.httpError)
            }
        }
    
        let task = URLSession.shared.dataTask(with: request as URLRequest,
                                 completionHandler: restCallCompetionHandler)
            
        task.resume()
    }
}
