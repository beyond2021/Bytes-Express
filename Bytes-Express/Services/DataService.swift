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
    var serviceArray = [Service]()
    
    
    
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
//                print("JSON from firebase: \(json)")
                
                let unSortedJsonArray = Service.loadServiceFromJSON(json: json )
                let sortedJsonArray = unSortedJsonArray.sorted {$0.key < $1.key}
                self.serviceArray = sortedJsonArray
//                print(self.serviceArray)

                
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
