//
//  MeasurementView.swift
//  BearGenerator
//
//  Created by Nowroz Islam on 15/9/22.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .background(.brown.opacity(0.85))
            .clipShape(Capsule())
        
    }
}

extension View {
    func modifyTextField() -> some View {
        self
            .modifier(TextFieldModifier())
    }
}

struct MeasurementView: View {
    @ObservedObject var viewModel: ContentView.ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Width")
                
                TextField("Amount", value: $viewModel.width, format: .number)
                    .modifyTextField()
            }
            
            HStack {
                Text("Height")
                
                TextField("Amount", value: $viewModel.height, format: .number)
                    .modifyTextField()
            }
        }
    }
}

struct MeasurementView_Previews: PreviewProvider {
    private static var viewModel = ContentView.ViewModel()
    
    static var previews: some View {
        MeasurementView(viewModel: viewModel)
    }
}
