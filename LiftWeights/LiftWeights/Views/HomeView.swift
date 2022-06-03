//
//  HomeView.swift
//  LiftWeights
//
//  Created by Andrea on 27/05/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: DataLoader
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var routinesCoreData: FetchedResults<RoutineEntity>
    
    @State var showAddRoutineView = false
    
    var routines: [Routine] {
        var list = viewModel.routines
        for routine in routinesCoreData {
            list.append(routine.convertToRoutine())
        }
        list.sort {
            $0.id < $1.id
        }
        
        UserDefaults.standard.set(list.last?.id ?? 0, forKey: "lastID")
        return list
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(routines) { routine in
                    NavigationLink(destination: RoutineView(routine: routine)) {
                        RoutineRowView(viewModel: viewModel, routine: routine)
                    }
                }.onDelete { indexSet in
                    var itemsToRemove = [RoutineEntity]()
                    for indexToRemove in indexSet {
                        itemsToRemove.append(contentsOf: routinesCoreData.filter { item in
                            item.id == routines[indexToRemove].id
                        })
                        viewModel.deleteRoutines(routines: itemsToRemove, viewContext: viewContext)
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
                        .environment(\.managedObjectContext, viewContext)
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
