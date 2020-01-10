//
//  CountriesAPIProvider.swift
//  FANetworkLayer
//
//  Created by fahid.attique on 10/01/2020.
//  Copyright © 2020 fahid.attique. All rights reserved.
//

import Foundation
import Alamofire

class CountriesAPIProvider {
    
    func getAllCountries(completion: @escaping (_ countries: [Country]?) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
        let api = API(method: .get, endPoint: MyEndPoint.allCountries, isAuthorized: false)
        myNetworkManager.requestList(api, mapperType: Country.self, parsingLevel: "") { (result) in
            
            switch result {
                
            case .success(let value):
                completion(value)
                break

            case .failure(let error):
                failure(error)
                break

            }
        }
    }
}
