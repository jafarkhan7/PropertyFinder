//
//  TabBarItem.swift
//  PropertyFinder
//
//  Created by Jafar khan on 21/09/2024.
//

import SwiftUI

enum TabBarItem:String, Hashable, CaseIterable {
    case search, explore, favorites, profile
    
    var iconName: String {
        switch self {
        case .search: return "magnifyingglass"
        case .favorites: return "heart"
        case .profile: return "person"
        case .explore: return "sparkle.magnifyingglass"
        }
    }
    
    var title: String {
        self.rawValue.capitalized
    }
    
    var color: Color {
        return Color.superAgent
    }
}
