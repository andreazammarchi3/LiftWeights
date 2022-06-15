//
//  DoingExView.swift
//  LiftWeights
//
//  Created by Andrea on 09/06/22.
//

import SwiftUI

struct DoingExView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @State var routine: Routine
    
    @State var exercise: Exercise
    
    @State var miniSet: MiniSet
    
    @State private var counter: Int = 0
    
    @State private var circleShow: Bool = true
    
    @State var showRest = false
    
    @State var routineCompleted = false
    
    @State var  timer: Timer.TimerPublisher = Timer
        .publish(every: 1, on: .main, in: .common)
    
    @State var workout: Workout
    
    @State var exTime: Int = 0
    
    init(viewModel: DataLoader, routine: Routine, exercise: Exercise, miniSet: MiniSet) {
        self.viewModel = viewModel
        self.routine = routine
        self.exercise = exercise
        self.miniSet = miniSet
        self.workout = Workout(id: 0, date: "", totalTime: 0, workTime: 0, restTime: 0)
        startTimer()
        UINavigationBar.appearance().tintColor = .white.withAlphaComponent(0)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .background(LinearGradientView(viewModel: viewModel, radius: 10))
                        .foregroundColor(.clear)
                        .frame(width: 75, height: 75, alignment: .center)
                    
                    Image(uiImage: viewModel.images[exercise.id] ?? viewModel.notFoundImage!)
                        .resizable()
                        .frame(width: 75, height: 75, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.label), lineWidth: 2))
                }.onAppear {
                    if exercise.id <= 40 {
                        viewModel.loadImage(url: exercise.imageUrl, id: exercise.id)
                    } else {
                        viewModel.images[exercise.id] = UIImage(data: exercise.imagePic)!
                        circleShow = false
                    }
                }
                
                Text("\(exercise.name)")
                    .frame(alignment: .leading)
                    .font(.largeTitle.bold())
                
                NavigationLink("", isActive: $routineCompleted) {
                    FinishView(viewModel: viewModel, routineName: routine.name)
                }.isDetailLink(false)
                
                Spacer()
            }

            List {
                ForEach(routine.exercises.first(where: { exercise in
                    self.exercise.id == exercise.id
                })!.miniSets) { currentSet in
                    HStack(alignment: .center) {
                        Text("\(currentSet.reps) x \(Utils.formatted(input: currentSet.weight))kg").font(.title3)
                        
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
                    if checkNext() {
                        stopTimer()
                        workout.workTime += counter
                        showRest = true
                    } else {
                        stopTimer()
                        workout.totalTime = workout.workTime + workout.restTime
                        viewModel.addWorkout(workout: workout)
                        routineCompleted = true
                        UINavigationBar.appearance().tintColor = .white.withAlphaComponent(1)
                    }
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
                exTime += 1
            }
            .fullScreenCover(isPresented: $showRest, onDismiss: {
                showRest = false
                counter = 0
                startTimer()
            }, content: {
                //GetReadyView(routine: routine, viewModel: viewModel)
                RestView(viewModel: viewModel, countTo: viewModel.restTime)
            })
    }

                
    private func counterToMinutes() -> String {
        let currentTime = counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0": "")\(seconds)"
    }
    
    private func isCurrentSet(id: Int) -> Bool {
        if id == miniSet.id {
            return true
        } else {
            return false
        }
    }
    
    func checkNext() -> Bool {
        if exercise.miniSets.count > 1 {
            exercise.miniSets = exercise.miniSets.filter() {$0.id != miniSet.id}
            self.miniSet = exercise.miniSets.first!
            viewModel.restTime = viewModel.restSetTime
            workout.restTime += viewModel.restSetTime
            return true
        } else {
            if routine.exercises.count > 1 {
                checkRecords()
                exTime = 0
                routine.exercises = routine.exercises.filter() {$0.id != exercise.id}
                self.exercise = routine.exercises.first!
                self.miniSet = exercise.miniSets.first!
                viewModel.restTime = viewModel.restExTime
                workout.restTime += viewModel.restExTime
                if exercise.id <= 40 {
                    viewModel.loadImage(url: exercise.imageUrl, id: exercise.id)
                } else {
                    viewModel.images[exercise.id] = UIImage(data: exercise.imagePic)!
                    circleShow = false
                }
                return true
            } else {
                checkRecords()
                return false
            }
        }
        
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
        _ = timer.connect()
    }
    
    private func stopTimer() {
        timer.connect().cancel()
    }
    
    private func checkRecords() {
        if exTime < exercise.timeRecord {
            updateExTimeRecord(timeRecord: exTime, exId: exercise.id)
        }
        if miniSet.weight > exercise.weightRecord {
            updateExWeightRecord(weightRecord: miniSet.weight, exId: exercise.id)
        }
    }
    
    private func updateExTimeRecord(timeRecord: Int, exId: Int) {
        if let routineOffset = viewModel.model.list.firstIndex(where: {$0.id == routine.id}) {
            if let exOffset = viewModel.model.list[routineOffset].exercises.firstIndex(where: {$0.id == exId}) {
                viewModel.model.list[routineOffset].exercises[exOffset].updateTimeRecord(timeRecord: timeRecord)
            }
        }
    }
    
    private func updateExWeightRecord(weightRecord: Float, exId: Int) {
        if let routineOffset = viewModel.model.list.firstIndex(where: {$0.id == routine.id}) {
            if let exOffset = viewModel.model.list[routineOffset].exercises.firstIndex(where: {$0.id == exId}) {
                viewModel.model.list[routineOffset].exercises[exOffset].updateWeightRecord(weightRecord: weightRecord)
            }
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
