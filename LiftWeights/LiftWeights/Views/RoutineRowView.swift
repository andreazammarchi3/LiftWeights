//
//  RoutineRowView.swift
//  LiftWeights
//
//  Created by Andrea on 06/06/22.
//

import SwiftUI

struct RoutineRowView: View {
    
    @ObservedObject var viewModel = DataLoader()
    
    var routine: Routine
    
    @State var circleShow = true
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .background(LinearGradientView(radius: 10))
                        .foregroundColor(.clear)
                        .frame(width: 75, height: 75, alignment: .center)
                    
                    Image(uiImage: viewModel.images[routine.id] ?? viewModel.notFoundImage!)
                        .resizable()
                        .frame(width: 75, height: 75, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.label), lineWidth: 2))
                        .onAppear {
                            if routine.id <= 40 {
                                viewModel.loadImage(url: routine.imageUrl, id: routine.id)
                            } else {
                                viewModel.images[routine.id] = UIImage(data: routine.imagePic)!
                                circleShow = false
                            }
                        }
                    if circleShow {
                        CircleProgressView(isLoading: $viewModel.isLoading)
                    }
                }.padding(20)
                
                Text(routine.name)
                    .font(.title.bold())
                    .bold()
                
                Spacer()
            }
            VStack(alignment: .leading) {
                ForEach(routine.exercises) { currentEx in
                    VStack {
                        HStack {
                            Text("\(currentEx.name)")
                                .font(.title2.bold())
                            Spacer()
                        }.padding(.leading, 10)
                            .padding(.top, 10)
                        
                        VStack {
                            ForEach(currentEx.miniSets) { currentSet in
                                HStack {
                                    Text("- \(currentSet.reps) x \(formatted(input: currentSet.weight))kg")
                                        .font(.title3)
                                    Spacer()
                                }
                            }
                        }.padding(.leading, 10)
                            .padding(.bottom, 10)
                    }.background(.black.opacity(0.5))
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }.padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 20)
        }.background(Color(UIColor.label).opacity(0.2))
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.label), lineWidth: 2))
        .frame(width: 300, alignment: .leading)
    }
    
    private func formatted(input: Float) -> String {
        let res = String(format: "%.2f", input)
        return res
    }
}


struct RoutineRowView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineRowView(routine: DataLoader().routines.first!)
            .preferredColorScheme(.dark)
    }
}
