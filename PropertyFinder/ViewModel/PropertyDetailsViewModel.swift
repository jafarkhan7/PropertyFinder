//
//  PropertyDetailsViewModel.swift
//  PropertyFinder
//
//  Created by Jafar on 14/10/2024.
//

import Foundation
import Combine
import SwiftUI

class PropertyDetailsViewModel: ObservableObject {
    @Published var property: Property
    
    init(property: Property) {
        self.property = property
    }
    
    
    
    
}
