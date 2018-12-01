//
//  DataEntryVC.swift
//  Bytes-Express
//
//  Created by Kev1 on 11/23/18.
//  Copyright © 2018 Kev1. All rights reserved.
//

import Cocoa
protocol DataEntryVCDelegate {
    func dismiss()
}

class DataEntryVC: NSViewController {
    var delegate: DataEntryVCDelegate?
    
    
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
  
    

    @IBOutlet weak var keyTextField: NSTextField!
    
    @IBOutlet weak var valueTextField: NSTextField!
    private var _key:String = ""
    private var _value:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        // Do view setup here.
//        keyTextField.becomeFirstResponder()
        print("PrimaryController.viewDidLoad")
        let array = [unichar(NSLeftArrowFunctionKey)]
        dismissButton.keyEquivalent = String(utf16CodeUnits: array, count: 1)
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 80, height: 40)
        // SheetController viewDidLoad()
        // Set Accessibility Label
        dismissButton.setAccessibilityLabel("DismissButton")
        
        // Set button target and action
        dismissButton.target = nil

        dismissButton.action = #selector(MainVC.dismissAction(button:))
//        dismissButton.target = self
//        dismissButton.action = #selector(dismissMe)
        
        // Set nextResponder
        dismissButton.nextResponder = self.parent
        
    }
    @objc func dismissMe() {
//        delegate?.dismiss()
//        dismissMe()
    }
    
    override func awakeFromNib() {
        if self.view.layer != nil {
            let color = NSColor.tableViewBackgroundColor.cgColor
            self.view.layer?.backgroundColor = color
        }
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
