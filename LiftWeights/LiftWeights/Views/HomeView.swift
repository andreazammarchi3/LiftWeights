//
//  HomeView.swift
//  LiftWeights
//
//  Created by Andrea on 27/05/22.
//

import SwiftUI

let customNavAppearance = UINavigationBarAppearance()

struct HomeView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @State var showAddRoutineView = false
    
    @StateObject var delegate = Utils.NotificationDelegate()
    
    init(viewModel: DataLoader) {
        self.viewModel = viewModel
        showAddRoutineView = showAddRoutineView
        
        customNavAppearance.configureWithOpaqueBackground()
        customNavAppearance.backgroundImage = UIImage(named: "background")
        customNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        customNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        customNavAppearance.setBackIndicatorImage(.none, transitionMaskImage: .none)
               
        UINavigationBar.appearance().standardAppearance = customNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = customNavAppearance
        UINavigationBar.appearance().tintColor = .white
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                HStack(alignment: .top) {
                    ForEach(viewModel.routines) { routine in
                        NavigationLink(destination: RoutineView(viewModel: viewModel, routine: routine)) {
                            ScrollView(.vertical){
                                RoutineRowView(viewModel: viewModel, routine: routine)
                                    .padding(5)
                            }
                        }.isDetailLink(false)
                            .foregroundColor(.white)
                    }.onDelete { indexSet in
                        var itemsToRemove = [Routine]()
                        for indexToRemove in indexSet {
                            itemsToRemove.append(contentsOf: viewModel.routines.filter { item in
                                item.id == viewModel.routines[indexToRemove].id
                            })
                            viewModel.deleteRoutines(routines: itemsToRemove)
                        }
                    }
                }
            }.navigationTitle("Routines")
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            showAddRoutineView = true
                        }, label: {
                            Label("New Routine", systemImage: "plus")
                        }).foregroundColor(.white)
                    }
                }.sheet(isPresented: $showAddRoutineView) {
                    AddRoutineView(viewModel: viewModel)
                }.padding(10)
        }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (_, _) in
                }
                
                UNUserNotificationCenter.current().delegate = delegate
            }
        
    }
}

/*
struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    
    public mutating func dismiss() {
        self.toggle()
    }
}
*/

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: DataLoader())
            .preferredColorScheme(.dark)
            
    }
}
