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
                    var exercisesToRemove = [Exercise]()
                    for indexToRemove in indexSet {
                        exercisesToRemove.append(contentsOf: routine.exercises.filter { item in
                            item.id == routine.exercises[indexToRemove].id
                        })
                    }
                }
            }.navigationTitle("Exercises").font(.title3)
                .listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            
                        }, label: {
                            Text("Start")
                        })
                    }
                    
                    ToolbarItem {
                        Button(action: {
                            
                        }, label: {
                            Text("Add Exercise")
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
