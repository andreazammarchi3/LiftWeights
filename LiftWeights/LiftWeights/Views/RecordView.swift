//
//  RecordView.swift
//  LiftWeights
//
//  Created by Andrea on 15/06/22.
//

import SwiftUI

struct RecordView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var exercise: Exercise
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 250, height: 120, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.label), lineWidth: 5))
                .background(LinearGradientView(viewModel: viewModel, radius: 20))
                .foregroundColor(.clear)
                .padding(5)
            
            RecordDetailsView(exercise: exercise)
        }
    }
}

struct RecordDetailsView: View {
    
    var exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(exercise.name)")
                .font(.title2.bold())
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 20)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white.opacity(0.3))
                    .frame(height: 50, alignment: .center)
                
                VStack {
                    HStack(alignment: .center) {
                        Text("Time record:")
                            .font(.title3.bold())
                        
                        Spacer()
                        
                        Text("\(exercise.timeRecord/60)min \(exercise.timeRecord%60)s")
                    }
                    
                    HStack(alignment: .center) {
                        Text("Weight record:")
                            .font(.title3.bold())
                        
                        Spacer()
                        
                        Text("\(Utils.formatted(input: exercise.weightRecord))kg")
                    }
                    
                }.padding(.leading, 10)
                    .padding(.trailing, 10)
            }.padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 10)
        }
    }
}


struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(viewModel: DataLoader(), exercise: Exercise(id: 100, name: "Name", imagePic: UIImage(), miniSets: [MiniSet](), image: ""))
    }
}

