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
    
    @State var showRest = false
    
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
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .background(LinearGradientView(radius: 10))
                        .foregroundColor(.clear)
                        .frame(width: 75, height: 75, alignment: .center)
                    
                    Image(uiImage: viewModel.image)
                        .resizable()
                        .frame(width: 75, height: 75, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.label), lineWidth: 2))
                }.onAppear {
                    if exercise.id <= 40 {
                        viewModel.loadImage(url: exercise.imageUrl)
                    } else {
                        viewModel.image = UIImage(data: exercise.imagePic)!
                        circleShow = false
                    }
                }
                
                Text("\(exercise.name)")
                    .frame(alignment: .leading)
                    .font(.largeTitle.bold())
                
                Spacer()
            }

            List {
                ForEach(exercise.miniSets) { currentSet in
                    HStack(alignment: .center) {
                        Text("\(currentSet.reps) x \(formatted(input: currentSet.weight))kg").font(.title3)
                        
                        Spacer()
                        
                        if currentSet.id < miniSet.id {
                            Label("", systemImage: "checkmark")
                                .foregroundColor(Color(UIColor.systemGreen))
                        }
                    }.opacity(isCurrentSet(id: currentSet.id) ? 1 : 0.5)
                }
            }
            
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(UIColor.systemGreen))
                    .frame(width: 150, height: 50, alignment: .center)
                    .onTapGesture {
                        showRest = true
                    }
                
                Button(action: {
                    showRest = true
                }, label: {
                    Text("Set completed")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(20)
                })
            }.padding(.bottom, 20)
            
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
        }.navigationTitle(routine.name)
            //.navigationBarHidden(true)
            //.edgesIgnoringSafeArea(.top)
            //.overlay(NavigationBar(title: routine.name))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .onReceive(timer) { time in
                counter += 1
            }
            .fullScreenCover(isPresented: $showRest) {
                
            } content: {
                RestView(viewModel: viewModel)
            }
    }

                
    private func counterToMinutes() -> String {
        let currentTime = counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0": "")\(seconds)"
    }
    
    private func formatted(input: Float) -> String {
        let res = String(format: "%.1f", input)
        return res
    }
    
    private func isCurrentSet(id: Int) -> Bool {
        if id == miniSet.id {
            return true
        } else {
            return false
        }
    }
}

/*
struct DoingExView_Previews: PreviewProvider {
    static var previews: some View {
        DoingExView(viewModel: DataLoader(), routine: Routine(id: 1, name: "Pippo", imagePic: UIImage(systemName: "plus")!, exercises: [], image: ""))
    }
}
*/
