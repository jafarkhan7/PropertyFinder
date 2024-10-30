//
//  HeaderView.swift
//  PropertyFinder
//
//  Created by Jafar khan on 11/09/2024.
//

import SwiftUI

struct HeaderView: View {
    var segmentItem = ["Buy", "Property type", "Price", "Beds & Baths", "Amenities"]
    @Binding var searchText: String
    var onSubmit:(String)->Void
    var body: some View {
        VStack() {
            SearchBar(searchText: $searchText).onSubmit {
                onSubmit(searchText)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(segmentItem, id: \.self) { item in
                        ButtonSegment(title: "\(item)")
                            .customFont(size: 12, weight: .light)
                    }
                }
            }
        }
    }
}

#Preview {
    HeaderView(searchText: .constant("")) { _ in
        
    }
}
