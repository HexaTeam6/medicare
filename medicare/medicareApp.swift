//
//  medicareApp.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 05/05/22.
//

import SwiftUI

@main
struct medicareApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            HistoryView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
