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

struct ConvertImageView: View {
    @State var image = Image(nsImage: #imageLiteral(resourceName: "placeholder"))
    @State var imageLabel = "Choose Photo"
    @State var imagePath = URL(string: "")
    @State var imageName = ""
    
    @State var useIphone = true
    @State var useIpad = true
    @State var useMacOS = true
    @State var useiOS = true
    
    @State var displayConvert = false
    @State var displayNameInput = false
    @State private var selectedDirectory: SaveDirectory = .Downloads
    
    @Environment(\.managedObjectContext) private var viewContext

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
            
            Picker("Save Directory", selection: $selectedDirectory) {
                Text("Desktop").tag(SaveDirectory.Desktop)
                Text("Documents").tag(SaveDirectory.Documents)
                Text("Downloads").tag(SaveDirectory.Downloads)
            }
            .frame(width: 300.0)
            
            HStack(alignment: .center) {
                Toggle("iPhone Icons", isOn: $useIphone)
                Toggle("iPad Icons", isOn: $useIpad)
                Toggle("MacOs Icons", isOn: $useMacOS)
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
                    ImageManipulation.init().convertImage(imagePath: self.imagePath!, convert: displayConvert, useIphone: useIphone, useIpad: useIpad, useMacOS: useMacOS, useiOS: useiOS, imageName: imageName, directory: selectedDirectory.url(directory: selectedDirectory))
                }
            }
        }
        .frame(width: 400.0)
        .padding(20)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.136)/*@END_MENU_TOKEN@*/)
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertImageView().environment(\.managedObjectContext, NSManagedObjectContext.init(.mainQueue))
    }
}
