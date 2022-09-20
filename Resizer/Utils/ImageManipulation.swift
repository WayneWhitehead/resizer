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
    
    func convertImage(imagePath: URL, convert: Bool, useIphone: Bool, useIpad: Bool, useMacOS: Bool, useiOS: Bool, useAndroidImage: Bool, useAndroidIcon: Bool, imageName: String, directory: URL) {
        if (convert){
            checkImageValidity(imagePath: imagePath)
            
            if (continueWithImage) {
                var devices = [Device]()
                if useIphone { devices.append(Device.iPhone) }
                if useIpad { devices.append(Device.iPad) }
                if useMacOS { devices.append(Device.macOS) }
                if useAndroidIcon { devices.append(Device.Android)}
                
                if (useMacOS || useIphone || useIpad) {
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
                        saveImages(path: directory.appendingPathComponent("AppIcon.appiconset/"), images: iPadImages)
                    case Device.macOS:
                        let macOsImages = ImageModel.init().getMacOSImageSizes(imagePath: imagePath)
                        saveImages(path: directory.appendingPathComponent("AppIcon.appiconset/"), images: macOsImages)
                    case Device.Android:
                        let androidImages = ImageModel.init().getAndroidIconSizes(imagePath: imagePath)
                        saveAndroidIcon(path: directory, images: androidImages)
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
            if useAndroidImage {
                var name = imageName
                let androidImages = ImageModel.init().getAndroidImageSizes(imagePath: imagePath)
                if (name == "") {
                    name = "android"
                }
                saveAndroidImage(path: directory, images: androidImages, imageName: name)
            }
        }
    }
    
    func saveAndroidImage(path: URL, images: [ImageModel], imageName: String) {
        images.forEach { item in
            let location = path.appendingPathComponent("Android/drawable-\(item.name)/", isDirectory: true)
            FileManager().createFolder(path: location)
            item.imageFile.pngWrite(to: FileManager().NewPath(path: location, name: imageName + ".png"))
        }
    }
    
    func saveAndroidIcon(path: URL, images: [ImageModel]) {
        images.forEach { item in
            let location = path.appendingPathComponent("Android/mipmap-\(item.name)/", isDirectory: true)
            FileManager().createFolder(path: location)
            item.imageFile.pngWrite(to: FileManager().NewPath(path: location, name: "ic_launcher_foreground.png"))
            item.imageFile.roundCorners(withRadius: CGFloat(item.imageFile.representations[0].pixelsWide/2), image: item.imageFile)
                        .pngWrite(to: FileManager().NewPath(path: location, name: "ic_launcher_round.png"))
            item.imageFile.roundCorners(withRadius: CGFloat(item.imageFile.representations[0].pixelsWide/10), image: item.imageFile)
                        .pngWrite(to: FileManager().NewPath(path: location, name: "ic_launcher.png"))
        }
    }
    
    func saveImages(path: URL, images: [ImageModel]) {
        images.forEach { item in
            item.imageFile.pngWrite(to: FileManager().NewPath(path: path , name: item.name))
        }
    }
    
    func checkImageValidity(imagePath: URL){
        let image = NSImage(contentsOf: imagePath)!
        let height = image.pixelSize!.height
        let width = image.pixelSize!.width
        var message = ""
    
        if width < 1024 || height < 1024 {
            message += "Image is not 1024x1024\n"
        }
        if height/width != 1 {
            message += "Image is not square\n"
        }
        if !message.isEmpty {
            NSAlert.init().showCloseAlert(text: message) { answer in
                continueWithImage = answer
            }
        }
    }
}
