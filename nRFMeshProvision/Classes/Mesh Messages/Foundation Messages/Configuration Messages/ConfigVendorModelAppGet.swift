//
//  ConfigVendorModelAppGet.swift
//  nRFMeshProvision
//
//  Created by Aleksander Nowakowski on 29/07/2019.
//

import Foundation

public struct ConfigVendorModelAppGet: AcknowledgedConfigMessage, ConfigVendorModelMessage {
    public static let opCode: UInt32 = 0x804D
    public static let responseType: StaticMeshMessage.Type = ConfigVendorModelAppList.self
    
    public var parameters: Data? {
        return Data() + elementAddress + companyIdentifier + modelIdentifier
    }
    
    public let elementAddress: Address
    public let modelIdentifier: UInt16
    public let companyIdentifier: UInt16
    
    public init?(of model: Model) {
        guard let companyIdentifier = model.companyIdentifier else {
            // Use ConfigSIGModelAppGet instead.
            return nil
        }
        self.elementAddress = model.parentElement.unicastAddress
        self.modelIdentifier = model.modelIdentifier
        self.companyIdentifier = companyIdentifier
    }
    
    public init?(parameters: Data) {
        guard parameters.count == 6 else {
            return nil
        }
        elementAddress = parameters.read(fromOffset: 0)
        companyIdentifier = parameters.read(fromOffset: 2)
        modelIdentifier = parameters.read(fromOffset: 4)
    }
}