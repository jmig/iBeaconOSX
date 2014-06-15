//
//  MainWindowController.swift
//  iBeaconOSX
//
//  Created by Jerome Miglino on 6/14/14.
//  Copyright (c) 2014 jmig. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet var uuidTextField : NSTextField
    @IBOutlet var majorTextField : NSTextField
    @IBOutlet var minorTextField : NSTextField
    @IBOutlet var powerTextField : NSTextField

    @IBOutlet var triggerButton : NSButton

    override func windowDidLoad() {
        super.windowDidLoad()

        triggerButton.target = self
        triggerButton.action = "didPressTriggerButton:"
    }

    func didPressTriggerButton(sender: AnyObject?) {
        NSLog("Hello")
    }
}
