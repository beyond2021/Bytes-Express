//
//  MainVC.swift
//  Bytes-Express
//
//  Created by Kev1 on 11/23/18.
//  Copyright © 2018 Kev1. All rights reserved.
//

import Cocoa

class MainVC: NSViewController, DataEntryVCDelegate {
    func dismiss() {
         self.dismiss(self.presentedViewControllers!.first!)
    }
    
    static let services: String = "http:localhost:3000/api/v1/services"
    static let cabling: String = "cabling"
    static let cameras: String = "cameras"
    static let computers: String = "computers"
    static let networking: String = "networking"
    static let techCare: String = "techCare"
    static let wifi: String = "wifi"
    
    let refreshButton: NSButton = {
        let button = NSButton(title: "Refresh", target: self, action: #selector(resfreshClicked))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let updateFirebaseButton: NSButton = {
        let button = NSButton(title: "Update FB", target: self, action: #selector(showUpdateController))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        segControl.segmentStyle = .automatic
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
        
    }
    let firebaseDataOutputTextView: NSTextView = {
        let sv = NSTextView(frame: NSRect.zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    fileprivate func clearTextField(){
        firebaseDataOutputTextView.textStorage?.mutableString.setString("")
    }
 
   @objc  func dismissAction(button:NSButton){
    
//    counter += 1
//    let buttonAccessLabel = (sender as! NSButton).accessibilityLabel()
//    helloWorldTextField.stringValue = "Action #" + counter.description + " from: " + buttonAccessLabel!
    self.dismiss(self.presentedViewControllers!.first!)
   print("Trying to dismiss")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        let dataEntryVC = DataEntryVC()
        dataEntryVC.delegate = self
        
        self.view.addSubview(refreshButton)
        refreshButton.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 80, height: 60)
        self.view.addSubview(updateFirebaseButton)
        updateFirebaseButton.anchor(top: self.view.topAnchor, left: nil, bottom: nil, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 80, height: 60)
        self.view.addSubview(servicesButtons)
        servicesButtons.anchor(top: self.refreshButton.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 60)
        self.view.addSubview(firebaseDataOutputTextView)
        firebaseDataOutputTextView.anchor(top: servicesButtons.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
        DataService.instance.delegate = self
        DataService.instance.getServicesApiData()
        self.updateFirebaseLabel()
        //
        let array = [unichar(NSRightArrowFunctionKey)]
        updateFirebaseButton.keyEquivalent = String(utf16CodeUnits: array, count: 1)
        
        
    }
    private func refresh(){
        clearTextField()
        DataService.instance.getServicesApiData()
        updateFirebaseLabel()
    }
    override func awakeFromNib() {
        if self.view.layer != nil {
            let color = NSColor.tableViewBackgroundColor.cgColor
            self.view.layer?.backgroundColor = color
        }
    }
    @objc private func resfreshClicked() {
        print("Refreshing Data...")
        clearTextField()
        DataService.instance.getServicesApiData()
//        updateFirebaseLabel()
    }
    func updateFirebaseLabel(){
        let serviceString = DataService.instance.serviceString
        firebaseDataOutputTextView.textStorage?.append(NSAttributedString(string:serviceString))
        
    }
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        // showDataEntry
        //
    }
    
    @objc private func showUpdateController(sender :NSButton){
        print("trying to show updater")
        let pc = DataEntryVC(nibName: nil, bundle: nil)
        print(pc.isViewLoaded)
        let x = pc.view // accessing the view property before it has a value
        x.layer?.backgroundColor = CGColor.init(red: 1, green: 0, blue: 0, alpha: 1)
        print(pc.isViewLoaded)
//        present(pc, asPopoverRelativeTo: (sender.bounds), of: sender, preferredEdge: NSRectEdge.maxX, behavior: NSPopover.Behavior.applicationDefined)
        let push = PushAnimator()
        present(pc, animator: push)
       
  performSegue(withIdentifier: "showDataEntry", sender: self)
        
    }
    private func updateFirebaseLabelWithService(singleService:String){
        let serviceArray = DataService.instance.serviceArray
        var serviceDictionary = [String:Dictionary<String, AnyObject>]()
        for service in serviceArray {
            if service.key == singleService {
                serviceDictionary = [service.key : service.value]
                let jsonData = try! JSONSerialization.data(withJSONObject: serviceDictionary, options: [])
                let decoded = String(data: jsonData, encoding: .utf8)!
                firebaseDataOutputTextView.textStorage?.append(NSAttributedString(string:decoded))
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
class PushSegue: NSStoryboardSegue {
    override func perform() {
        (sourceController as AnyObject).present(destinationController as! NSViewController, animator: PushAnimator())
    }
}


class PushAnimator:  NSObject, NSViewControllerPresentationAnimator  {
    
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        viewController.view.wantsLayer = true
        viewController.view.frame = CGRect(x: fromViewController.view.frame.size.width, y: 0,
                                           width: fromViewController.view.frame.size.width, height: fromViewController.view.frame.size.height)
        fromViewController.addChild(viewController)
        fromViewController.view.addSubview(viewController.view)
        
        let futureFrame = CGRect(x: 0, y: 0, width: viewController.view.frame.size.width,
                                 height: viewController.view.frame.size.height)
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.75
            viewController.view.animator().frame = futureFrame
            
        }, completionHandler:nil)
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        let futureFrame = CGRect(x: viewController.view.frame.size.width, y: 0,
                                 width: viewController.view.frame.size.width, height: viewController.view.frame.size.height)
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.75
            context.completionHandler = {
                viewController.view.removeFromSuperview()
                viewController.removeFromParent()
            }
            
            viewController.view.animator().frame = futureFrame
        }, completionHandler: nil)
        
    }
}
