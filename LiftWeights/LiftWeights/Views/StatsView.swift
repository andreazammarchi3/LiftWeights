//
//  StatsView.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import SwiftUI

struct StatsView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var workouts: [Workout] {
        var workouts = viewModel.workouts.list
        workouts.sort {
            $0.id > $1.id
        }
        return workouts
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("Global stats")
                    .font(.largeTitle.bold())
                GlobalStatsView(viewModel: viewModel)
                
                Text("Workouts completed")
                    .font(.largeTitle.bold())
                    .padding(.top, 40)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(workouts) { workout in
                            WorkoutView(viewModel: viewModel, workout: workout)
                        }
                    }
                }
                
                Text("Exercises Records")
                    .font(.largeTitle.bold())
                    .padding(.top, 40)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.exercises) { exercise in
                            RecordView(viewModel: viewModel, exercise: exercise)
                        }
                    }
                }
                
                Spacer()
            }
        }.padding(10)
    }
}

struct GlobalStatsView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("Total workouts duration:")
                    .font(.title2.bold())
                HStack(alignment: .center) {
                    FlatProgressBar(viewModel: viewModel, value: 1)
                    Spacer()
                    Text("\(viewModel.getTotalTime()) min")
                }
                
                Text("Working time:")
                    .font(.title2.bold())
                HStack(alignment: .center) {
                    FlatProgressBar(viewModel: viewModel, value: CGFloat(viewModel.getWorkTime())/CGFloat(viewModel.getTotalTime()))
                    Spacer()
                    Text("\(viewModel.getWorkTime()) min")
                }
                Text("Resting time:")
                    .font(.title2.bold())
                HStack(alignment: .center) {
                    FlatProgressBar(viewModel: viewModel, value: CGFloat(viewModel.getRestTime())/CGFloat(viewModel.getTotalTime()))
                    Spacer()
                    Text("\(viewModel.getRestTime()) min")
                }
            }.padding(10)
        }.background(Color(UIColor.label).opacity(0.1))
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct FlatProgressBar: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @State var value: CGFloat
    
    let width: CGFloat = UIScreen.main.bounds.width - 120
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: width, height: 20)
                .foregroundColor(Color(UIColor.label).opacity(0.1))
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: value * width, height: 20)
                .background(
                    LinearGradientView(viewModel: viewModel, radius: 20)
                )
                .foregroundColor(.clear)
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(viewModel: DataLoader())
            .preferredColorScheme(.dark)
    }
}
