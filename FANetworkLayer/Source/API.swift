//
//  API.swift
//  FANetworkLayer
//
//  Created by fahid.attique on 10/01/2020.
//  Copyright © 2020 fahid.attique. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public enum APIResult<Value, Error: Swift.Error> {
    
    case success(_ result: Value)
    case failure(_ error: Error)
}

public struct API {

    //MARK:- Properties

    public static var shouldShowDevLogs = false
    public var method: HTTPMethod
    public var endPoint: URLDirectable
    public var parameters: [String: Any]?
    public var isAuthorized: Bool
    public var additionalHeaders: [String: String]?
    public var encoding: ParameterEncoding!

    //MARK:- Life Cycle

    init(method: HTTPMethod, service: URLDirectable, parameters: [String: Any]?, isAuthorized: Bool, additionalHeaders: [String: String]?, encoding: ParameterEncoding) {
     
        self.method = method
        self.endPoint = service
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


public protocol URLDirectable: MapContext {
    func urlString() -> String
}


func devLog(_ value: String) {
    if API.shouldShowDevLogs {
        print(value)
    }
}
