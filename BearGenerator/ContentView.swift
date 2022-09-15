//
//  ContentView.swift
//  BearGenerator
//
//  Created by Nowroz Islam on 12/9/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                PickerView(viewModel: viewModel)
                    .padding(.vertical)
                
                ZStack {
                    ImageView(viewModel: viewModel)
                        .clipped()
                    
                    OffsetResetterView(viewModel: viewModel)
                        .padding()
                }
                .padding(.horizontal, 2)
                .padding(.vertical, 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.brown, lineWidth: 4)
                )
                
                SliderView(viewModel: viewModel)
                    .padding(.vertical)
                
                MeasurementView(viewModel: viewModel)
                    .padding(.vertical)
                
                Button("Generate") {
                    Task {
                        await viewModel.generate()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.secondary)
                .padding(.vertical)
            }
            .navigationTitle("PlaceAnimals")
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { viewModel.askConfirmation() }
                }
            }
            .confirmationDialog("Save image to photos library?", isPresented: $viewModel.showingConfirmationDialog) {
                Button("Save") { viewModel.save() }
            }
        }
        .tint(.brown)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
