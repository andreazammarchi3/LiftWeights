//
//  ContentView.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import SwiftUI

struct ContentView: View {
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        TabView {
            HomeView(viewModel: DataLoader())
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }
            StatsView()
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Stats")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
