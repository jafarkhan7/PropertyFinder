//
//  PropertyModel.swift
//  PropertyFinder
//
//  Created by Jafar khan on 11/09/2024.
//

import Foundation

struct Property: Codable, Identifiable, Hashable, Equatable {
    static func == (lhs: Property, rhs: Property) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           hasher.combine(isVerified)
           hasher.combine(isNew)
           hasher.combine(isSuperAgent)
           // Include other properties as necessary
       }
    
    
    let id: Int
    let images: [PropertyImage]
    let isVerified: Bool
    let isSuperAgent: Bool
    let isNew: Bool
    let agentImage: String
    var isFavorited: Bool
    let propertyType: String
    let listedAgo: String
    let locationLat: Double
    let locationLong: Double
    let bedRoomCount: Int
    let bathCount: Int
    let squareFeet: Double
    let call: Int
    let message: Int
    let occupationType: String
}

// MARK: - Image

struct PropertyImage: Codable, Identifiable {
    static func == (lhs: PropertyImage, rhs: PropertyImage) -> Bool {
        lhs.id == rhs.id
    }
    let id: Int
    let name: String
}
