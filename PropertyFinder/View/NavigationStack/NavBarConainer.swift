//
//  NavBarConainer.swift
//  PropertyFinder
//
//  Created by Jafar on 08/10/2024.
//

import SwiftUI

struct NavBarConainer<Content: View>: View {
    let content: Content
    @State private var title: String = ""
    @State private var showBackButton: Bool = true

    @State private var customView: CustomViewWrapper<AnyView>? = nil

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                    .onPreferenceChange(NavPreferenceKeyTitle.self, perform: { value in
                        title = value
                    })
                
                    .onPreferenceChange(NavCustomViewKey.self, perform: { value in
                        customView = value
                    })
                
                    .onPreferenceChange(NavBarBackButtonHiddenPreferenceKey.self, perform: { value in
                        showBackButton = !value
                    })
                
                NavBarView(showBackButton: showBackButton, title: title, customView: customView)
                    .customTransition(opacity: 0)
                
            }
           
        }
       
    }
}

struct CustomViewWrapper<Content: View>: View, Equatable, Identifiable {
    var id = UUID().uuidString
    
    let view: Content

    static func == (lhs: CustomViewWrapper, rhs: CustomViewWrapper) -> Bool {
        return lhs.id == rhs.id
    }

    var body: some View {
        view
    }
}



