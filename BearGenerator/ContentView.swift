//
//  ContentView.swift
//  BearGenerator
//
//  Created by Nowroz Islam on 12/9/22.
//

import SwiftUI

struct ContentView: View {
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
                        AsyncImage(url: URL(string: "https://placebear.com/200/400")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
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
                }
                .padding(.vertical)
                
                HStack {
                    Slider(value: .constant(0.5), in: 0.3...2.0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
                .padding(.vertical)
                
                VStack {
                    HStack {
                        Text("Width")
                        
                        TextField("Amount", value: .constant(300), format: .number)
                            .padding(.horizontal)
                            .background(.brown)
                            .clipShape(Capsule())
                    }
                    
                    HStack {
                        Text("Height")
                        
                        TextField("Amount", value: .constant(400), format: .number)
                            .padding(.horizontal)
                            .background(.brown)
                            .clipShape(Capsule())
                    }
                }
                .padding(.vertical)
                
                Button("Generate") { }
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
