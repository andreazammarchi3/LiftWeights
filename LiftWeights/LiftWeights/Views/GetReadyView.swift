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
    
    @State var counter: Int
    
    @State var finished = false
    
    let countTo: Int
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    init(routine: Routine, viewModel: DataLoader) {
        self.routine = routine
        self.viewModel = viewModel
        self.countTo = 10
        self.circularProgressView = CircularProgressView(countTo: countTo, countInMinutes: false)
        self.counter = 0
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: Text("Second view"), isActive: $finished) { EmptyView() }
            
            Text("Get Ready!")
                .font(.largeTitle)
                .bold()
            
            circularProgressView
                .frame(width: 200, height: 200)
                .padding()
        }.navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)
            .onReceive(timer) { time in
                if (counter < countTo) {
                    counter += 1
                    circularProgressView.updateCounter(counter: counter)
                } else {
                    finished = true
                }
            }
    }
}

/*
struct GetReadyView_Previews: PreviewProvider {
    static var previews: some View {
        GetReadyView()
    }
}
*/
