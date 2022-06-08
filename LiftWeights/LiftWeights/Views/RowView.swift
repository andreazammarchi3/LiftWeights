//
//  RowView.swift
//  LiftWeights
//
//  Created by Andrea on 06/06/22.
//

import SwiftUI

struct RowView: View {
    @ObservedObject var viewModel = DataLoader()
    
    var exercise: Exercise?
    var routine: Routine?
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
                        if exercise != nil {
                            if exercise!.id <= 40 {
                                viewModel.loadImage(url: exercise!.imageUrl)
                            } else {
                                viewModel.image = UIImage(data: exercise!.imagePic)!
                                circleShow = false
                            }
                        } else {
                            if routine!.id <= 40 {
                                viewModel.loadImage(url: routine!.imageUrl)
                            } else {
                                viewModel.image = UIImage(data: routine!.imagePic)!
                                circleShow = false
                            }
                        }
                    }
                if circleShow {
                    CircleProgressView(isLoading: $viewModel.isLoading)
                }
            }
            
            if exercise != nil {
                Text(exercise!.name)
                    .font(.title2)
                    .bold()
            } else {
                Text(routine!.name)
                    .font(.title2)
                    .bold()
            }
        }
    }
}

/*
struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView()
    }
}
*/
