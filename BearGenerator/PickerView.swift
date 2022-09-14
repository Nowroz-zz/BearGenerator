//
//  PickerView.swift
//  BearGenerator
//
//  Created by Nowroz Islam on 15/9/22.
//

import SwiftUI

struct PickerView: View {
    @ObservedObject var viewModel: ContentView.ViewModel
    
    var body: some View {
        HStack {
            Text("Select image type")
            
            Spacer()
            
            Picker("Select image type", selection: $viewModel.selectedType) {
                ForEach(viewModel.types, id:\.self) { Text($0) }
            }
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    private static var viewModel = ContentView.ViewModel()
    
    static var previews: some View {
        PickerView(viewModel: viewModel)
    }
}
