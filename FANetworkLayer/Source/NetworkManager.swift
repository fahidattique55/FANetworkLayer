//
//  API.swift
//  iOSConsumerApp
//
//  Created by fahid.attique on 03/01/2020.
//  Copyright © 2020 iCarAsia. All rights reserved.
//

import Alamofire
import ObjectMapper


let networkManager = NetworkManager.shared

class NetworkManager {
    
    static let shared = NetworkManager()
    private var sessionManager = ICASessionManager()
    private init() {}

    //MARK:- Functions
    
    @discardableResult
    func request(_ api: API, completion: @escaping API.Completion<Any>.simple) -> Request? {
        
        if let params = api.parameters { DevLog("💛💛\(params)💛💛") }
        let urlString = api.service.urlString()
        let alamofireRequest = sessionManager.request(urlString, method: api.method, parameters: api.parameters, encoding: api.encoding, headers: getHeaders(api.isAuthorized, api.additionalHeaders)).responseJSON { (response) in
            
            self.validate(response: response, with: completion)
        }
        
        return alamofireRequest
    }

    private func validate(response: DataResponse<Any>, with completion: @escaping API.Completion<Any>.simple) {
        
        if let error = response.error {
            let errorMessage = errorMessageFor(error: error)
            if !errorMessage.isEmpty {
                let errorToShow = self.errorFrom(code: error.httpErrorCode, message: errorMessage)
                completion(.failure(errorToShow))
                return
            }
        }
        
        completion(.success(response.value))
    }
    
    @discardableResult
    func requestObject<T: Mappable>(_ api: API, mapperType: T.Type, completion: @escaping API.Completion<T>.object) -> Request? {

        let alamofireRequest = request(api) { (response) in
            
            switch response {
                
            case .success(let result):
                if let resultValue = result as? [String: Any] {
                    if let resultObject = Mapper<T>(context: api.service).map(JSON: resultValue) {
                        completion(.success(resultObject))
                        return
                    }
                }
                let message = appUtility.isProductionEnviornment ? ErrorMessage.responseSerializationFailed : "Can't parse JSON because its not a JSON Object."
                completion(.failure(self.errorFrom(code: Int(kErrorCodeJSONParsingFailed), message: message)))
                break
                
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
        return alamofireRequest
    }

    @discardableResult
    func requestList<T: Mappable>(_ api: API, mapperType: T.Type, parsingLevel: String, completion: @escaping API.Completion<T>.list) -> Request? {

        let alamofireRequest = self.request(api) { (response) in
            
            switch response {
                
            case .success(let result):
                if let resultValue = result as? [[String: Any]] {
                    let resultList = Mapper<T>(context: api.service).mapArray(JSONArray: resultValue)
                    completion(.success(resultList))
                    return
                }
                else if let resultValue = result as? [String: Any] {
                    
                    let levels = parsingLevel.components(separatedBy: ".")
                    let initialLevels = levels
                    initialLevels.dropLast()
                    var value = resultValue
                    for level in levels {
                        if let validatedValue = value[level] as? [String: Any] {
                            value = validatedValue
                        }
                        else { break }
                    }
                    
                    if let lastLeve = levels.last {
                        if let array = value[lastLeve] as? [[String: Any]] {
                            let resultList = Mapper<T>(context: api.service).mapArray(JSONArray: array)
                            completion(.success(resultList))
                            return
                        }
                    }
                }
                
                let message = appUtility.isProductionEnviornment ? ErrorMessage.responseSerializationFailed : "Can't parse JSON because its not a JSON Array."
                completion(.failure(self.errorFrom(code: Int(kErrorCodeJSONParsingFailed), message: message)))
                break
                
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
        return alamofireRequest
    }

    private func getHeaders(_ authorized: Bool, _ additionalHeaders: [String: String]?) -> [String : String]? {
        
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        if authorized {
            headers[kParameterToken] = appUtility.token
        }
        
        if let addtionalHeaderFields = additionalHeaders {
            addtionalHeaderFields.forEach { (key, value) in
                headers[key] = value
            }
        }
        
        return headers
    }

    private func errorFrom(code: Int, message: String) -> Error {
        return NSError(domain: "com.icarasia", code: code, userInfo: [NSLocalizedDescriptionKey: message])
    }
}




class ICASessionManager: SessionManager {

    override func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
     
        let request = super.request(urlRequest)
        request.responseString { (responseString) in
            if let url = urlRequest.urlRequest?.url { DevLog("\n💚💚\n\(url)\n💚💚\n") }
            DevLog("❤️❤️❤️\(responseString)\n❤️❤️❤️\n")
        }
        return request
    }
}



func DevLog(_ value: String) {
    
    if !appUtility.isProductionEnviornment {
        print(value)
    }
}
