//
//  BadgeView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct BadgeView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @State var badge: Badge
    
    var owned: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RarityView(viewModel: viewModel, badge: badge)
            
            VStack(alignment: .leading) {
                BadgeImage(viewModel: viewModel, badge: badge)
                
                Text("\(badge.title)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)
                
                Text("\(badge.desc)")
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .foregroundColor(.black)
            }.padding(.leading, 20)
                .padding(.top, 10)
        }.opacity(owned ? 1 : 0.3)
            .padding(5)
    }
}

struct RarityView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var badge: Badge
    
    var body: some View {
        Image(uiImage: viewModel.images[badge.id] ?? viewModel.notFoundImage!)
            .resizable()
            .frame(width: 300, height: 200, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .clipped()
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.label), lineWidth: 5))
            .onAppear {
                viewModel.loadImage(url: badge.rarityUrl, id: badge.id)
            }
    }
}

struct BadgeImage: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var badge: Badge
    
    var body: some View {
        Image(uiImage: viewModel.images[badge.id+1] ?? viewModel.notFoundImage!)
            .resizable()
            .frame(width: 75, height: 75, alignment: .center)
            .clipShape(Circle())
            .clipped()
            .onAppear {
                viewModel.loadImage(url: badge.imageUrl, id: badge.id+1)
            }
    }
}

/*
struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
    }
}
*/
