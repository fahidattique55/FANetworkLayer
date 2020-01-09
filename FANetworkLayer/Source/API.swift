//
//  API.swift
//  iOSConsumerApp
//
//  Created by fahid.attique on 06/01/2020.
//  Copyright © 2020 iCarAsia. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

public enum APIResult<Value, Error: Swift.Error> {
    
    case success(_ result: Value)
    case failure(_ error: Error)
}

public struct API {

    //MARK:- Properties

    public var method: HTTPMethod
    public var service: Directable
    public var parameters: [String: Any]?
    public var isAuthorized: Bool
    public var additionalHeaders: [String: String]?
    public var encoding: ParameterEncoding!

    //MARK:- Life Cycle

    init(method: HTTPMethod, service: Directable, parameters: [String: Any]?, isAuthorized: Bool, additionalHeaders: [String: String]?, encoding: ParameterEncoding) {
     
        self.method = method
        self.service = service
        self.parameters = parameters
        self.isAuthorized = isAuthorized
        self.additionalHeaders = additionalHeaders
        self.encoding = encoding
    }

    //MARK:- Others

    struct Completion<T> {
        
        typealias simple = (_ result: APIResult<Any, Error>) -> Void
        typealias object = (_ result: APIResult<T?, Error>) -> Void
        typealias list = (_ result: APIResult<[T]?, Error>) -> Void
    }
}
