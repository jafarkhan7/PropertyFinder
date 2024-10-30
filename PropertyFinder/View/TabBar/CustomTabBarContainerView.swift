//
//  CustomTabBarContainerView.swift
//  PropertyFinder
//
//  Created by Jafar khan on 21/09/2024.
//

import SwiftUI

struct CustomTabBarContainerView<Content:View>: View {
    
    private let content: Content
    @State private var tabs = [TabBarItem]()
    @Binding private var selection: TabBarItem
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content:()-> Content) {
        self.content = content()
        self._selection = selection
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            content.padding(1)
                .padding(.bottom)
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
        .onPreferenceChange(TabBarPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

#Preview {
    CustomTabBarContainerView(selection: .constant(.explore)) {
        Color.red
    }
}

