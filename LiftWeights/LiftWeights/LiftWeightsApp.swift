//
//  LiftWeightsApp.swift
//  LiftWeights
//
//  Created by Andrea on 25/05/22.
//

import SwiftUI

@main
struct LiftWeightsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LauncherView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
