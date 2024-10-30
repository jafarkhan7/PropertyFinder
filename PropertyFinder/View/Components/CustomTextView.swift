//
//  CustomTextView.swift
//  PropertyFinder
//
//  Created by Jafar on 24/10/2024.
//

import SwiftUI

struct CustomTextView: View {
    var imageName: String?
    var text: String = ""
    var color : Color? = Color.gray
    var backGroundColor = Color.clear
    var padding = 0.0
    var body: some View {
        HStack() {
            
            if let imageName = imageName {
                Image(systemName: imageName).foregroundColor(color)
            }
            
            Text(text)
                .foregroundColor(color)
        }.padding(padding)
            .background(backGroundColor)
        
    }
}
#Preview {
    CustomTextView()
}
