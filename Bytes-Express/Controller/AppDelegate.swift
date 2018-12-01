//
//  AppDelegate.swift
//  Bytes-Express
//
//  Created by Kev1 on 11/23/18.
//  Copyright © 2018 Kev1. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window:NSWindow?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        // Insert code here to tear down your application
        window = NSWindow()
        window?.contentViewController = MainVC()
        window?.makeKey()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
       
        
    }


}

