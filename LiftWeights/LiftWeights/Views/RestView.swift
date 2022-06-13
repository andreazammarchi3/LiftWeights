//
//  RestView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct RestView: View {
    
    @ObservedObject var viewModel: DataLoader

    @Environment(\.dismiss) var dismiss
    
    var circularProgressView: CircularProgressView
    
    let countTo: Int
    
    @State private var counter = 0
    
    @State var  timer: Timer.TimerPublisher = Timer
        .publish(every: 1, on: .main, in: .common)
    
    init(viewModel: DataLoader) {
        self.viewModel = viewModel
        self.countTo = viewModel.restExTime
        self.circularProgressView = CircularProgressView(countTo: countTo, countInMinutes: false)
        startTimer()
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("RESTING...")
                .font(.largeTitle)
                .bold()
            
            circularProgressView
                .frame(width: 200, height: 200)
                .padding()
        }.onReceive(timer) { time in
            if (counter < countTo) {
                counter += 1
            } else {
                stopTimer()
                dismiss()
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

struct RestView_Previews: PreviewProvider {
    static var previews: some View {
        RestView(viewModel: DataLoader())
    }
}
