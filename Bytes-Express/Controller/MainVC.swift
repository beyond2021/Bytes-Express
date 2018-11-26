//
//  MainVC.swift
//  Bytes-Express
//
//  Created by Kev1 on 11/23/18.
//  Copyright © 2018 Kev1. All rights reserved.
//

import Cocoa

class MainVC: NSViewController {
    static let services: String = "http:localhost:3000/api/v1/services"
    static let cabling: String = "cabling"
    static let cameras: String = "cameras"
    static let computers: String = "computers"
    static let networking: String = "networking"
    static let techCare: String = "techCare"
    static let wifi: String = "wifi"
  
    let enterFirebaseButton: NSButton = {
        let button = NSButton(title: "Update Firebase", target: self, action: #selector(showFirebase))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    @objc private func showFirebase(){
        print("Showing Firebase")
    }
    let servicesButtons : NSSegmentedControl = {
        let segControl = NSSegmentedControl(images:[ #imageLiteral(resourceName: "servicesUN"),#imageLiteral(resourceName: "cablingUN"),#imageLiteral(resourceName: "icons8-wall-mount-camera-50"),#imageLiteral(resourceName: "icons8-computer-50"),#imageLiteral(resourceName: "icons8-workstation-50"),#imageLiteral(resourceName: "icons8-trust-50"),#imageLiteral(resourceName: "icons8-wi-fi-logo-50")],trackingMode: .selectOne, target: self, action: #selector(handleActions))
        
        segControl.segmentStyle = .texturedSquare
        
        segControl.translatesAutoresizingMaskIntoConstraints = false
        return segControl
        
    }()
    @objc private func handleActions(sender:NSSegmentedControl){
        clearTextField()
        switch sender.selectedSegment {
        case 0:
            updateFirebaseLabel()
        case 1:
            updateFirebaseLabelWithService(singleService:MainVC.cabling)
        case 2:
            updateFirebaseLabelWithService(singleService:MainVC.cameras)
        case 3:
            updateFirebaseLabelWithService(singleService:MainVC.computers)
        case 4:
            updateFirebaseLabelWithService(singleService:MainVC.networking)
        case 5:
            updateFirebaseLabelWithService(singleService:MainVC.techCare)
        case 6:
            updateFirebaseLabelWithService(singleService:MainVC.wifi)
        default:
            break
        }
//
        
    }
    let firebaseDataOutputTextView: NSTextView = {
        let sv = NSTextView(frame: NSRect.zero)
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
        
    }()
    fileprivate func clearTextField(){

        firebaseDataOutputTextView.textStorage?.mutableString.setString("")
        
        
    }

    
    
    
     var textView : NSTextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.view.layer != nil {
            let color = NSColor.tableViewBackgroundColor.cgColor
            self.view.layer?.backgroundColor = color
        }
        self.view.addSubview(servicesButtons)
        servicesButtons.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 60)
        self.view.addSubview(firebaseDataOutputTextView)
        firebaseDataOutputTextView.anchor(top: servicesButtons.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
 
        DataService.instance.delegate = self
        DataService.instance.getServicesApiData()
        updateFirebaseLabel()
       
    }
    private func refresh(){
        clearTextField()
//        DataService.instance.getServicesApiData()
        updateFirebaseLabel()
        
    }
    override func awakeFromNib() {
        if self.view.layer != nil {
            let color = NSColor.tableViewBackgroundColor.cgColor
            self.view.layer?.backgroundColor = color
        }
    }
    @IBAction func resfreshClicked(_ sender: NSButton) {
        DataService.instance.getServicesApiData()
    }
    func updateFirebaseLabel(){

        let serviceArray = DataService.instance.serviceArray
//        let jsonData = try! JSONSerialization.data(withJSONObject: serviceArray, options: [])
//        let decoded = String(data: jsonData, encoding: .utf8)!
        
        print(serviceArray)
//        print(serviceArray)
        for (service) in serviceArray {
//            let key = service.key
//            let val = service.value
//            print(service.value)
            firebaseDataOutputTextView.textStorage?.append(NSAttributedString(string:"\(service.value) "))
//            firebaseDataOutputTextView.textStorage?.append(NSAttributedString(string:"\( key) \n\n\(val.values) \n\n  "))
        }
        
//        textView!.textStorage?.append(NSAttributedString(string:"\(DataService.instance.serviceArray)"))
       
    }
    private func updateFirebaseLabelWithService(singleService:String){
        //all
        let serviceArray = DataService.instance.serviceArray
//        print(serviceArray)
        for service in serviceArray {
           
            if service.key == singleService {
//                let serviceKey = service.key
//                let serviceValue = service.value
////                firebaseDataOutputTextView.textStorage?.append(NSAttributedString(string:"\(serviceKey) \n\n\(serviceValue.values) \n\n  "))
                firebaseDataOutputTextView.textStorage?.append(NSAttributedString(string:"\(service.value) "))
            }
        }
    
    }
    
}
extension MainVC: DataServiceDelegate {
    func dataLoaded() {
        print("Data has finished loading.")
        updateFirebaseLabel()
    }
    
    
}
