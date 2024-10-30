//
//  NavView.swift
//  PropertyFinder
//
//  Created by Jafar on 08/10/2024.
//

import SwiftUI

struct NavView<Content: View>: View {
    
    let content: Content
    @State private var title = ""
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack {
            NavBarConainer() {
                content
                    
            }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
