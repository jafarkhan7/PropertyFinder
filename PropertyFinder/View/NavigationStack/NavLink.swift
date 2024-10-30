//
//  NavLink.swift
//  PropertyFinder
//
//  Created by Jafar on 08/10/2024.
//

import SwiftUI

struct NavLink<Desination: View, Label: View>: View {
    let destination: Desination
    let label: Label
    
    init(@ViewBuilder destination: ()-> Desination,@ViewBuilder label:()-> Label) {
        self.destination = destination()
        self.label = label()
    }
    
    var body: some View {
            NavigationLink {
                NavBarConainer() {
                    destination
                        .navigationBarHidden(true)
                }
            } label: {
                label
            }
            
    }
}

#Preview {
    NavView {
        NavLink {
//            PropertyDetailview()
        } label: {
            Text("Main content")
        }
    }
    

}
