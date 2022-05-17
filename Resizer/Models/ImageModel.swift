//
//  ImageModel.swift
//  Resizer
//
//  Created by Wayne on 2022/02/25.
//

import Foundation
import SwiftUI

class ImageModel {
    var name = ""
    var imageFile = #imageLiteral(resourceName: "placeholder")
    
    init(){}
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, image: NSImage) {
        self.name = name
        self.imageFile = image
    }
    
    func getIphoneImageSizes(imagePath: URL) -> [ImageModel] {
        var iPhoneImages = [ImageModel]()
        let image = NSImage(contentsOf: imagePath)!
        iPhoneImages.append(ImageModel(
            name: "iphone-20@2x.png",
            image: NSImage().resize(image: image, w: 20, h: 20)))
        iPhoneImages.append(ImageModel(
            name: "iphone-20@3x.png",
            image: NSImage().resize(image: image, w: 30, h: 30)))
        iPhoneImages.append(ImageModel(
            name: "iphone-29@1x.png",
            image: NSImage().resize(image: image, w: 14.5, h: 14.5)))
        iPhoneImages.append(ImageModel(
            name: "iphone-29@2x.png",
            image: NSImage().resize(image: image, w: 29, h: 29)))
        iPhoneImages.append(ImageModel(
            name: "iphone-29@3x.png",
            image: NSImage().resize(image: image, w: 43.5, h: 43.5)))
        iPhoneImages.append(ImageModel(
            name: "iphone-40@2x.png",
            image: NSImage().resize(image: image, w: 40, h: 40)))
        iPhoneImages.append(ImageModel(
            name: "iphone-40@3x.png",
            image: NSImage().resize(image: image, w: 60, h: 60)))
        iPhoneImages.append(ImageModel(
            name: "iphone-60@2x.png",
            image: NSImage().resize(image: image, w: 60, h: 60)))
        iPhoneImages.append(ImageModel(
            name: "iphone-60@3x.png",
            image: NSImage().resize(image: image, w: 90, h: 90)))
        return iPhoneImages
    }
    
    func getIpadImageSizes(imagePath: URL) -> [ImageModel] {
        var iPadImages = [ImageModel]()
        let image = NSImage(contentsOf: imagePath)!
        iPadImages.append(ImageModel(
            name: "ipad-20@1x.png",
            image: NSImage().resize(image: image, w: 10, h: 10)))
        iPadImages.append(ImageModel(
            name: "ipad-20@2x.png",
            image: NSImage().resize(image: image, w: 20, h: 20)))
        iPadImages.append(ImageModel(
            name: "ipad-29@1x.png",
            image: NSImage().resize(image: image, w: 14.5, h: 14.5)))
        iPadImages.append(ImageModel(
            name: "ipad-29@2x.png",
            image: NSImage().resize(image: image, w: 29, h: 29)))
        iPadImages.append(ImageModel(
            name: "ipad-40@1x.png",
            image: NSImage().resize(image: image, w: 20, h: 20)))
        iPadImages.append(ImageModel(
            name: "ipad-40@2x.png",
            image: NSImage().resize(image: image, w: 40, h: 40)))
        iPadImages.append(ImageModel(
            name: "ipad-76@1x.png",
            image: NSImage().resize(image: image, w: 38, h: 38)))
        iPadImages.append(ImageModel(
            name: "ipad-76@2x.png",
            image: NSImage().resize(image: image, w: 76, h: 76)))
        iPadImages.append(ImageModel(
            name: "ipad-83.5@2x.png",
            image: NSImage().resize(image: image, w: 83.5, h: 83.5)))

        return iPadImages
    }
    
    func getMacOSImageSizes(imagePath: URL) -> [ImageModel] {
        var macOsImages = [ImageModel]()
        let image = NSImage(contentsOf: imagePath)!
        macOsImages.append(ImageModel(
            name: "mac-16x16@1x.png",
            image: NSImage().resize(image: image, w: 8, h: 8)))
        macOsImages.append(ImageModel(
            name: "mac-16x16@2x.png",
            image: NSImage().resize(image: image, w: 16, h: 16)))
        macOsImages.append(ImageModel(
            name: "mac-32x32@1x.png",
            image: NSImage().resize(image: image, w: 16, h: 16)))
        macOsImages.append(ImageModel(
            name: "mac-32x32@2x.png",
            image: NSImage().resize(image: image, w: 32, h: 32)))
        macOsImages.append(ImageModel(
            name: "mac-128x128@1x.png",
            image: NSImage().resize(image: image, w: 64, h: 64)))
        macOsImages.append(ImageModel(
            name: "mac-128x128@2x.png",
            image: NSImage().resize(image: image, w: 128, h: 128)))
        macOsImages.append(ImageModel(
            name: "mac-256x256@1x.png",
            image: NSImage().resize(image: image, w: 128, h: 128)))
        macOsImages.append(ImageModel(
            name: "mac-256x256@2x.png",
            image: NSImage().resize(image: image, w: 256, h: 256)))
        macOsImages.append(ImageModel(
            name: "mac-512x512@1x.png",
            image: NSImage().resize(image: image, w: 256, h: 256)))
        macOsImages.append(ImageModel(
            name: "mac-512x512@2x.png",
            image: NSImage().resize(image: image, w: 512, h: 512)))
        return macOsImages
    }
    
    
    func getiOSImageSizes(imagePath: URL) -> [ImageModel] {
        var iOSImages = [ImageModel]()
        let image = NSImage(contentsOf: imagePath)!
        let width = image.representations[0].pixelsWide/2
        let height = image.representations[0].pixelsHigh/2
        iOSImages.append(ImageModel(
            name: "iosImage@1x.png",
            image: NSImage().resize(image: image, w: Double(width/3), h: Double(height/3))))
        iOSImages.append(ImageModel(
            name: "iosImage@2x.png",
            image: NSImage().resize(image: image, w: Double(width/3*2), h: Double(height/3*2))))
        iOSImages.append(ImageModel(
            name: "iosImage@3x.png",
            image: NSImage().resize(image: image, w: Double(width), h: Double(height))))
        return iOSImages
    }
    
    func getOtherImageSizes(image: NSImage, imagePath: URL) -> [ImageModel] {
        var otherImages = [ImageModel]()
        otherImages.append(ImageModel(
            name: "LaunchIcon_1024x1024.png",
            image: NSImage().resize(image: NSImage(contentsOf: imagePath)!, w: 512, h: 512)))
        return otherImages
    }
    
    func getIconJSON(devices: [Device]) -> String {
        var jsonString = "{\"images\":["
        for device in devices {
            switch device {
            case .iPhone: jsonString +=
                "{\"filename\":\"iphone-20@2x.png\",\"idiom\":\"iphone\",\"scale\":\"2x\",\"size\":\"20x20\"},{\"filename\":\"iphone-20@3x.png\",\"idiom\":\"iphone\",\"scale\":\"3x\",\"size\":\"20x20\"},{\"filename\":\"iphone-29@1x.png\",\"idiom\":\"iphone\",\"scale\":\"1x\",\"size\":\"29x29\"},{\"filename\":\"iphone-29@2x.png\",\"idiom\":\"iphone\",\"scale\":\"2x\",\"size\":\"29x29\"},{\"filename\":\"iphone-29@3x.png\",\"idiom\":\"iphone\",\"scale\":\"3x\",\"size\":\"29x29\"},{\"filename\":\"iphone-40@2x.png\",\"idiom\":\"iphone\",\"scale\":\"2x\",\"size\":\"40x40\"},{\"filename\":\"iphone-40@3x.png\",\"idiom\":\"iphone\",\"scale\":\"3x\",\"size\":\"40x40\"},{\"filename\":\"iphone-60@2x.png\",\"idiom\":\"iphone\",\"scale\":\"2x\",\"size\":\"60x60\"},{\"filename\":\"iphone-60@3x.png\",\"idiom\":\"iphone\",\"scale\":\"3x\",\"size\":\"60x60\"},"
                break
            case .iPad: jsonString +=
                "{\"filename\":\"ipad-20@1x.png\",\"idiom\":\"ipad\",\"scale\":\"1x\",\"size\":\"20x20\"},{\"filename\":\"ipad-20@2x.png\",\"idiom\":\"ipad\",\"scale\":\"2x\",\"size\":\"20x20\"},{\"filename\":\"ipad-29@1x.png\",\"idiom\":\"ipad\",\"scale\":\"1x\",\"size\":\"29x29\"},{\"filename\":\"ipad-29@2x.png\",\"idiom\":\"ipad\",\"scale\":\"2x\",\"size\":\"29x29\"},{\"filename\":\"ipad-40@1x.png\",\"idiom\":\"ipad\",\"scale\":\"1x\",\"size\":\"40x40\"},{\"filename\":\"ipad-40@2x.png\",\"idiom\":\"ipad\",\"scale\":\"2x\",\"size\":\"40x40\"},{\"filename\":\"ipad-76@1x.png\",\"idiom\":\"ipad\",\"scale\":\"1x\",\"size\":\"76x76\"},{\"filename\":\"ipad-76@2x.png\",\"idiom\":\"ipad\",\"scale\":\"2x\",\"size\":\"76x76\"},{\"filename\":\"ipad-83.5@2x.png\",\"idiom\":\"ipad\",\"scale\":\"2x\",\"size\":\"83.5x83.5\"},"
                break
            case .macOS: jsonString +=
                "{\"filename\":\"mac-16x16@1x.png\",\"idiom\":\"mac\",\"scale\":\"1x\",\"size\":\"16x16\"},{\"filename\":\"mac-16x16@2x.png\",\"idiom\":\"mac\",\"scale\":\"2x\",\"size\":\"16x16\"},{\"filename\":\"mac-32x32@1x.png\",\"idiom\":\"mac\",\"scale\":\"1x\",\"size\":\"32x32\"},{\"filename\":\"mac-32x32@2x.png\",\"idiom\":\"mac\",\"scale\":\"2x\",\"size\":\"32x32\"},{\"filename\":\"mac-128x128@1x.png\",\"idiom\":\"mac\",\"scale\":\"1x\",\"size\":\"128x128\"},{\"filename\":\"mac-128x128@2x.png\",\"idiom\":\"mac\",\"scale\":\"2x\",\"size\":\"128x128\"},{\"filename\":\"mac-256x256@1x.png\",\"idiom\":\"mac\",\"scale\":\"1x\",\"size\":\"256x256\"},{\"filename\":\"mac-256x256@2x.png\",\"idiom\":\"mac\",\"scale\":\"2x\",\"size\":\"256x256\"},{\"filename\":\"mac-512x512@1x.png\",\"idiom\":\"mac\",\"scale\":\"1x\",\"size\":\"512x512\"},{\"filename\":\"mac-512x512@2x.png\",\"idiom\":\"mac\",\"scale\":\"2x\",\"size\":\"512x512\"},"
                break
            }
        }
        jsonString += "{\"filename\":\"LaunchIcon_1024x1024.png\",\"idiom\":\"ios-marketing\",\"scale\":\"1x\",\"size\":\"1024x1024\"}],\"info\":{\"author\":\"xcode\",\"version\":1}}"
        return jsonString
    }
}

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
