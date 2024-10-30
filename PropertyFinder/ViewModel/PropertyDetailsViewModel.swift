//
//  PropertyDetailsView.swift
//  PropertyFinder
//
//  Created by Jafar on 14/10/2024.
//

import Foundation
import Combine
import SwiftUI

class PropertyDetailsView: ObservableObject {
    @Binding var property: Property
    
    init(property: Property) {
        self.property = property
    }
}
