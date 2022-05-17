//
//  ResizerApp.swift
//  Resizer
//
//  Created by Wayne on 2022/02/24.
//

import SwiftUI

@main
struct ResizerApp: App {

    var body: some Scene {
        WindowGroup {
            ConvertImageView().environment(\.managedObjectContext, NSManagedObjectContext.init(.mainQueue))
        }
    }
}
