//
//  UserView.swift
//  LiftWeights
//
//  Created by Andrea on 10/06/22.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @State var user: User
    
    init() {
        self.viewModel = DataLoader()
        self.user = DataLoader().users.list.first!
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("User Details")
                    .font(.title.bold())
                
                HStack(alignment: .center) {
                    
                    ZStack(alignment: .center) {
                        Circle()
                            .foregroundColor(Color.blue)
                            .frame(width: 100, height: 100, alignment: .center)
                            .shadow(radius: 10)
                        
                        Image(uiImage: viewModel.image)
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipShape(Circle())
                            .clipped()
                            .overlay(Circle().stroke(Color(UIColor.label), lineWidth: 2))
                            .onAppear {
                                if user.id <= 41 {
                                    viewModel.loadImage(url: user.imageUrl)
                                } else {
                                    viewModel.image = UIImage(data: user.imagePic)!
                                }
                        }
                    }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(UIColor.systemFill))
                            .frame(height: 110, alignment: .center)
                        
                        VStack {
                            HStack(alignment: .center) {
                                Text("Nickname:")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                Text("\(user.nickname)")
                            }
                            
                            HStack(alignment: .center) {
                                Text("Height:")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                Text("\(formatted(input: user.height))cm")
                            }
                            
                            HStack(alignment: .center) {
                                Text("Weight:")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                Text("\(formatted(input: user.weight))kg")
                            }
                            
                            HStack(alignment: .center) {
                                Text("Age:")
                                    .font(.title3.bold())
                                
                                Spacer()
                                
                                Text("\(user.age)y")
                            }
                        }.padding(.leading, 20)
                            .padding(.trailing, 20)
                    }
                }
                                
                Text("Badges owned")
                    .font(.title.bold())
                    .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(user.badgesOwned, id: \.self) { badgeOwned in
                            if let fooOffset = viewModel.badges.list.firstIndex(where: {$0.id == badgeOwned}) {
                                BadgeView(viewModel: viewModel, badge: viewModel.badges.list[fooOffset])
                            }
                            
                        }
                    }
                }
                
                Spacer()
            }.navigationTitle("Hi \(user.nickname)!")
                .padding(20)
        }
    }
    
    private func formatted(input: Float) -> String {
        let res = String(format: "%.1f", input)
        return res
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
