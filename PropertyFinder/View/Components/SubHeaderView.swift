//
//  SubHeaderView.swift
//  PropertyFinder
//
//  Created by Jafar khan on 14/09/2024.
//

import SwiftUI

struct SubHeaderView: View {
    @Environment(\.sizeCategory) var scaleFactor
    
    let segments = ["Any", "Off-plan", "Ready"]
    @Binding var propertyCount: Int
    @Binding var newPropertyCount: Int
    @State private var selectedSegment = 0
    @State private var selectedFeature = 0
    var onToggle: (Int)->Void
    var menuItem = ["Featured", "Newest", "Price (low)", "Verified first"]
    @Namespace var nameSpace
    
    var body: some View {
        VStack {
            HStack() {
                VStack(alignment: .leading, content: {
                    Text("\(propertyCount) Properties")
                        .customFont(size: 15, weight: .regular)
                    if newPropertyCount > 0 {
                        Text("\(newPropertyCount) New")
                            .customFont(size: 15, weight: .semibold)
                            .lineLimit(1)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(10)
                    }
                    
                })
                Spacer()
                VStack(alignment: .trailing) {
                    
                    MenuDropDown(menuItem: menuItem, selectedIndex: $selectedFeature) {
                        ButtonSegment(title: menuItem[selectedFeature], imageName: "arrow.up.arrow.down").customFont(size: 15)
                    }
                    
                }
                
            }
            
            
            Picker("", selection: $selectedSegment) {
                ForEach(0..<segments.count, id: \.self) { index in
                    Text(segments[index])
                        .tag(index).onChange(of: selectedSegment) { oldValue, newValue in
                            onToggle(newValue)
                        }
                    
                }
            }.background(Color.superAgent.opacity(0.35))
                .pickerStyle(SegmentedPickerStyle()).cornerRadius(7)
            
            
            
        }.padding(.all)
        
    }
}

#Preview {
    SubHeaderView(propertyCount: .constant(23), newPropertyCount: .constant(0)) {_ in
        
    }
}
