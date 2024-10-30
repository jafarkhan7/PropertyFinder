//
//  PropertyViewModel.swift
//  PropertyFinder
//
//  Created by Jafar khan on 13/09/2024.
//

import Foundation
import SwiftUI
import Combine

enum PropertyType: String {
    case offPlan
    case ready
    
}

class PropertyViewModel: ObservableObject {
    @Published var properties: [Property] = [Property]()
    @Published var propertiesFiltered: [Property] = [Property]()
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var propertyType: PropertyType?
    var cancellab =  Set<AnyCancellable>()
    var newPropertyCount: Int {
       return propertiesFiltered.filter { $0.isNew == true }.count
    }

    init() {
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

            }.store(in: &cancellab)
        
        isLoading = false
    }
    
    func getFilteredProperties(type: PropertyType?) {
        propertyType = type
        
        if let propertyType = type {
            propertiesFiltered = properties.filter { $0.occupationType == propertyType.rawValue }
        }
        else {
            propertiesFiltered = properties
        }
        
    }
    
    
    func fetchMore() {
        isLoading = true
        guard let property = properties.randomElement() else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
            guard let welf = self else { return }
            let propertiesNew = (0..<6).map { index in
                let propertyNew = Property(id: (welf.properties.count) + (index + 1), images: property.images.shuffled(), isVerified: property.isVerified, isSuperAgent: property.isSuperAgent, isNew: property.isNew, agentImage: property.agentImage, isFavorited: property.isFavorited, propertyType: property.propertyType, listedAgo: property.listedAgo, locationLat: property.locationLat, locationLong: property.locationLong, bedRoomCount: property.bedRoomCount, bathCount: property.bathCount, squareFeet: property.squareFeet, call: property.call, message: property.message, occupationType: property.occupationType)
                return propertyNew
        }
            welf.properties.append(contentsOf: propertiesNew)
            welf.getFilteredProperties(type: welf.propertyType)
        }
            
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
