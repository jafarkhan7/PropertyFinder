//
//  GuestDashboard.swift
//  PropertyFinder
//
//  Created by Jafar khan on 10/09/2024.
//

import SwiftUI

struct GuestDashboard: View {
    
@StateObject var guestDashboardVm = GuestDashboardViewModel()
    
    var body: some View {
        NavView {
            ZStack {
                    CustomTabBarContainerView(selection: $guestDashboardVm.selection) {
                        
                        searchContent
                            .tabBarItem(tab: .search, selection: $guestDashboardVm.selection)
                        
                        searchContent
                       .tabBarItem(tab: .explore, selection: $guestDashboardVm.selection)
                        
                        searchContent
                       .tabBarItem(tab: .favorites, selection: $guestDashboardVm.selection)
                        
                        searchContent
                       .tabBarItem(tab: .profile, selection: $guestDashboardVm.selection)

                    }
            }
            .setNavigationBarBackButtonHidden(true)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

extension GuestDashboard {
    
    private var searchContent: some View {
            VStack(spacing: 0) {
                HeaderView(searchText: $guestDashboardVm.searchText, onSubmit: {
                    guestDashboardVm.editingEnded.send()
                }).customFont(size: 15)
                .padding(.top)
                Spacer()
                
                PropertyListView(viewModel: guestDashboardVm.propertyViewModel).padding(.bottom, 50)
            }
            .edgesIgnoringSafeArea(.all)
        }
    
}

#Preview {
    GuestDashboard()
}
