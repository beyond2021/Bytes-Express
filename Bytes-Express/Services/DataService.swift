//
//  DataService.swift
//  Bytes-Express
//
//  Created by Kev1 on 11/23/18.
//  Copyright © 2018 Kev1. All rights reserved.
//

import Foundation
import Alamofire
protocol DataServiceDelegate: class {
    func dataLoaded()
}
class DataService{
    static let instance = DataService()
    weak var delegate : DataServiceDelegate?
//    var serviceArray = [Service]()
    var serviceArray = [Service]()
    var serviceString = ""
    var singleServiceString = ""
  
    
    /* func to get our data*/
    func getServicesApiData(){
        let todoEndpoint: String = "http:localhost:3000/api/v1/services"
        Alamofire.request(todoEndpoint)
            .responseJSON { response in
                // check for errors
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /services")
                    print(response.result.error!)
                    return
                }
                
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: AnyObject] else {
                    print("didn't get todo object as JSON from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
               
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                        self.serviceString = jsonString
                        self.serviceArray = Service.loadServiceFromJSON(json: json )
                    }
                } catch {
                    print(error)
                }
                self.delegate?.dataLoaded() //tell s us that the data is loaded because its Async
        }
    }
    /* to save data to firebase*/
    func saveServiceDataToFirebase(key: String, value:String){
        let parameters =  [key: value]
        let todoEndpoint: String = "http://localhost:3000/api/v1/services"
        
        Alamofire.request(todoEndpoint, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /data/technologies")
                    print(response.result.error!)
                    return
                }
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                
                print(response)

       
        
    }
}
}
extension Data
{
    func dataToJSON() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: [])
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}


extension String
{
    func removeFrontBrackets() -> String
    {
//        return self.removingPercentEncoding!
        return self.replacingOccurrences(of: "[", with: "{", options: .literal, range: nil)
        
    }
    func removebackBrackets() -> String
    {
        //        return self.removingPercentEncoding!
        return self.replacingOccurrences(of: "]", with: "}", options: .literal, range: nil)
        
    }
    func addQuotesAfter() -> String {
        return (self + "\"")
    }
    func addQuotesBefore() -> String {
        return ( "\"" + self)
    }
    func addColonAfter() -> String {
        return (self + ":")
        
    }

    
}


extension Dictionary where Key : CustomStringConvertible, Value : AnyObject {
    func printKeys(){
//        print("new item added: \(key.description) with value: \(value)")
        for (key, value) in self {
            if let key = key as? String {
                let preKey = key.addQuotesAfter()
                let postKey = preKey.addQuotesBefore()
                let realKey = postKey.addColonAfter()
                if let val = value as? [String:String] {
//                   print(postKey, val)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: val, options: [])
                        if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                            print(realKey, jsonString)
                        }
                    } catch {
                        print(error)
                    }

                }
                
            }
        
        }
    }
}
