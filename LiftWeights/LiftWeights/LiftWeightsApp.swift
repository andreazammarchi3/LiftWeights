//
//  LiftWeightsApp.swift
//  LiftWeights
//
//  Created by Andrea on 25/05/22.
//

import SwiftUI

@main
struct LiftWeightsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: DataLoader())
        }
    }
}
