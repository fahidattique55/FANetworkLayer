//
//  APIErrors.swift
//  iOSConsumerApp
//
//  Created by fahid.attique on 06/01/2020.
//  Copyright © 2020 iCarAsia. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

extension NetworkManager {
    
    func errorMessageFor(error: Error) -> String {
     
        var errorMessage = ""
        let isProduction = appUtility.isProductionEnviornment
        
        if let afError = error as? AFError {
            
            if let errorCode = afError.responseCode {

                if errorCode == ErrorCodes.badGateWay {
                    let prodMsg = ErrorMessage.badGateWay
                    let devMsg  = "\(ErrorMessage.badGateWay) - \(error.localizedDescription)"
                    return (isProduction ? prodMsg : devMsg)
                }
            }
            
            switch afError {
            case .responseSerializationFailed(_):
                let prodMsg = ErrorMessage.responseSerializationFailed
                let devMsg  = "\(ErrorMessage.responseSerializationFailed) - \(error.localizedDescription)"
                errorMessage = (isProduction ? prodMsg : devMsg)
                
            case .invalidURL(let url):
                let prodMsg = error.localizedDescription
                let devMsg  = "Invalid URL: \(url) - \(error.localizedDescription)"
                errorMessage = (isProduction ? prodMsg : devMsg)

            case .parameterEncodingFailed(let reason):
                let prodMsg = error.localizedDescription
                let devMsg  = "Parameter encoding failed: \(error.localizedDescription)\nFailure Reason: \(reason)"
                errorMessage = (isProduction ? prodMsg : devMsg)

            case .multipartEncodingFailed(let reason):
                let prodMsg = error.localizedDescription
                let devMsg  = "Multipart encoding failed: \(error.localizedDescription)\nFailure Reason: \(reason)"
                errorMessage = (isProduction ? prodMsg : devMsg)

            case .responseValidationFailed(let reason):
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    let prodMsg = error.localizedDescription
                    let devMsg  = "Downloaded file could not be read - \(error.localizedDescription) - Failure Reason: \(reason)"
                    errorMessage = (isProduction ? prodMsg : devMsg)

                case .missingContentType(let acceptableContentTypes):
                    let prodMsg = error.localizedDescription
                    let devMsg  = "Content Type Missing: \(acceptableContentTypes) - \(error.localizedDescription) - Failure Reason: \(reason)"
                    errorMessage = (isProduction ? prodMsg : devMsg)

                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    let prodMsg = error.localizedDescription
                    let devMsg  = "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes) - \(error.localizedDescription) - Failure Reason: \(reason)"
                    errorMessage = (isProduction ? prodMsg : devMsg)

                case .unacceptableStatusCode(let code):
                    let prodMsg = error.localizedDescription
                    let devMsg  = "Response status code was unacceptable: \(code) - \(error.localizedDescription) - Failure Reason: \(reason)"
                    errorMessage = (isProduction ? prodMsg : devMsg)
                }
            }
        }
        else if let error = error as? URLError {

            switch error.code.rawValue {
                
            case NSURLErrorTimedOut:
                let prodMsg = ErrorMessage.requestTimedOut
                let devMsg  = "\(ErrorMessage.requestTimedOut): \(error.localizedDescription)"
                errorMessage = (isProduction ? prodMsg : devMsg)
                break

            case NSURLErrorNetworkConnectionLost:
                let prodMsg = ErrorMessage.internetLost
                let devMsg  = "\(ErrorMessage.internetLost): \(error.localizedDescription)"
                errorMessage = (isProduction ? prodMsg : devMsg)
                break

            case NSURLErrorNotConnectedToInternet:
                let prodMsg = ErrorMessage.noInternet
                let devMsg  = "\(ErrorMessage.noInternet): \(error.localizedDescription)"
                errorMessage = (isProduction ? prodMsg : devMsg)
                break
                
            default:
                errorMessage = error.localizedDescription
            }
        }
        

        return errorMessage
    }
    
    
    
    
    
    
    
    
    
    
    

    // MARK: - Network Error Codes/messages
    
    struct ErrorCodes {
        
        static let badGateWay = 502
        static let internalServerError = 500
    }
    
    struct ErrorMessage {
        
        static let badGateWay = "We can't reach our servers. They should be back up shortly - if you are experiencing this issue for a prolonged time please contact us."
        
        static let responseSerializationFailed = "Hang tight! We're updating our servers. They should be back, better than ever, shortly."

        static let requestTimedOut = "We couldn't get a response from our server. Please check that your connection is working and try again. If your internet is up and running please contact us."

        static let internetLost = "The network connection was too weak. Please check your connection and try again."

        static let noInternet = "Your internet connection was lost. Please check your connection is working and try again."

        static let internalServerError = "You've found an unexpected error. Sorry about that. If you experience it repeatedly then please contact us."
    }
}
