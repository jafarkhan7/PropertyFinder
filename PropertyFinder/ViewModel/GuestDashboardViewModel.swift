//
//  GuestDashboardViewModel.swift
//  PropertyFinder
//
//  Created by Jafar on 06/10/2024.
//

import SwiftUI
import Combine

class GuestDashboardViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selection =  TabBarItem.search
    @Published var selectedFilters: Set<String> = []
    var shouldFilter = false

    private var cancellable = Set<AnyCancellable>()
    let editingEnded = PassthroughSubject<Void,Never>()
    
    lazy var propertyViewModel: PropertyViewModel = {
        return PropertyViewModel(guestDashboardViewModel: self)
    }()
    
    init() {
        editingEnded.sink { [weak self] in
            self?.didEndEditing()
        }.store(in: &cancellable)
        
    }
    
    private func didEndEditing() {
        shouldFilter = true
        print("searchText \(searchText)")
    }
}
