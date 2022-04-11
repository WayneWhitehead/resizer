//
//  ResizerApp.swift
//  Resizer
//
//  Created by Wayne on 2022/02/24.
//

import SwiftUI

@main
struct ResizerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
