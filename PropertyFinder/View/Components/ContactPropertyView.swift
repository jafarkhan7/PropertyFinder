//
//  ContactPropertyView.swift
//  PropertyFinder
//
//  Created by Jafar on 24/10/2024.
//

import SwiftUI

struct ContactPropertyView: View {
    var body: some View {
        HStack() {
            
            Button {
                
            } label: {
                HStack(alignment: .center, spacing: 10.0, content: {
                    CustomTextView(imageName: "phone.fill", text: "Call", color: Color.superAgent)
                        .customFont(size: 12, weight: .semibold)
                        .lineLimit(1)
                    
                }).padding(0)
                    .frame(maxWidth: .infinity)
            }.padding()
                .background(Color.lightGray)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
            
            Button {
                
            } label: {
                HStack(alignment: .center, spacing: 10.0, content: {
                    CustomTextView(imageName: "message.fill", text: "WhatsApp", color: Color.superAgent)
                        .lineLimit(1)
                        .customFont(size: 12, weight: .semibold)

                    
                }).padding(0)
                    .frame(maxWidth: .infinity)
                
                
            }.padding()
                .background(Color.lightGray)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity).padding(10)
    }
}

#Preview {
    ContactPropertyView()
}
