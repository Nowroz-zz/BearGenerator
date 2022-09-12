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
                HStack {
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                }
                
                GeometryReader { geoProxy in
                    ZStack {
                        AsyncImage(url: viewModel.url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(viewModel.scaleAmount)
                                    .offset(viewModel.offsetAmount)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                viewModel.changeOffset(to: value)
                                            }
                                            .onEnded { _ in
                                                viewModel.updateOffsetAccumulation()
                                            }
                                    )
                            } else if phase.error != nil {
                                Text("There was an error loading the image.")
                            } else {
                                ProgressView()
                            }
                        }
                        
                        VStack {
                            HStack {
                                Spacer()
                                
                                Button {
                                    viewModel.resetOffset()
                                } label: {
                                    Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                                }
                                .tint(.white)
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .frame(width: geoProxy.size.width, height: geoProxy.size.height)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.brown, lineWidth: 3)
                    )
                    .clipped()
                }
                .padding(.vertical)
                
                HStack {
                    Slider(value: $viewModel.scaleAmount, in: 0.3...3.0)
                    
                    Button {
                        viewModel.resetScaleAmount()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .disabled(viewModel.isDisabled())
                }
                .padding(.vertical)
                
                VStack {
                    HStack {
                        Text("Width")
                        
                        TextField("Amount", value: $viewModel.width, format: .number)
                            .padding(.horizontal)
                            .background(.brown)
                            .clipShape(Capsule())
                    }
                    
                    HStack {
                        Text("Height")
                        
                        TextField("Amount", value: $viewModel.height, format: .number)
                            .padding(.horizontal)
                            .background(.brown)
                            .clipShape(Capsule())
                    }
                }
                .padding(.vertical)
                
                Button("Generate") {
                    viewModel.generate()
                }
                .buttonStyle(.borderedProminent)
                .tint(.secondary)
                .padding(.vertical)
            }
            .navigationTitle("BearGenerator")
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { }
                }
            }
        }
        .preferredColorScheme(.dark)
        .tint(.brown)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
