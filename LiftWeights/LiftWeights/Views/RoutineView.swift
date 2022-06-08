//
//  RoutineView.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import SwiftUI

struct RoutineView: View {
    @ObservedObject var viewModel: DataLoader
    
    @State var showAddExView = false
    
    var routine: Routine
    
    var body: some View {
        List {
            ForEach(routine.exercises) { exercise in
                NavigationLink(destination: ExView(viewModel: viewModel, routine: routine, exercise: exercise)) {
                    RowView(exercise: exercise)
                }
            }.onDelete { indexSet in
                var exercisesToRemove = [Exercise]()
                for indexToRemove in indexSet {
                    exercisesToRemove.append(contentsOf: routine.exercises.filter { item in
                        item.id == routine.exercises[indexToRemove].id
                    })
                }
                viewModel.deleteExercises(routine: routine, exercises: exercisesToRemove)
            }
        }.navigationTitle(routine.name)
            .listStyle(PlainListStyle())
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }, label: {
                        Text("Start")
                        Label("Start Routine", systemImage: "play.circle")
                    })
                        .border(.green, width: 2)
                        .foregroundColor(.green)
                    
                    Button(action: {
                        showAddExView = true
                    }, label: {
                        Label("New Exercise", systemImage: "plus")
                    })
                }
            }.sheet(isPresented: $showAddExView) {
                AddExView(routine: routine, viewModel: viewModel)
            }
    }
}

/*
struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineView()
    }
}
*/
