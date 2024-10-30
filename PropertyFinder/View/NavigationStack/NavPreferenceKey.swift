//
//  NavPreferenceKey.swift
//  PropertyFinder
//
//  Created by Jafar on 09/10/2024.
//

import Foundation
import SwiftUI


struct NavPreferenceKeyTitle: PreferenceKey {
   
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        defaultValue = nextValue()
    }
}

struct NavBarBackButtonHiddenPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
    
}



struct NavCustomViewKey: PreferenceKey {
    static var defaultValue: CustomViewWrapper<AnyView>? = nil
    
    static func reduce(value: inout CustomViewWrapper<AnyView>?, nextValue: () -> CustomViewWrapper<AnyView>?) {
        value = nextValue() // Take the latest view
    }
}

extension View {
    func setTitle(_ title: String) -> some View {
        self.preference(key: NavPreferenceKeyTitle.self, value: title)
    }
    
    func setCustomView(_ customView: CustomViewWrapper<AnyView>?) -> some View {
        self.preference(key: NavCustomViewKey.self, value: customView)
    }
    
    func setNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
        preference(key: NavBarBackButtonHiddenPreferenceKey.self, value: hidden)
    }
}
