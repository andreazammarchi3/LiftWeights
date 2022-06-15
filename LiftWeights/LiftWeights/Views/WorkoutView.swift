//
//  WorkoutView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct WorkoutView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var workout: Workout
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 250, height: 210, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.label), lineWidth: 5))
                .background(LinearGradientView(viewModel: viewModel, radius: 20))
                .foregroundColor(.clear)
                .padding(5)
            
            WorkoutDetailsView(workout: workout, viewModel: viewModel)
        }
    }
}

struct WorkoutDetailsView: View {
    
    var workout: Workout
    
    @ObservedObject var viewModel: DataLoader
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(workout.date)")
                .font(.title2.bold())
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 20)
            
            Text("\(getRoutineName(workout: workout))")
                .font(.title2.bold())
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white.opacity(0.3))
                    .frame(height: 110, alignment: .center)
                
                VStack {
                    HStack(alignment: .center) {
                        Text("Total duration:")
                            .font(.title3.bold())
                        
                        Spacer()
                        
                        Text("\(workout.totalTime) min")
                    }
                    
                    HStack(alignment: .center) {
                        Text("Working time:")
                            .font(.title3.bold())
                        
                        Spacer()
                        
                        Text("\(workout.workTime) min")
                    }
                    
                    HStack(alignment: .center) {
                        Text("Resting time:")
                            .font(.title3.bold())
                        
                        Spacer()
                        
                        Text("\(workout.restTime) min")
                    }
                    
                }.padding(.leading, 10)
                    .padding(.trailing, 10)
            }.padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 10)
        }
    }
    
    func getRoutineName(workout: Workout) -> String {
        if let routineOffset = viewModel.routines.firstIndex(where: {$0.id == workout.routineId}) {
            return viewModel.routines[routineOffset].name
        } else {
            return ""
        }
    }
}

/*
struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
*/
