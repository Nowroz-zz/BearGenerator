//
//  ContentView-ViewModel.swift
//  BearGenerator
//
//  Created by Nowroz Islam on 12/9/22.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published private(set) var url = URL(string: "https://placebear.com/200/400")
        
        @Published private(set) var offsetAmount = CGSize.zero
        var accumulatedOffsetAmount = CGSize.zero
        
        @Published var scaleAmount = 1.0
        
        var width = 200
        var height = 400
        
        func generate() {
            url = URL(string: "https://placebear.com/\(width)/\(height)")
        }
        
        func changeOffset(to value: DragGesture.Value) {
            offsetAmount = CGSize(width: value.translation.width + accumulatedOffsetAmount.width, height: value.translation.height + accumulatedOffsetAmount.height)
        }
        
        func updateOffsetAccumulation() {
            accumulatedOffsetAmount = offsetAmount
        }
        
        func resetOffset() {
            offsetAmount = .zero
            accumulatedOffsetAmount = .zero
        }
        
        func resetScaleAmount() {
            scaleAmount = 1.0
        }
        
        func isDisabled() -> Bool {
            scaleAmount == 1.0 ? true : false
        }
    }
}
