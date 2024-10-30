//
//  PropertyImageview.swift
//  PropertyFinder
//
//  Created by Jafar on 24/10/2024.
//

import SwiftUI

struct PropertyImageView: View {
    let propertyImages: [PropertyImage]
    var body: some View {
        ZStack(alignment: .bottomLeading, content: {
            TabView {
                ForEach(propertyImages) { image in
                    Image(image.name)
                        .resizable()
                        .scaledToFill()
                    
                }
            }.tabViewStyle(PageTabViewStyle())
            
            AgentImageCircleView(imageName: "Ad2")
            
        })
    }
}
#Preview {
    PropertyImageView(propertyImages: [PropertyImage]())
}
