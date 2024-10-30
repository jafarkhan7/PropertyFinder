//
//  CustomTabBarView.swift
//  PropertyFinder
//
//  Created by Jafar khan on 21/09/2024.
//

import SwiftUI

struct CustomTabBarView: View {
    var tabs: [TabBarItem]
    @Namespace private var nameSpace
    @Binding var selection: TabBarItem
    var body: some View {
        tabBarView
    }
    
    private var tabBarView: some View  {
        HStack {
            Spacer()
            ForEach(tabs, id:\.self) { tab in
                VStack {
                    Image(systemName: tab.iconName)
                        
                    Text(tab.title)
                        .customFont(size: 10, weight: .semibold)
                }
                .foregroundColor(Color.gray)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        if selection == tab {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(tab.color)
                                .matchedGeometryEffect(id: "background_rectangle", in: nameSpace)
                        }
                    }
                ).onTapGesture {
                    withAnimation(.easeInOut) {
                        selection = tab
                    }
                }
                    
            }
            Spacer()
        }.padding(6)
            .background(Color.white.ignoresSafeArea(edges: .bottom))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 10)
    }
}

#Preview {
    CustomTabBarView(tabs:TabBarItem.allCases, selection: .constant( .search))
}




