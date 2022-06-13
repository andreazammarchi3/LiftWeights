//
//  ContentView.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @State var tabSelection = 1
    
    var body: some View {
        TabView {
            HomeView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            StatsView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Stats")
                }
            UserView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "person")
                    Text("User")
                }
        }.animation(.easeOut, value: tabSelection)
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
