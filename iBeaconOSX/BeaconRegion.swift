//
//  BeaconRegion.swift
//  iBeaconOSX
//
//  Created by Jerome Miglino on 6/15/14.
//  Copyright (c) 2014 jmig. All rights reserved.
//

import Foundation

class BeaconRegion {

    var uuid: NSUUID
    var major: UInt16
    var minor: UInt16
    var measuredPower: Int8 = -59

    init(uuid: NSUUID, major: UInt16, minor: UInt16) {
        self.uuid = uuid;
        self.major = major;
        self.minor = minor;
    }

    func peripheralDataWithMeasuredPower(power:Int8?) -> NSDictionary {
        if let p = power  {
            if p < 0 {
                self.measuredPower = p
            }
        }

        var advertisementBytes = CUnsignedChar[](count: 21, repeatedValue: 0)
        uuid.getUUIDBytes(&advertisementBytes)
        advertisementBytes[16] = CUnsignedChar(self.major >> 8)
        advertisementBytes[17] = CUnsignedChar(self.major & 255)
        advertisementBytes[18] = CUnsignedChar(self.minor >> 8)
        advertisementBytes[19] = CUnsignedChar(self.minor & 255)
        advertisementBytes[20] = CUnsignedChar(self.measuredPower.asUnsigned())

        let advertisementData = NSMutableData.dataWithBytes(advertisementBytes, length: 21) as NSData
        let beaconKey = "kCBAdvDataAppleBeaconKey";

        return [beaconKey : advertisementData]
    }
}