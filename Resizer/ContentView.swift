//
//  ContentView.swift
//  Resizer
//
//  Created by Wayne on 2022/02/24.
//

import SwiftUI
import CoreData
import Foundation
import AppKit

struct ContentView: View {
    @State var useIphone = true
    @State var useIpad = true
    @State var useiOS = true
    @State var image = Image(nsImage: #imageLiteral(resourceName: "placeholder"))
    @State var imageLabel = "Choose Photo"
    @State var imagePath = URL(string: "")
    @State var displayConvert = false
    
    
    @State var displayNameInput = false
    @State var imageName = ""
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        VStack(alignment: .center) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
                .onTapGesture {
                    uploadFile()
                }
            
            Text(imageLabel)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .onTapGesture {
                    uploadFile()
                }
            
            HStack(alignment: .center) {
                Toggle("iPhone Launch Icons", isOn: $useIphone)
                Toggle("iPad Launch Icons", isOn: $useIpad)
                Toggle("iOS Image", isOn: $useiOS)
            }
                
            if useiOS && displayConvert {
                HStack(spacing: 0) {
                    TextFieldDynamicWidth(title: "Enter Image Name", text: $imageName) { editingChange in
                    } onCommit: {
                    }.font(.headline).multilineTextAlignment(.center)
                }
            }
            
            if displayConvert {
                Button("Convert") {
                    convertImage(imagePath: self.imagePath!)
                }
            }
        }
        .frame(width: 400.0, height: 400.0)
        .padding(10)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.136)/*@END_MENU_TOKEN@*/)
    }
    
    func convertImage(imagePath: URL) {
        self.imagePath = imagePath
        
        if (displayConvert){
            
            if (useIpad || useIphone) {
                let IOSPATH = FileManager().downloadsDirectory().appendingPathComponent("AppIcon.appiconset/", isDirectory: true)
                createFolder(path: IOSPATH)
                
                let bundlePath = Bundle.main.path(forResource: "Contents",ofType: "json")
                do {
                    let jsonString = try String(contentsOfFile: bundlePath!)
                    do {
                        let path = FileManager().downloadsDirectory().appendingPathComponent("AppIcon.appiconset/Contents.json", isDirectory: true)
                        try jsonString.write(to: path, atomically: true, encoding: .utf8)
                    } catch {
                        let e = error
                        print(e)
                    }
                } catch {
                    print(error)
                }
                
                let otherImages = ImageModel.init().getOtherImageSizes(image: NSImage(contentsOf: imagePath)!, imagePath: imagePath)
                saveImages(path: IOSPATH, images: otherImages)
            }
            if useIphone {
                let iPhoneImages = ImageModel.init().getIphoneImageSizes(imagePath: imagePath)
                saveImages(path: FileManager().downloadsDirectory().appendingPathComponent("AppIcon.appiconset/"), images: iPhoneImages)
            }
            if useIpad {
                let iPadImages = ImageModel.init().getIpadImageSizes(imagePath: imagePath)
                saveImages(path: FileManager().downloadsDirectory().appendingPathComponent("AppIcon.appiconset/"),images: iPadImages)
            }
            if useiOS {
                if (imageName == "") {
                   imageName = "iOSImage"
                }
                let iOSImages = ImageModel.init().getiOSImageSizes(imagePath: imagePath)
                print(imageName)
                let IOSPATH = FileManager().downloadsDirectory().appendingPathComponent(imageName.replacingOccurrences(of: " ", with: ""))
                createFolder(path: IOSPATH)
                saveImages(path: IOSPATH, images: iOSImages)
            }
        }
    }
    
    func saveImages(path: URL, images: [ImageModel]) {
        images.forEach { item in
            item.imageFile.pngWrite(to: FileManager().NewPath(path: path , name: item.name))
        }
    }
    
    func createFolder(path: URL) {
        do {
            try FileManager.default.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func uploadFile(){
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Select File"
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedContentTypes = [.png, .jpeg, .image]
        openPanel.begin { (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                let selectedPath = openPanel.urls.first
                image = Image(nsImage: NSImage(contentsOf: selectedPath!)!)
                self.imageLabel = selectedPath!.absoluteString
                imagePath = selectedPath!
                displayConvert = true
                //convertImage(imagePath: selectedPath!)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
