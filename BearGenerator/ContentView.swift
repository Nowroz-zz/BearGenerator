//
//  ContentView.swift
//  BearGenerator
//
//  Created by Nowroz Islam on 12/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var offsetAmount = CGSize.zero
    @State private var accumulatedAmount = CGSize.zero
    
    @State private var scaleAmount = 1.0
    
    @State private var width = 200
    @State private var height = 400
    
    @State private var url = URL(string: "https://placebear.com/200/400")
    
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
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(scaleAmount)
                                    .offset(offsetAmount)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                offsetAmount = CGSize(width: value.translation.width + accumulatedAmount.width, height: value.translation.height + accumulatedAmount.height)
                                            }
                                            .onEnded { value in
                                                accumulatedAmount = offsetAmount
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
                                    offsetAmount = .zero
                                    accumulatedAmount = .zero
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
                    Slider(value: $scaleAmount, in: 0.3...3.0)
                    
                    Button {
                        scaleAmount = 1.0
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .disabled(scaleAmount == 1.0 ? true : false)
                }
                .padding(.vertical)
                
                VStack {
                    HStack {
                        Text("Width")
                        
                        TextField("Amount", value: $width, format: .number)
                            .padding(.horizontal)
                            .background(.brown)
                            .clipShape(Capsule())
                    }
                    
                    HStack {
                        Text("Height")
                        
                        TextField("Amount", value: $height, format: .number)
                            .padding(.horizontal)
                            .background(.brown)
                            .clipShape(Capsule())
                    }
                }
                .padding(.vertical)
                
                Button("Generate") {
                    url = URL(string: "https://placebear.com/\(width)/\(height)")
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
