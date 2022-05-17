//
//  Device.swift
//  Resizer
//
//  Created by Wayne on 2022/05/17.
//

import Foundation

enum Device: String, CaseIterable, Identifiable {
    case iPhone = "iPhone"
    case iPad = "iPad"
    case macOS = "MacOS"
    var id: String { self.rawValue }
    
    func getName(device: Device)-> String {
        switch device {
        case .iPhone: return Device.iPhone.id
        case .iPad: return Device.iPad.id
        case .macOS: return Device.macOS.id
        }
    }
}
