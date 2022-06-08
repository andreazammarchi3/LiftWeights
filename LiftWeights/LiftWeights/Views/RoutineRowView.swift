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
                        if routine.id <= 40 {
                            viewModel.loadImage(url: routine.imageUrl)
                        } else {
                            viewModel.image = UIImage(data: routine.imagePic)!
                            circleShow = false
                        }
                    }
                if circleShow {
                    CircleProgressView(isLoading: $viewModel.isLoading)
                }
            }
            
            Text(routine.name)
                .font(.title2)
                .bold()
        }
    }
}

/*
struct RoutineRowView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineRowView()
    }
}
*/
