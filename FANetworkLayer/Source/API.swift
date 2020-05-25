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
    public var filesData: [multipartFile]? // if using multipart then put list of files to upload here
    
    //MARK:- Life Cycle
    
    public init(method: HTTPMethod, endPoint: URLDirectable, isAuthorized: Bool, parameters: [String: Any]? = nil, additionalHeaders: [String: String]? = nil, encoding: ParameterEncoding = URLEncoding.default, filesData: [multipartFile]? = nil) {
     
        self.method = method
        self.endPoint = endPoint
        self.parameters = parameters
        self.isAuthorized = isAuthorized
        self.additionalHeaders = additionalHeaders
        self.encoding = encoding
        self.filesData = filesData
    }

    //MARK:- Others

    public struct Completion<T> {
        
        public typealias simple = (_ result: APIResult<Any, Error>) -> Void
        public typealias object = (_ result: APIResult<T, Error>) -> Void
        public typealias list = (_ result: APIResult<[T], Error>) -> Void
    }
}

public struct multipartFile {
    //MARK:- Properties

    public var name = "image"
    public var fullnameWithExtension = "image.jpg"
    public var mimeType = "image/jpeg"
    public var fileData: Data!
    //MARK:- Life Cycle
    
    public init(fileName: String, fileNameWithExtension: String, fileMimeType: String, fileData: Data) {
        self.name = fileName
        self.fullnameWithExtension = fileNameWithExtension
        self.mimeType = fileMimeType
        self.fileData = fileData
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
