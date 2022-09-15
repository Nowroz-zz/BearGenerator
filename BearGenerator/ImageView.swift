//
//  BearImageView.swift
//  BearGenerator
//
//  Created by Nowroz Islam on 14/9/22.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var viewModel: ContentView.ViewModel
    
    var body: some View {
        if let uiImage = viewModel.uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scaleEffect(viewModel.scaleAmount)
                .offset(viewModel.offsetAmount)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation() {
                                viewModel.changeOffset(to: value)
                            }
                        }
                        .onEnded { _ in
                            viewModel.updateOffsetAccumulation()
                        }
                )
        } else {
            Text("Press the Generate button to download image.")
                .padding(.horizontal)
                .font(.caption)
        }
    }
}

struct BearImageView_Previews: PreviewProvider {
    private static var viewModel = ContentView.ViewModel()
    
    static var previews: some View {
        ImageView(viewModel: viewModel)
    }
}
