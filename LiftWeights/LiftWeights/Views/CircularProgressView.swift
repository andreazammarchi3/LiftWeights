//
//  CircularProgressView.swift
//  LiftWeights
//
//  Created by Andrea on 08/06/22.
//

import SwiftUI

struct CircularProgressView: View {
    
    @State private var counter: Int = 0
    
    var countTo: Int
    
    var countInMinutes: Bool
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.blue.opacity(0.5),
                    lineWidth: 30
                )
            Circle()
                .trim(from: 0, to: 1 - progress())
                .stroke(
                    Color.blue,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress())
            
            if countInMinutes {
                Text(counterToMinutes())
                                    .font(.largeTitle)
                                    .bold()
            } else {
                Text("\(countTo - counter)")
                                    .font(.largeTitle)
                                    .bold()
            }
        }.onReceive(timer) { time in
            if (counter < countTo) {
                counter += 1
            }
        }
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0": "")\(seconds)"
    }
}


struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(countTo: 20, countInMinutes: false)
    }
}
