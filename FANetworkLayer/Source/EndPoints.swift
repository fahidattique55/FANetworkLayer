//
//  EndPoints.swift
//  iOSConsumerApp
//
//  Created by fahid.attique on 03/01/2020.
//  Copyright © 2020 iCarAsia. All rights reserved.
//

import Alamofire
import ObjectMapper

protocol Directable: MapContext {
    func urlString() -> String
}

enum Endpoint: Directable, Equatable {

    // MARK:- Endpoints

    case login,
    news
    
    // MARK:- Directable URL-String
    
    func urlString() -> String {
        
        var servicePath = ""
        
        switch (self) {
            
        case .login:
            servicePath = "authentication/login"
            
        case .news:
            servicePath = "cms/news"
        }
        
        //  https://exapipreprod.carlist.my/v3.0/my/en/authentication/login
        //  https://exapipreprod.carlist.my/v3.0/my/en/cms/news?page_number=10&type=article&limit=20
        
        return iConfiguration.sharedInstance.config_BASE_URL + "/" + servicePath
    }
}

