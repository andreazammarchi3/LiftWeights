//
//  RoutineRowView.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import SwiftUI

struct RoutineRowView: View {
    @ObservedObject var viewModel = DataLoader()
    
    var routine: Routine
    
    var body: some View {
        HStack {
            Image(uiImage: viewModel.image)
                .resizable()
                .frame(width: 75, height: 75, alignment: .center)
                .clipShape(Circle())
                .shadow(radius: 5)
                .onAppear {
                    if routine.id <= 40 {
                        viewModel.loadImage(url: routine.imageUrl)
                    } else {
                        viewModel.image = UIImage(data: routine.imagePic)!
                    }
                }
            
            Text(routine.name)
        }
    }
}

/*
struct RoutineRowView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineRowView(viewModel: <#DataLoader#>, routine: <#Routine#>)
    }
}
*/
