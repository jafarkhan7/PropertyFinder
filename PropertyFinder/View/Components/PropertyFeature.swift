//
//  PropertyFeature.swift
//  PropertyFinder
//
//  Created by Jafar on 24/10/2024.
//

import SwiftUI

struct PropertyFeature: View {
    let isVerified: Bool
    let isNew: Bool
    let isSuperAgent: Bool
    
    var body: some View {
        VStack(alignment:.leading) {
            if isVerified {
                CustomTextView(imageName: "checkmark.seal", text: "VERIFIED", color: .white, backGroundColor: Color.verified, padding: 4)
                    .customFont(size: 15, weight: .bold)
                    .lineLimit(1)
                    .cornerRadius(5)
                
            }
            if isSuperAgent {
                CustomTextView(imageName: "checkmark.seal", text: "SUPERAGENT", color: .white, backGroundColor: Color.superAgent, padding: 4)
                    .customFont(size: 15, weight: .bold)
                    .lineLimit(1)
                    .cornerRadius(5)
                
            }
            if isNew {
                CustomTextView(text: "NEW", color: .white, backGroundColor: Color.customGray, padding: 4)
                    .customFont(size: 15, weight: .bold)
                    .lineLimit(1)
                    .cornerRadius(5)
                
            }
            Spacer()
        }
    }
}

#Preview {
    PropertyFeature(isVerified: true, isNew: true, isSuperAgent: true)
}
