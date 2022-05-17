//
//  ImageManipulation.swift
//  Resizer
//
//  Created by Wayne on 2022/05/17.
//

import Foundation
import SwiftUI

class ImageManipulation {
    var continueWithImage = true
    init(){}
    
    func convertImage(imagePath: URL, convert: Bool, useIphone: Bool, useIpad: Bool, useMacOS: Bool, useiOS: Bool, imageName: String, directory: URL) {
        if (convert){
            checkImageValidity(imagePath: imagePath)
            
            if (continueWithImage) {
                var devices = [Device]()
                if useIphone { devices.append(Device.iPhone) }
                if useIpad { devices.append(Device.iPad) }
                if useMacOS { devices.append(Device.macOS) }
                
                if (devices.count > 0) {
                    let PATH = directory.appendingPathComponent("AppIcon.appiconset/", isDirectory: true)
                    FileManager().createFolder(path: PATH)
                    let jsonString = ImageModel.init().getIconJSON(devices: devices)
                    do {
                        let path = directory.appendingPathComponent("AppIcon.appiconset/Contents.json", isDirectory: true)
                        try jsonString.write(to: path, atomically: true, encoding: .utf8)
                    } catch { print(error) }
                    
                    let otherImages = ImageModel.init().getOtherImageSizes(image: NSImage(contentsOf: imagePath)!, imagePath: imagePath)
                    saveImages(path: PATH, images: otherImages)
                }
                for device in devices {
                    switch device {
                    case Device.iPhone:
                        let iPhoneImages = ImageModel.init().getIphoneImageSizes(imagePath: imagePath)
                        saveImages(path: directory.appendingPathComponent("AppIcon.appiconset/"), images: iPhoneImages)
                    case Device.iPad:
                        let iPadImages = ImageModel.init().getIpadImageSizes(imagePath: imagePath)
                        saveImages(path: directory.appendingPathComponent("AppIcon.appiconset/"),images: iPadImages)
                    case Device.macOS:
                        let macOsImages = ImageModel.init().getMacOSImageSizes(imagePath: imagePath)
                        saveImages(path: directory.appendingPathComponent("AppIcon.appiconset/"),images: macOsImages)
                    }
                }
            }
            if useiOS {
                var PATH = directory.appendingPathComponent(imageName.replacingOccurrences(of: " ", with: ""))
                if (imageName == "") {
                    PATH = directory.appendingPathComponent("iOSImage")
                }
                let iOSImages = ImageModel.init().getiOSImageSizes(imagePath: imagePath)
                
                FileManager().createFolder(path: PATH)
                saveImages(path: PATH, images: iOSImages)
            }
        }
    }
    
    func saveImages(path: URL, images: [ImageModel]) {
        images.forEach { item in
            item.imageFile.pngWrite(to: FileManager().NewPath(path: path , name: item.name))
        }
    }
    
    func checkImageValidity(imagePath: URL){
        let image = NSImage(contentsOf: imagePath)!
        if image.size.width < 1024 || image.size.height < 1024 {
            print(image.size.width)
            print(image.size.height)
            NSAlert.init().showCloseAlert(text: "Image is not 1024x1024") { answer in
                continueWithImage = answer
            }
        }
        if image.size.height/image.size.width != 1 {
            NSAlert.init().showCloseAlert(text: "Image does not have a square aspect ratio") { answer in
                continueWithImage = answer
            }
        }
    }
}
