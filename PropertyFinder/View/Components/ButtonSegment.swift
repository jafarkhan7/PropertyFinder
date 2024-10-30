//
//  ButtonSegment.swift
//  PropertyFinder
//
//  Created by Jafar khan on 11/09/2024.
//

import SwiftUI

struct ButtonSegment: View {
    var title: String
    var imageName: String = ""
    var action: (() ->())?
    var forgroundColor = Color.superAgent
    var body: some View {
        
        Button(action: {
            action?()
        }, label: {
            HStack (spacing: 5){
                if !imageName.isEmpty {
                    Image(systemName: imageName)
                }
                Text(title)
            }.padding(3)
             // Adjusts the s
        })
        .withPressableStyle()
        .foregroundColor(forgroundColor)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 5))
        
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.superAgent, lineWidth: 2)
        )
        .background(Color.gray.opacity(0.2)) // If you have this
        .cornerRadius(10)
    }
}
#Preview {
    ButtonSegment(title: "PropertyType")
}



struct DropdownView: View {
    @State private var showDropdown = true
    @State private var buttonFrame: CGRect = .zero

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    showDropdown.toggle()
                }
            }) {
                Text("Show Dropdown")
                    .padding()
                    .background(GeometryReader { geometry in
                        Color.clear.onAppear {
                            buttonFrame = geometry.frame(in: .global)
                        }
                    })
                    .background(Color.blue)
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
            
            // Spacer ensures dropdown is placed correctly in relation to the button
            Spacer()

            if showDropdown {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Option 1")
                    Text("Option 2")
                    Text("Option 3")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .frame(width: buttonFrame.width) // Dropdown width matches the button's width
                .position(x: 0, y: buttonFrame.maxY) // Adjust y-offset as needed
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea()) // To visualize the dropdown against the background
    }
}
