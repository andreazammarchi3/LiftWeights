//
//  GetReadyView.swift
//  LiftWeights
//
//  Created by Andrea on 08/06/22.
//

import SwiftUI

struct GetReadyView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var routine: Routine
    
    var circularProgressView: CircularProgressView
    
    @State var counter = 0
    
    @State var finished = false
    
    @State var  timer: Timer.TimerPublisher = Timer
        .publish(every: 1, on: .main, in: .common)
    
    init(routine: Routine, viewModel: DataLoader) {
        self.routine = routine
        self.viewModel = viewModel
        self.circularProgressView = CircularProgressView(countTo: viewModel.getReadyTime, countInMinutes: false)
        startTimer()
    }
    
    
    var body: some View {
        VStack {
            NavigationLink("", isActive: $finished) {
                DoingExView(viewModel: viewModel, routine: routine, exercise: routine.exercises.first!, miniSet: routine.exercises.first!.miniSets.first!)
            }.isDetailLink(false)

            
            Text("Get Ready!")
                .font(.largeTitle)
                .bold()
            
            circularProgressView
                .frame(width: 200, height: 200)
                .padding()
        }.navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)
            .onReceive(timer) { time in
                if (counter < viewModel.getReadyTime) {
                    counter += 1
                } else {
                    stopTimer()
                    finished = true
                }
            }
    }
    
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
        _ = timer.connect()
    }
    
    func stopTimer() {
        timer.connect().cancel()
    }
}

/*
struct GetReadyView_Previews: PreviewProvider {
    static var previews: some View {
        GetReadyView()
    }
}
*/
