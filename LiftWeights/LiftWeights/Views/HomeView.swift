//
//  HomeView.swift
//  LiftWeights
//
//  Created by Andrea on 27/05/22.
//

import SwiftUI

let customNavAppearance = UINavigationBarAppearance()

struct HomeView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @State var showAddRoutineView = false
    
    init() {
        self.viewModel = DataLoader()
        showAddRoutineView = showAddRoutineView
        
        customNavAppearance.configureWithOpaqueBackground()
        customNavAppearance.backgroundColor = UIColor.systemFill
        customNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        customNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
               
        UINavigationBar.appearance().standardAppearance = customNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = customNavAppearance
        
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.routines) { routine in
                    NavigationLink(destination: RoutineView(viewModel: viewModel, routine: routine)) {
                        RoutineRowView(routine: routine)
                    }.isDetailLink(false)
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
