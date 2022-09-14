//
//  SliderView.swift
//  BearGenerator
//
//  Created by Nowroz Islam on 15/9/22.
//

import SwiftUI

struct SliderView: View {
    @ObservedObject var viewModel: ContentView.ViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            Slider(value: $viewModel.scaleAmount, in: 0.3...3.0)
            
            Button {
                viewModel.resetScaleAmount()
            } label: {
                Image(systemName: "arrow.counterclockwise")
            }
            .disabled(viewModel.isDisabled())
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    private static var viewModel = ContentView.ViewModel()
    
    static var previews: some View {
        SliderView(viewModel: viewModel)
    }
}
