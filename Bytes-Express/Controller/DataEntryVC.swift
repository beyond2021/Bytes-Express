//
//  DataEntryVC.swift
//  Bytes-Express
//
//  Created by Kev1 on 11/23/18.
//  Copyright © 2018 Kev1. All rights reserved.
//

import Cocoa
import SwiftyJSON

class DataEntryVC: NSViewController {
   
    var firebaseString : String? {
        didSet {
            firebaseDataInputTextView.textStorage?.mutableString.setString(firebaseString!)
        }
    }
    var key : String? {
        didSet {
            if let key = key {
                print("key is : \(key)")
                self.serviceTextField.stringValue = key
            }
        }
    }
    
    var value : String? {
        didSet{
            if let value = value {
                print("Value is \(value)")
            }
        }
    }
    
    override func loadView() {
        print("PrimaryController.loadView")
        view = NSView()
    }
    let dismissButton : NSButton = {
        let button = NSButton()
        button.translatesAutoresizingMaskIntoConstraints = false
      
        button.title = "Dismiss"
        return button
    }()
    
    let updateFirebaseService : NSButton = {
        let button = NSButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.title = "UpdateFB"
        return button
    }()
    let swiftDictionaryButton : NSButton = {
        let button = NSButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.title = "Swift"
        return button
    }()
    
    var textViewHeightConstraint : NSLayoutConstraint?
    
    
    let firebaseDataInputTextView: NSTextView = {
        let sv = NSTextView(frame: NSRect.zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let serviceTextField: NSTextField = {
        let tf = NSTextField()
        tf.placeholderString = "Service"
        tf.isEditable = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    override func viewWillAppear() {
        firebaseDataInputTextView.isEditable = true
    }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        // Do view setup here.
        print("PrimaryController.viewDidLoad")
//        let array = [unichar(NSLeftArrowFunctionKey)]
//        dismissButton.keyEquivalent = String(utf16CodeUnits: array, count: 1)
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 80, height: 40)
        view.addSubview(firebaseDataInputTextView)
        view.addSubview(serviceTextField)
        serviceTextField.anchor(top: dismissButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 30)
        textViewHeightConstraint?.constant  = CGFloat(640 * 4)
        firebaseDataInputTextView.anchor(top: serviceTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 820 )
        view.addSubview(swiftDictionaryButton)
        view.addSubview(updateFirebaseService)
        updateFirebaseService.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 20, width: 80, height: 40)
        
        swiftDictionaryButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 80, height: 40)
        dismissButton.setAccessibilityLabel("DismissButton")
        // Set button target and action
        dismissButton.target = nil
        dismissButton.action = #selector(MainVC.dismissAction(button:))
        swiftDictionaryButton.action = #selector(jsonToSwiftDic)
        swiftDictionaryButton.target = self
        // Set nextResponder
//        dismissButton.nextResponder = self.parent
        updateFirebaseService.action = #selector(UpdateDataButtonClicked)
        updateFirebaseService.target = self
        
    }
 
    @objc private func jsonToSwiftDic(sender:NSButton) {
        if let jsonString = firebaseDataInputTextView.textStorage?.string {
            // convert JSON to swift dictionary
            if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
                do {
                    let json = try JSON(data: dataFromString)
                    // clear textfield
                    clearTextField()
                    firebaseDataInputTextView.textStorage?.mutableString.setString("\(json)")
                    firebaseDataInputTextView.displayIfNeeded()
                } catch  {
                    print("Failed to convert: ")
                }
            }
        }
    }
    fileprivate func clearTextField(){
        firebaseDataInputTextView.textStorage?.mutableString.setString("")
    }
    override func awakeFromNib() {
        if self.view.layer != nil {
            let color = NSColor.tableViewBackgroundColor.cgColor
            self.view.layer?.backgroundColor = color
        }
    }
    @objc private func UpdateDataButtonClicked() {
        //1: save state disable webview
        firebaseDataInputTextView.isEditable = false
        guard firebaseDataInputTextView.string != "" else {
            print("There is no text in the textView")
            return
        }
        let value =  firebaseDataInputTextView.string
        
        if  let key = key {
           DataService.instance.saveServiceDataToFirebase(key: key, value: value)
            DataService.instance.getServicesApiData()
//            self.view.window?.close()
        }

       
    }
    
}
