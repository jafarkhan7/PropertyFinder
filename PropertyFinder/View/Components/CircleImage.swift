//
//  CircleImage.swift
//  PropertyFinder
//
//  Created by Jafar on 24/10/2024.
//

import SwiftUI

struct CircleImage: View {
    @State var isEnabled: Bool
    var size: CGSize = CGSize(width: 35, height: 35)
    var imageName: String = ""
    var imageNameDisable: String = ""
    var fillBackgroundColor = Color.lightGray
    var selectedImageColor = Color.red
    var unselectedImageColor = Color.black
    var onToggle: ()->Void
    
    private var image: String {
        if isEnabled {
           return imageName
        }
        else {
            return imageNameDisable.isEmpty ? imageName : imageNameDisable
        }
    }
    
    var body: some View {
        
        Button(action: {
            isEnabled.toggle()
            onToggle()
        }) {
            
            ZStack {
                Circle()
                    .fill(fillBackgroundColor)
                    .frame(width: size.width, height: size.height, alignment: .center)
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width / 2, height: size.height / 2, alignment: .center)
                    .foregroundColor(isEnabled ? selectedImageColor : unselectedImageColor)
            }
            .customFont(size: size.width / 2)
        }
        .withPressableStyle()
    }
}

#Preview {
    CircleImage(isEnabled: true, onToggle: {
        
    })
}
