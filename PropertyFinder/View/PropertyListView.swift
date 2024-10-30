//
//  PropertyListView.swift
//  PropertyFinder
//
//  Created by Jafar khan on 13/09/2024.
//

import SwiftUI

struct PropertyListView: View {
    @StateObject var viewModel: PropertyViewModel
    @State var searchText: String?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                SubHeaderView(propertyCount:.constant(viewModel.propertiesFiltered.count), newPropertyCount: .constant(viewModel.newPropertyCount), onToggle: { selected in
                    let propertyType =  selected == 0 ? nil : selected == 1 ? OccupationType.offPlan : OccupationType.ready
                    viewModel.getFilteredProperties(type: propertyType)
                })
                if let error = viewModel.error {
                    Text(error)
                        .offset(y:  UIScreen.height / 3)
                    
                }
                ForEach(viewModel.propertiesFiltered) { item in
                    
                    NavLink {
                        PropertyDetailview(propertyDetailsViewModel: PropertyDetailsViewModel(property: item))
                        
                    } label: {
                        getPropertyList(item: item)
                    }
                  }
                
                // Show loading indicator when loading more items
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
        }
    }
}

extension PropertyListView {
    private func getPropertyList(item: Property) -> some View {
        VStack {
            imageContent(item: item)
            Spacer()
            PropertyTypeFeature()
            Spacer()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
        
        .padding()
    }
    
    private func imageContent(item: Property) -> some View {
            ZStack() {
                PropertyImageView(propertyImages: item.images).frame(height: 300)
                
                    .onAppear {
                        // Trigger load more when the last item appears
                        if item.id == viewModel.propertiesFiltered.last?.id {
                            viewModel.fetchMore()
                        }
                    }
                
                HStack(alignment:.top, content: {
                    PropertyFeature(isVerified: item.isVerified, isNew: item.isNew, isSuperAgent: item.isSuperAgent)
                    Spacer()
                    CircleImage(
                        isEnabled: viewModel.isFavorited(item: item),
                        imageName:"heart.fill",
                        imageNameDisable:
                            "heart",
                        onToggle: {
                            viewModel.setFavorite(item: item)
                        }
                    )
                }
                )
                .padding(.top)
                .padding(.leading,10)
                .padding(.trailing, 10)
            }.cornerRadius(10)
        
    }
}


#Preview {
    PropertyListView(viewModel: PropertyViewModel(guestDashboardViewModel: GuestDashboardViewModel()))
}
