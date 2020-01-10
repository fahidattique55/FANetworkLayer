//
//  EndPoints.swift
//  FANetworkLayer
//
//  Created by fahid.attique on 10/01/2020.
//  Copyright © 2020 fahid.attique. All rights reserved.
//

import Foundation

enum MyEndPoint: URLDirectable {
    
    case allCountries
    
    func urlString() -> String {
     
        var endpoint = ""
        
        switch (self) {
                        
        case .allCountries:
            endpoint = "all"
            
        }
        
        return "https://restcountries.eu/rest/v2/" + endpoint
    }
}
