//
//  SaveDirectory.swift
//  Resizer
//
//  Created by Wayne on 2022/02/25.
//

import Foundation
enum SaveDirectory: String, CaseIterable, Identifiable {
    case Desktop = "Desktop"
    case Documents = "Documents"
    case Downloads = "Downloads"
    case Custom = "Custom"
    var id: String { self.rawValue }
    
    func url(directory: SaveDirectory)-> URL {
        switch directory {
        case .Desktop: return FileManager().desktopDirectory()
        case .Documents: return FileManager().documentsDirectory()
        case .Downloads: return FileManager().downloadsDirectory()
        case .Custom: return FileManager().chooseDirectory()
        }
    }
}
