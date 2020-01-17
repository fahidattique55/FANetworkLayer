//
//  NSError+Addition.swift
//  FANetworkLayer
//
//  Created by fahid.attique on 09/01/2020.
//  Copyright © 2020 fahid.attique. All rights reserved.
//

import Foundation

public extension NSError {
    convenience init(errorMessage: String, code: Int? = nil) {
        var errorCode = -1
        if let code = code { errorCode = code }
        self.init(domain: API.errorDomain, code: errorCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
    }
}

public extension Error {
    
    var isServerResponseNil: Bool {
        get {
            if let nsError = self as? NSError {
                return nsError.code == APIErrorCodes.responseNil
            }
            return false
        }
    }
    
    var isServerTokenExpired: Bool {
        get {
            if let nsError = self as? NSError {
                return nsError.code == Int(APIErrorCodes.tokenExpired)
            }
            return false
        }
    }
}
