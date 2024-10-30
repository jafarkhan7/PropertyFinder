//
//  GuestDashboard.swift
//  PropertyFinder
//
//  Created by Jafar khan on 10/09/2024.
//

import SwiftUI

struct GuestDashboard: View {
    
    @State var searchText: String = ""
    @State var selection =  TabBarItem.search

    var body: some View {
        NavigationView {
            ZStack {
                CustomTabBarContainerView(selection: $selection) {
                    
                    searchContent
                        .tabBarItem(tab: .search, selection: $selection)
                    
                    searchContent
                   .tabBarItem(tab: .explore, selection: $selection)
                    
                    searchContent
                   .tabBarItem(tab: .favorites, selection: $selection)
                    
                    searchContent
                   .tabBarItem(tab: .profile, selection: $selection)

                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

extension GuestDashboard {
    
    private var searchContent: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                HeaderView(searchText: $searchText, onSubmit: { searchText in
                    self.searchText = searchText
                }).customFont(size: 15)
                .padding(.top, geometry.safeAreaInsets.top)
                Spacer()
                
                PropertyListView().padding(.bottom, 50)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    GuestDashboard()
}
