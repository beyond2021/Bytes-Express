//
//  Service.swift
//  Bytes-Express
//
//  Created by Kev1 on 11/23/18.
//  Copyright © 2018 Kev1. All rights reserved.
//

import Foundation
struct Service {
    private var _key: String
    private var _value: Dictionary<String,AnyObject>
    //Public accessories
    var key: String {
        return _key
    }
    var value: Dictionary<String,AnyObject> {
        return _value
    }
    // Init with parameters
    init(key:String, value:Dictionary<String,AnyObject>){
        _key = key
        _value = value
    }
    //Static func to initialize with firebase data - loadFromJSON
    static func loadServiceFromJSON(json: Dictionary<String,AnyObject>) -> [Service]{
        var serviceArray = [Service]()
        for (key, value) in json {
            guard let val = value as? Dictionary<String,AnyObject> else { return [Service]()}
//            var id: String, val: AnyObject
//            id = key
//            val = value
//            val = value
//            let val = value["description"]
//            if let value = value as? String {
//                val = value
//            } else {
//                val = "No data"
//            }
            serviceArray.append(Service(key: key, value: val ))
//            print(" \(String(describing: val.values))")
        }
        return serviceArray
        
    }
    
}
