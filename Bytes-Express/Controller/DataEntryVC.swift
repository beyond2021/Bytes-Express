//
//  DataEntryVC.swift
//  Bytes-Express
//
//  Created by Kev1 on 11/23/18.
//  Copyright © 2018 Kev1. All rights reserved.
//

import Cocoa

class DataEntryVC: NSViewController {

    @IBOutlet weak var keyTextField: NSTextField!
    
    @IBOutlet weak var valueTextField: NSTextField!
    private var _key:String = ""
    private var _value:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        keyTextField.becomeFirstResponder()
    }
    @IBAction func UpdateDataButtonClicked(_ sender: NSButton) {
        if keyTextField.stringValue != "" {
            _key = keyTextField.stringValue
        }
        if keyTextField.stringValue != "" {
            valueTextField.becomeFirstResponder()
        } else {
            valueTextField.resignFirstResponder()
        }
        
        
        
        if  valueTextField.stringValue != "" {
            _value = valueTextField.stringValue
        }
        print("key: \(_key), Value:\(_value)")
        DataService.instance.saveServiceDataToFirebase(key: _key, value: _value)
        DataService.instance.getServicesApiData()
        keyTextField.stringValue = ""
        valueTextField.stringValue = ""
        keyTextField.becomeFirstResponder()
    }
    
}
