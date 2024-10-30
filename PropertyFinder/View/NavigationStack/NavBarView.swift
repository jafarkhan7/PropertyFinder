//
//  NavBarView.swift
//  PropertyFinder
//
//  Created by Jafar on 08/10/2024.
//

import SwiftUI

struct NavBarView<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    let customView: CustomViewWrapper<Content>?
    
    var body: some View {
        HStack {
            if showBackButton {
                backButton
            }
            if  !title.isEmpty {
                Spacer()
                titleSection
            }
            if let customView  = customView {
                Spacer()
                customView.view
            }
        }
    }
}

extension NavBarView {
    private var backButton: some View {
        CircleImage(isEnabled: true,size:CGSize(width: 30, height: 30), imageName: "arrowshape.backward", selectedImageColor: .black, unselectedImageColor: .black) {
            presentationMode.wrappedValue.dismiss()
        }.padding(.horizontal)
    }
    
    private var titleSection: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    NavBarView<EmptyView>(showBackButton: true, title: "TItle here", customView: nil)
}
