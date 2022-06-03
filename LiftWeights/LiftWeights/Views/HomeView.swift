//
//  HomeView.swift
//  LiftWeights
//
//  Created by Andrea on 27/05/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: DataLoader
    
    @State var showAddRoutineView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.routines) { routine in
                    NavigationLink(destination: RoutineView(viewModel: viewModel, routine: routine)) {
                        RoutineRowView(viewModel: viewModel, routine: routine)
                    }
                }.onDelete { indexSet in
                    var itemsToRemove = [Routine]()
                    for indexToRemove in indexSet {
                        itemsToRemove.append(contentsOf: viewModel.routines.filter { item in
                            item.id == viewModel.routines[indexToRemove].id
                        })
                        viewModel.deleteRoutines(routines: itemsToRemove)
                    }
                }
            }.navigationTitle("Routines")
                .listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            showAddRoutineView = true
                        }, label: {
                            Label("New Routine", systemImage: "plus")
                        })
                    }
                }.sheet(isPresented: $showAddRoutineView) {
                    AddRoutineView(viewModel: viewModel)
                }
        }
    }
}

/*
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            
    }
}
*/
