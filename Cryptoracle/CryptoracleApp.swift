//
//  CryptoracleApp.swift
//  Cryptoracle
//
//  Created by Daniel on 11/09/23.
//

import SwiftUI

@main
struct CryptoracleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
