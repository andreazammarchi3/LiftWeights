//
//  ExRowView.swift
//  LiftWeights
//
//  Created by Andrea on 08/06/22.
//

import SwiftUI

struct ExRowView: View {
    
    @ObservedObject var viewModel = DataLoader()
    
    var exercise: Exercise
    
    @State var circleShow = true
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(Color(red: 78/255, green: 116/255, blue: 177/255))
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
                if circleShow {
                    CircleProgressView(isLoading: $viewModel.isLoading)
                }
            }
            
            Text(exercise.name)
                .font(.title2)
                .bold()
        }
    }
}

/*
struct ExRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExRowView()
    }
}
*/
