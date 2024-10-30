//
//  PropertyViewModel.swift
//  PropertyFinder
//
//  Created by Jafar khan on 13/09/2024.
//

import Foundation
import SwiftUI
import Combine

enum OccupationType: String {
    case offPlan
    case ready
}

class PropertyViewModel: ObservableObject {
    @Published var properties: [Property] = [Property]()
    @Published var propertiesFiltered: [Property] = [Property]()
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var occupationType: OccupationType?
    private var cancellables =  Set<AnyCancellable>()
    var newPropertyCount: Int {
       return propertiesFiltered.filter { $0.isNew == true }.count
    }

    init(guestDashboardViewModel: GuestDashboardViewModel) {
        guestDashboardViewModel.$searchText
            .combineLatest(guestDashboardViewModel.$selectedFilters)
            .filter { filter in guestDashboardViewModel.shouldFilter == true }
            .sink { [weak self] searchText, selectedFilters in
                self?.getFilteredPropertiesWithFilter(searchText: searchText, filters: selectedFilters)
                guestDashboardViewModel.shouldFilter = false
            }.store(in: &cancellables)
        fetchProperties()
    }
    
    func fetchProperties() {
        isLoading = true
                        
            Bundle.main.decode(codable: Property.self, "PropertyJson.json").sink { completion in
                
                switch completion {
                case .failure(let error):
                    if let errorString = error as? ErrorItem {
                        self.error = errorString.errorDescription
                    }
                    else {
                        self.error = error.localizedDescription
                    }
                default : break
                }
            } receiveValue: { [weak self] recievedValue in
                
                self?.properties = recievedValue
                self?.propertiesFiltered = recievedValue

            }.store(in: &cancellables)
        
        isLoading = false
    }
    
    func getFilteredProperties(type: OccupationType?) {
        occupationType = type
        
        if let occupationType = type {
            propertiesFiltered = properties.filter { $0.occupationType == occupationType.rawValue }
        }
        else {
            propertiesFiltered = properties
        }
    }
    
    func getFilteredPropertiesWithFilter(searchText: String, filters: Set<String>) {
        if searchText.isEmpty {
            getFilteredProperties(type: occupationType)
        }else {
            propertiesFiltered = properties.filter { $0.propertyType.contains(searchText) }
        }
    }
    
    func fetchMore() {
        isLoading = true
        guard let property = properties.randomElement() else {
            isLoading = false
            return
        }
        
        let propertyTypes: [Property] = (0..<6).map { index in
            let propertyNew = Property(id: (properties.count) + (index + 1), images: property.images.shuffled(), isVerified: property.isVerified, isSuperAgent: property.isSuperAgent, isNew: property.isNew, agentImage: property.agentImage, isFavorited: property.isFavorited, propertyType: property.propertyType, listedAgo: property.listedAgo, locationLat: property.locationLat, locationLong: property.locationLong, bedRoomCount: property.bedRoomCount, bathCount: property.bathCount, squareFeet: property.squareFeet, call: property.call, message: property.message, occupationType: property.occupationType)
            return propertyNew
        }
        propertyTypes.publisher
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .collect()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                self.properties.append(contentsOf: result)
                self.getFilteredProperties(type: self.occupationType)
            })
            .store(in: &cancellables)
        
    }
    
    func isFavorited(item: Property) -> Bool {
         let isFavorited = UserDefaults.standard.bool(forKey: "\(item.id)")
        return isFavorited
    }
    
    func setFavorite(item: Property) {
        let isFavorited = isFavorited(item: item)
        UserDefaults.standard.setValue(!isFavorited, forKey: "\(item.id)")
    }
}
