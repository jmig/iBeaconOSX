//
//  MainWindowController.swift
//  iBeaconOSX
//
//  Created by Jerome Miglino on 6/14/14.
//  Copyright (c) 2014 jmig. All rights reserved.
//

import Cocoa
import IOBluetooth

class MainWindowController: NSWindowController, CBPeripheralManagerDelegate {

    @IBOutlet var uuidTextField : NSTextField?
    @IBOutlet var majorTextField : NSTextField?
    @IBOutlet var minorTextField : NSTextField?
    @IBOutlet var powerTextField : NSTextField?
    @IBOutlet var btInfoLabel : NSTextField?
    @IBOutlet var triggerButton : NSButton?

    lazy var btManager: CBPeripheralManager = {
        var manager = CBPeripheralManager(delegate: self, queue: nil)
        return manager
    }()

    override func windowDidLoad() {
        super.windowDidLoad()
        triggerButton?.target = self;
        triggerButton?.action = "didPressTriggerButton:"
        btManager.delegate = self
    }

    func didPressTriggerButton(sender: AnyObject?) {
        if (btManager.isAdvertising) {
            btManager.stopAdvertising()
            triggerButton?.title = "Turn iBeacon On"
            uuidTextField?.enabled = true
            minorTextField?.enabled = true
            majorTextField?.enabled = true
            powerTextField?.enabled = true
        } else {
            let proximityUUID = NSUUID(UUIDString: uuidTextField!.stringValue)
            let beaconRegion = BeaconRegion(uuid: proximityUUID!, major: UInt16(majorTextField!.intValue), minor: UInt16(minorTextField!.intValue))
            var advertismentDictionary = beaconRegion.peripheralDataWithMeasuredPower(Int8(self.powerTextField!.intValue))
            btManager.startAdvertising(advertismentDictionary)
            triggerButton?.title = "Turn iBeacon Off"
            uuidTextField?.enabled = false
            minorTextField?.enabled = false
            majorTextField?.enabled = false
            powerTextField?.enabled = false
        }
    }


    //MARK: CBPeripheralManagerDelegate methods

    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        switch (peripheral.state) {
        case .Unknown:
            btInfoLabel?.stringValue = "State Unknown"
            triggerButton?.enabled = false
        case .Unauthorized:
            btInfoLabel?.stringValue = "Unauthorized"
            triggerButton?.enabled = false
        case .Resetting:
            btInfoLabel?.stringValue = "Resetting"
            triggerButton?.enabled = false
        case .PoweredOff:
            btInfoLabel?.stringValue = "BT Off"
            triggerButton?.enabled = false
        case .Unsupported:
            btInfoLabel?.stringValue = "BLTE not supported on your Mac"
            triggerButton?.enabled = false
        case .PoweredOn:
            btInfoLabel?.stringValue = "All Set, System ready to use"
            triggerButton?.enabled = true
        }
    }
}
