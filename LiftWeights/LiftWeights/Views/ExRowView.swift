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
            Image(uiImage: UIImage(data: exercise.image)!)
                .resizable()
                .frame(width: 75, height: 75, alignment: .center)
                .clipShape(Circle())
                .shadow(radius: 5)
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
