//
//  Searchbar.swift
//  PropertyFinder
//
//  Created by Jafar khan on 11/09/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            HStack {
                Spacer(minLength: 20)
                Image(systemName: "magnifyingglass")
                Spacer(minLength: 20)
                TextField("City, area or building", text: $searchText)
                    .frame(height: 50)
                
            }
            .background() {
                Color.gray.opacity(0.3)
            }
            .cornerRadius(10)
            .padding()
            Button(action: {}, label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .resizable()     
                    .aspectRatio(contentMode: .fit).frame(width: 40, height: 40)
                    .customFont(size: 15)
            })
            
        }
    }
}
