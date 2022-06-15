//
//  StatsView.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import SwiftUI

struct StatsView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("Global stats")
                    .font(.largeTitle.bold())

                GlobalStatsView(viewModel: viewModel)
                
                Text("Workouts completed")
                    .font(.largeTitle.bold())
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.workouts.list) { workout in
                            WorkoutView(viewModel: viewModel, workout: workout)
                        }
                    }
                }
                
                Spacer()
            }
        }.padding(10)
    }
    
    func updateStats() {
        
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
                    Text("\(getTotalTime()) min")
                }
                
                Text("Working time:")
                    .font(.title2.bold())
                HStack(alignment: .center) {
                    FlatProgressBar(viewModel: viewModel, value: 0.75)
                    Spacer()
                    Text("\(getWorkTime()) min")
                }
                Text("Resting time:")
                    .font(.title2.bold())
                HStack(alignment: .center) {
                    FlatProgressBar(viewModel: viewModel, value: 0.25)
                    Spacer()
                    Text("\(getRestTime()) min")
                }
            }.padding(10)
        }.background(Color(UIColor.label).opacity(0.1))
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private func getTotalTime() -> Int {
        var res: Int = 0
        for workout in viewModel.workouts.list {
            res += workout.totalTime
        }
        return res
    }
    
    private func getWorkTime() -> Int {
        var res: Int = 0
        for workout in viewModel.workouts.list {
            res += workout.workTime
        }
        return res
    }
    
    private func getRestTime() -> Int {
        var res: Int = 0
        for workout in viewModel.workouts.list {
            res += workout.restTime
        }
        return res
    }
    
    private func formatted(input: Float) -> String {
        let res = String(format: "%.0f", input)
        return res
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
