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
        
        let types = ["Bear", "Dog", "Cat"]
        
        @Published var selectedType = "Dog"
        
        @Published private(set) var uiImage: UIImage?
        
        @Published var showingConfirmationDialog = false
        
        private var url: URL!
        
        @Published private(set) var offsetAmount = CGSize.zero
        var accumulatedOffsetAmount = CGSize.zero
        
        @Published var scaleAmount = 1.0
        
        var width = 200
        var height = 400
        
        func generate() async {
            switch selectedType {
            case "Bear":
                url = URL(string: "https://placebear.com/\(width)/\(height)")
            case "Dog":
                url = URL(string: "https://place.dog/\(width)/\(height)")
            default:
                url = URL(string: "https://placekitten.com/\(width)/\(height)")
            }
            
            if let (data, _) = try? await URLSession.shared.data(from: url) {
                uiImage = UIImage(data: data)
            }
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
        
        func askConfirmation() {
            guard let _ = uiImage else { return }
            
            showingConfirmationDialog = true
        }
        
        func save() {
            guard let uiImage = uiImage else { return }
            
            let imageSaver = ImageSaver()
            
            imageSaver.successHandler = {
                print("The image is saved successfully.")
            }
            
            imageSaver.errorHandler = {
                print("Could not save the image: \($0.localizedDescription)")
            }
            
            imageSaver.writeToPhotoAlbum(image: uiImage)
        }
    }
}
