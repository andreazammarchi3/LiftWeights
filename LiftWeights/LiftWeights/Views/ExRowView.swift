//
//  ExRowView.swift
//  LiftWeights
//
//  Created by Andrea on 03/06/22.
//

import SwiftUI

struct ExRowView: View {
    @ObservedObject var viewModel: DataLoader
    
    var exercise: Exercise
    
    var body: some View {
        HStack {
            Image(uiImage: viewModel.image)
                .resizable()
                .frame(width: 75, height: 75, alignment: .center)
                .clipShape(Circle())
                .shadow(radius: 5)
                .onAppear {
                    if exercise.id <= 40 {
                        viewModel.loadImage(url: exercise.imageUrl)
                    } else {
                        viewModel.image = UIImage(data: exercise.imagePic)!
                    }
                }
            Text(exercise.name)
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
