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
}
