//
//  OffsetResetterView.swift
//  BearGenerator
//
//  Created by Nowroz Islam on 15/9/22.
//

import SwiftUI

struct OffsetResetterView: View {
    @ObservedObject var viewModel: ContentView.ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    viewModel.resetOffset()
                } label: {
                    Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                }
                .tint(.gray)
            }
            
            Spacer()
        }
    }
}

struct OffsetResetterView_Previews: PreviewProvider {
    private static var viewModel = ContentView.ViewModel()
    
    static var previews: some View {
        OffsetResetterView(viewModel: viewModel)
    }
}
