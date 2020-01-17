//
//  APIErrors.swift
//  FANetworkLayer
//
//  Created by fahid.attique on 10/01/2020.
//  Copyright © 2020 fahid.attique. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

extension APIRoutable {
    
    public func errorMessageFromAPIError(error: Error) -> String {
     
        var errorMessage = ""
        
        if let afError = error as? AFError {
            
            if let errorCode = afError.responseCode {

                if errorCode == APIErrorCodes.badGateWay {
                    let prodMsg = APIErrorMessage.badGateWay
                    let devMsg  = "\(APIErrorMessage.badGateWay) - \(error.localizedDescription)"
                    return API.shouldShowDevLogs ? devMsg : prodMsg
                }
            }
            
            switch afError {
            case .responseSerializationFailed(_):
                let prodMsg = APIErrorMessage.responseSerializationFailed
                let devMsg  = "\(APIErrorMessage.responseSerializationFailed) - \(error.localizedDescription)"
                errorMessage = API.shouldShowDevLogs ? devMsg : prodMsg
                
            case .invalidURL(let url):
                let prodMsg = error.localizedDescription
                let devMsg  = "Invalid URL: \(url) - \(error.localizedDescription)"
                errorMessage = API.shouldShowDevLogs ? devMsg : prodMsg

            case .parameterEncodingFailed(let reason):
                let prodMsg = error.localizedDescription
                let devMsg  = "Parameter encoding failed: \(error.localizedDescription)\nFailure Reason: \(reason)"
                errorMessage = API.shouldShowDevLogs ? devMsg : prodMsg

            case .multipartEncodingFailed(let reason):
                let prodMsg = error.localizedDescription
                let devMsg  = "Multipart encoding failed: \(error.localizedDescription)\nFailure Reason: \(reason)"
                errorMessage = API.shouldShowDevLogs ? devMsg : prodMsg

            case .responseValidationFailed(let reason):
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    let prodMsg = error.localizedDescription
                    let devMsg  = "Downloaded file could not be read - \(error.localizedDescription) - Failure Reason: \(reason)"
                    errorMessage = API.shouldShowDevLogs ? devMsg : prodMsg

                case .missingContentType(let acceptableContentTypes):
                    let prodMsg = error.localizedDescription
                    let devMsg  = "Content Type Missing: \(acceptableContentTypes) - \(error.localizedDescription) - Failure Reason: \(reason)"
                    errorMessage = API.shouldShowDevLogs ? devMsg : prodMsg

                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    let prodMsg = error.localizedDescription
                    let devMsg  = "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes) - \(error.localizedDescription) - Failure Reason: \(reason)"
                    errorMessage = API.shouldShowDevLogs ? devMsg : prodMsg

                case .unacceptableStatusCode(let code):
                    let prodMsg = error.localizedDescription
                    let devMsg  = "Response status code was unacceptable: \(code) - \(error.localizedDescription) - Failure Reason: \(reason)"
                    errorMessage = API.shouldShowDevLogs ? devMsg : prodMsg
                }
            }
        }
        else if let error = error as? URLError {

            switch error.code.rawValue {
                
            case NSURLErrorTimedOut:
                let prodMsg = APIErrorMessage.requestTimedOut
                let devMsg  = "\(APIErrorMessage.requestTimedOut): \(error.localizedDescription)"
                errorMessage = API.shouldShowDevLogs ? devMsg : prodMsg
                break

            case NSURLErrorNetworkConnectionLost:
                let prodMsg = APIErrorMessage.internetLost
                let devMsg  = "\(APIErrorMessage.internetLost): \(error.localizedDescription)"
                errorMessage = API.shouldShowDevLogs ? devMsg : prodMsg
                break

            case NSURLErrorNotConnectedToInternet:
                let prodMsg = APIErrorMessage.noInternet
                let devMsg  = "\(APIErrorMessage.noInternet): \(error.localizedDescription)"
                errorMessage = API.shouldShowDevLogs ? devMsg : prodMsg
                break
                
            default:
                errorMessage = error.localizedDescription
            }
        }
        
        return errorMessage
    }
}


public struct APIErrorCodes {
    
    public static let badGateWay = 502
    public static let internalServerError = 500
    public static let responseNil = 1000
    public static let tokenExpired = 1001
}

public struct APIErrorMessage {
    
    public static let badGateWay = "We can't reach our servers. They should be back up shortly - if you are experiencing this issue for a prolonged time please contact us."
    public static let responseSerializationFailed = "Hang tight! We're updating our servers. They should be back, better than ever, shortly."
    public static let requestTimedOut = "We couldn't get a response from our server. Please check that your connection is working and try again. If your internet is up and running please contact us."
    public static let internetLost = "The network connection was too weak. Please check your connection and try again."
    public static let noInternet = "Your internet connection was lost. Please check your connection is working and try again."
    public static let internalServerError = "You've found an unexpected error. Sorry about that. If you experience it repeatedly then please contact us."
}
