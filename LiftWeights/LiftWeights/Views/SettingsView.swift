//
//  SettingsView.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @Binding var showSettings: Bool
    
    @State private var restSetTime: Int
    
    @State private var restExTime: Int
    
    @State private var getReadyTime: Int
    
    init(viewModel: DataLoader, showSettings: Binding<Bool>) {
        self.viewModel = viewModel
        self.restSetTime = viewModel.restSetTime
        self.restExTime = viewModel.restExTime
        self.getReadyTime = viewModel.getReadyTime
        self._showSettings = showSettings
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Timings")) {
                    Picker("Rest between sets", selection: $restSetTime) {
                        ForEach(1..<180) {
                            Text("\($0) sec")
                        }
                    }
                    
                    Picker("Rest between exercises", selection: $restExTime) {
                        ForEach(1..<180) {
                            Text("\($0) sec")
                        }
                    }
                    
                    Picker("Get ready time", selection: $getReadyTime) {
                        ForEach(1..<180) {
                            Text("\($0) sec")
                        }
                    }
                }
                .font(.headline)
            }.navigationBarTitle(Text("Settings"), displayMode: .inline)
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            viewModel.restSetTime = self.restSetTime
                            viewModel.restExTime = self.restExTime
                            viewModel.getReadyTime = self.getReadyTime
                            self.showSettings = false
                        }, label: {
                            Text("Done")
                                .bold()
                                .foregroundColor(.white)
                        })
                    }
                }
        }
    }
}

/*
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
*/
