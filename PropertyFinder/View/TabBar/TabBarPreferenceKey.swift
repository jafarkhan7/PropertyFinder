//
//  TabBarPreferenceKey.swift
//  PropertyFinder
//
//  Created by Jafar khan on 21/09/2024.
//

import Foundation
import SwiftUI

struct TabBarPreferenceKey: PreferenceKey {
    static var defaultValue = [TabBarItem]()
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

struct TabBarModifier: ViewModifier {
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
   @ViewBuilder func body(content: Content) -> some View {
       content.opacity(tab == selection ? 1 : 0.0)
       .preference(key: TabBarPreferenceKey.self, value: [tab])
    }
}

extension View {
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabBarModifier(tab: tab, selection: selection))
    }
}
