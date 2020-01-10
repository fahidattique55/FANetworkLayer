![Alt text](https://i.imgur.com/o0EqwPu.png "FANetworkLayer-Image")


[![Swift version](https://img.shields.io/badge/swift-5.1-orange.svg?style=flat.svg)](https://img.shields.io/badge/swift-5.1-orange.svg?style=flat.svg)
[![License](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat.svg)](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat.svg)



## Architecture Base

It is fully built with **Protocol Oriented Programmig** & **Structs** having dependency injection.


## Very Fast & Powerful to absorb changes/overriding 

As its built fully in protocol oriented programming, you can override & add features very easily.


## Installation

### Swift Package Manager

Right now **FANetworkLayer** is only supported via swift package manager. You can also install it manually. Incase you want it in other dependancy manager tools, please create an issue and I'll push it in them.


## Usage

Get ready to get shock - As you'll see just couple of lines of code giving you everything you need :-)


### Network Manager

Create your network manager class and conform it with `APIRoutable` protocol so it can access features in `FANetworkLayer`

```
class MyNetworkManager: APIRoutable {

    var sessionManager: APISessionManager = APISessionManager()
    static let shared = MyNetworkManager()
    private init() {}
}
```

### Endpoints

Create your endpoints and conform it with `URLDirectable` protocol so you can provide full  `urlString` for end points.

```
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
```

### Use Now

Use your newly created network manager by providing it API information as given in example below.

You can request three types of responses from server.

1. Simple Request
2. Request Object
3. Request List

```
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
```

Please check files under [FANetworkLayer Usage Demo](https://github.com/fahidattique55/FANetworkLayer/tree/master/FANetworkLayer/FANetworkLayer%20Usage%20Demo) folder to understand how it's working.


### Override Behavior

If you want to override any of the features of `APIRoutable` protocol, then just provide the implementation in your  `Network Manager` class as its conforming to this protocol.


### Add New 

If you want to add new functions then just add it in `Network Manager` class as its conforming to `APIRoutable` protocol.


## License

FANetworkLayer is licensed under MIT.

For more details visit the [LICENSE](https://github.com/fahidattique55/FAPopover/blob/master/LICENSE.txt) file for more info.


## Author

**Fahid Attique** - (https://github.com/fahidattique55)




