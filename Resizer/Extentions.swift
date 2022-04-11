//
//  Extentions.swift
//  Resizer
//
//  Created by Wayne on 2022/02/25.
//

import Foundation
import SwiftUI
import AppKit

extension FileManager{
    func downloadsDirectory() -> URL {
        return FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
    }
    func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    func desktopDirectory() -> URL {
        return FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    }
    func NewPath(path: URL, name: String) -> URL {
        return path.appendingPathComponent(name)
    }
    
    func chooseDirectory() -> URL{
        var selectedPath = URL(string: "")
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Select Directory"
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true
        openPanel.canChooseFiles = false
        openPanel.allowedContentTypes = [.directory]
        openPanel.begin { (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                selectedPath = openPanel.urls.first
            }
        }
        return selectedPath!
    }
}

extension NSImage {
    func resize(image: NSImage, w: Double, h: Double) -> NSImage {
        let destSize = NSMakeSize(CGFloat(w), CGFloat(h))
        let newImage = NSImage(size: destSize)
        newImage.lockFocus()
        image.draw(in: NSMakeRect(0, 0, destSize.width, destSize.height), from: NSMakeRect(0, 0, image.size.width, image.size.height), operation: NSCompositingOperation.sourceOver, fraction: CGFloat(1))
        newImage.unlockFocus()
        newImage.size = destSize
        return NSImage(data: newImage.tiffRepresentation!)!
    }
    var pngData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        return bitmapImage.representation(using: .png, properties: [:])
    }
    func pngWrite(to url: URL, options: Data.WritingOptions = .atomic) {
        do {
            try pngData?.write(to: url, options: options)
        } catch {
            print(error)
        }
    }
}

struct TextFieldDynamicWidth: View {
    let title: String
    @Binding var text: String
    let onEditingChanged: (Bool) -> Void
    let onCommit: () -> Void
    
    @State private var textRect = CGRect()
    
    var body: some View {
        ZStack {
            Text(text == "" ? title : text).background(GlobalGeometryGetter(rect: $textRect)).layoutPriority(1).opacity(0)
            HStack {
                TextField(title, text: $text, onEditingChanged: onEditingChanged, onCommit: onCommit)
                    .frame(width: textRect.width + 10)
            }
        }
    }
}

struct GlobalGeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }
    
    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global)
        }
        
        return Rectangle().fill(Color.clear)
    }
}

