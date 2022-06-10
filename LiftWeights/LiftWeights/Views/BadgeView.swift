//
//  BadgeView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct BadgeView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    var badgeId: Int
    
    @State private var badge = Badge(id: 0, title: "", desc: "", rarity: "", image: "")
    @State private var back = "https://raw.githubusercontent.com/andreazammarchi3/LiftWeights/main/Resources/bronze.png"
    
    var body: some View {
        ZStack {
            Image(uiImage: loadImage(url: badge.rarityUrl))
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.label), lineWidth: 2))
            
            /*
            Image(uiImage: loadImage(url: badge.imageUrl))
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.label), lineWidth: 2))
            */
        }.onAppear {
            if let fooOffset = viewModel.badges.list.firstIndex(where: {$0.id == badgeId}) {
                self.badge = DataLoader().badges.list[fooOffset]
            }
            back = badge.rarity
        }
    }
    
    private func loadImage(url: URL) -> UIImage {
        var image = UIImage()
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = data {
                    image = UIImage(data: imageData)!
                }
            }
        }
        return image
    }
}

/*
struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
    }
}
*/
