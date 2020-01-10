//
//  Country.swift
//  FANetworkLayer
//
//  Created by fahid.attique on 10/01/2020.
//  Copyright © 2020 fahid.attique. All rights reserved.
//

import UIKit
import ObjectMapper

class Country: NSObject, Mappable {

    var name = ""
    var alpha2Code = ""
    var alpha3Code = ""
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        
        name <- map["name"]
        alpha2Code <- map["alpha2Code"]
        alpha3Code <- map["alpha3Code"]
    }
}
