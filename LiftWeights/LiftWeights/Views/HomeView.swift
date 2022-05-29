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
    
    var routines: [Routine] {
        var list = viewModel.routines
        for routine in routinesCoreData {
            list.append(routine.convertToRoutine())
        }
        list.sort {
            $0.id < $1.id
        }
        return list
    }
    
    var body: some View {
        NavigationView {
            List(routines) { routine in
                NavigationLink(destination: RoutineView()) {
                    RoutineRowView(viewModel: viewModel, routine: routine)
                }
            }.navigationTitle("Routines")
                .listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            viewModel.addRoutine(viewContext: viewContext)
                        }, label: {
                            Label("New Routine", systemImage: "plus")
                        })
                    }
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
