//
//  DoingExView.swift
//  LiftWeights
//
//  Created by Andrea on 09/06/22.
//

import SwiftUI

struct DoingExView: View {
    
    @ObservedObject var viewModel = DataLoader()
    
    var routine: Routine
    
    @State private var exercise: Exercise
    
    @State private var miniSet: MiniSet
    
    @State private var counter: Int = 0
    
    @State private var circleShow: Bool = true
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    init(routine: Routine) {
        self.routine = routine
        self.exercise = routine.exercises.first!
        self.miniSet = routine.exercises.first!.miniSets.first!
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Spacer()
                
                VStack(alignment: .center) {
                    Text("\(exercise.name)")
                        .frame(alignment: .leading)
                        .font(.title.bold())
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.blue)
                            .frame(width: 75, height: 75, alignment: .center)
                        
                        Image(uiImage: viewModel.image)
                            .resizable()
                            .frame(width: 75, height: 75, alignment: .center)
                            .clipShape(Circle())
                            .clipped()
                            .onAppear {
                                if exercise.id <= 40 {
                                    viewModel.loadImage(url: exercise.imageUrl)
                                } else {
                                    viewModel.image = UIImage(data: exercise.imagePic)!
                                    circleShow = false
                                }
                        }
                    }
                }
                
                Spacer()
                
                ZStack(alignment: .center) {
                    Circle()
                        .stroke(
                            Color.blue,
                            lineWidth: 20
                        )
                        .frame(width: 110, height: 110, alignment: .center)
                    
                    Text("\(counterToMinutes())")
                        .font(.title2)
                        .bold()
                }
                
                Spacer()
                
            }//.padding(.top, 120)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 30)
            
            List {
                ForEach(exercise.miniSets) { miniSet in
                    if self.miniSet.id == miniSet.id {
                        VStack(alignment: .center) {
                            HStack(alignment: .center) {
                                Text("\(miniSet.reps) x \(miniSet.weight)kg")
                            }
                        }
                    }
                }
            }
            
            VStack(alignment: .center) {
                Button {
                    
                } label: {
                    Text("Done").font(.title2.bold())
                }
            }
        }
            .navigationTitle(routine.name)
            //.navigationBarHidden(true)
            //.edgesIgnoringSafeArea(.top)
            //.overlay(NavigationBar(title: routine.name))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .onReceive(timer) { time in
                counter += 1
            }
    }
    
    func counterToMinutes() -> String {
        let currentTime = counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0": "")\(seconds)"
    }
}

/*
struct DoingExView_Previews: PreviewProvider {
    static var previews: some View {
        DoingExView(viewModel: DataLoader(), routine: Routine(id: 1, name: "Pippo", imagePic: UIImage(systemName: "plus")!, exercises: [], image: ""))
    }
}
*/
