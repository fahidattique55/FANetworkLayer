//
//  APISessionManager.swift
//  FANetworkLayer
//
//  Created by fahid.attique on 10/01/2020.
//  Copyright © 2020 fahid.attique. All rights reserved.
//

import Foundation
import Alamofire

public class APISessionManager: SessionManager {

    public override func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
     
        let request = super.request(urlRequest)
        request.responseString { (responseString) in
            if let url = urlRequest.urlRequest?.url { devLog("\n💚💚\n\(url)\n💚💚\n") }
            devLog("❤️❤️❤️\(responseString)\n❤️❤️❤️\n")
        }
        return request
    }
}
