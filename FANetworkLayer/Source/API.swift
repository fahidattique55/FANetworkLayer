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
    public static var errorDomain = "com.fahid.FANetworkLayer"

    public var method: HTTPMethod
    public var endPoint: URLDirectable
    public var isAuthorized: Bool
    public var parameters: [String: Any]?
    public var additionalHeaders: [String: String]?
    public var encoding: ParameterEncoding

    //MARK:- Life Cycle
    
    public init(method: HTTPMethod, endPoint: URLDirectable, isAuthorized: Bool, parameters: [String: Any]? = nil, additionalHeaders: [String: String]? = nil, encoding: ParameterEncoding = URLEncoding.default) {
     
        self.method = method
        self.endPoint = endPoint
        self.parameters = parameters
        self.isAuthorized = isAuthorized
        self.additionalHeaders = additionalHeaders
        self.encoding = encoding
        
    }

    //MARK:- Others

    public struct Completion<T> {
        
        public typealias simple = (_ result: APIResult<Any, Error>) -> Void
        public typealias object = (_ result: APIResult<T, Error>) -> Void
        public typealias list = (_ result: APIResult<[T], Error>) -> Void
    }
}


public protocol URLDirectable: MapContext {
    func urlString() -> String
}


public func devLog(_ value: String) {
    if API.shouldShowDevLogs {
        print(value)
    }
}
