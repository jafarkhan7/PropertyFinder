//
//  PropertyTypeFeature.swift
//  PropertyFinder
//
//  Created by Jafar on 24/10/2024.
//

import SwiftUI

struct PropertyTypeFeature: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    CustomTextView(text: "Villa")
                        .customFont(size: 15, weight: .medium)
                    Spacer()
                    CustomTextView(text: "Listed 1 days ago")
                        .customFont(size: 15, weight: .medium)
                }
                Spacer(minLength: 20)
                CustomTextView(text: "2,740,000 AED", color: nil)
                    .customFont(size: 25, weight: .medium)
                Spacer(minLength: 20)
                CustomTextView(imageName: "mappin.and.ellipse", text: "Springs 11, The Springs, Dubai")
                    .customFont(size: 15, weight: .medium)
                Spacer(minLength: 20)
                HStack(alignment:.center) {
                    CustomTextView(imageName: "bed.double", text: "2")
                        .customFont(size: 15, weight: .semibold)
                    Spacer().frame(width: 20)
                    CustomTextView(imageName: "bathtub", text: "2")
                        .customFont(size: 15, weight: .semibold)
                    
                    Spacer().frame(width: 20)
                    CustomTextView(imageName: "square.resize", text: "127 m\u{00B2}")
                        .customFont(size: 15, weight: .semibold)
                    
                    
                }
                
                Spacer()
                
            }.padding()
            
            Divider()
            ContactPropertyView()
        }
    }
}

#Preview {
    PropertyTypeFeature()
}
