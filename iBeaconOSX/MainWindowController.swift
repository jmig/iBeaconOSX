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

    @IBOutlet var uuidTextField : NSTextField
    @IBOutlet var majorTextField : NSTextField
    @IBOutlet var minorTextField : NSTextField
    @IBOutlet var powerTextField : NSTextField
    @IBOutlet var btInfoLabel : NSTextField
    @IBOutlet var triggerButton : NSButton

    @lazy var btManager: CBPeripheralManager = {
        var manager = CBPeripheralManager(delegate: self, queue: nil)
        return manager
    }()

    override func windowDidLoad() {
        super.windowDidLoad()

        /** With SDK Based on 10.10 this is how it should be done.
        triggerButton.target = self
        triggerButton.action = "didPressTriggerButton:"
        **/

        triggerButton.setTarget(self);
        triggerButton.setAction("didPressTriggerButton:")

        btManager.delegate = self
    }

    func didPressTriggerButton(sender: AnyObject?) {
        if (btManager.isAdvertising) {
            btManager.stopAdvertising()
            triggerButton.setTitle("Turn iBeacon On")
            uuidTextField.setEnabled(true)
            minorTextField.setEnabled(true)
            majorTextField.setEnabled(true)
            powerTextField.setEnabled(true)
        } else {

            let proximityUUID = NSUUID(UUIDString: uuidTextField.stringValue())
            let beaconRegion = BeaconRegion(uuid: proximityUUID, major: UInt16(majorTextField.intValue()), minor: UInt16(minorTextField.intValue()))
            var advertismentDictionary = beaconRegion.peripheralDataWithMeasuredPower(Int8(self.powerTextField.intValue()))
            btManager.startAdvertising(advertismentDictionary)
            triggerButton.setTitle("Turn iBeacon Off")
            uuidTextField.setEnabled(false)
            minorTextField.setEnabled(false)
            majorTextField.setEnabled(false)
            powerTextField.setEnabled(false)
        }
    }


    //MARK: CBPeripheralManagerDelegate methods

    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        switch (peripheral.state) {
        case .Unknown:
            btInfoLabel.setStringValue("State Unknown")
            triggerButton.setEnabled(false)
        case .Unauthorized:
            btInfoLabel.setStringValue("Unauthorized")
            triggerButton.setEnabled(false)
        case .Resetting:
            btInfoLabel.setStringValue("Resetting")
            triggerButton.setEnabled(false)
        case .PoweredOff:
            btInfoLabel.setStringValue("Bluetooth Off")
            triggerButton.setEnabled(false)
        case .Unsupported:
            btInfoLabel.setStringValue("BLTE not available on your Mac")
            triggerButton.setEnabled(false)
        case .PoweredOn:
            btInfoLabel.setStringValue("System Ready to use")
            triggerButton.setEnabled(true)
        }
    }
}
