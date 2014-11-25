//
//  AppDelegate.swift
//  iBeaconOSX
//
//  Created by Jerome Miglino on 6/14/14.
//  Copyright (c) 2014 jmig. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var mainWindowController: MainWindowController = {
        var windowController = MainWindowController(windowNibName: "MainWindow")
        return windowController
    }()

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        mainWindowController.showWindow(nil)
        mainWindowController.window?.makeKeyAndOrderFront(nil);
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}

