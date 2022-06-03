//
//  RoutineView.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import SwiftUI

struct RoutineView: View {
    @ObservedObject var viewModel: DataLoader
    
    var routine: Routine
    
    var body: some View {
        NavigationView {
            List {
                ForEach(routine.exercises) { exercise in
                    NavigationLink(destination: ExView(exercise: exercise)) {
                        ExRowView(viewModel: viewModel, exercise: exercise)
                    }
                }.onDelete { indexSet in
                    var itemsToRemove = [ExEntity]()
                    for indexToRemove in indexSet {
                        itemsToRemove.append(contentsOf: routinesCoreData.filter { item in
                            item.id == routine.exercises[indexToRemove].id
                        })
                        viewModel.deleteExercises(exercises: itemsToRemove, viewContext: viewContext)
                    }
                }
            }.navigationTitle("Exercises")
                .listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            
                        }, label: {
                            Text("Start")
                        })
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Edit")
                        })
                    }
                }
        }.navigationTitle(routine.name)
    }
}

/*
struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineView()
    }
}
*/
