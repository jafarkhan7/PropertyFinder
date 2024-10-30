//
//  PropertyFinderApp.swift
//  PropertyFinder
//
//  Created by Jafar on 04/10/2024.
//

import SwiftUI

@main
struct PropertyFinderApp: App {
    init() {
    }
    var body: some Scene {
        WindowGroup {
            
            GuestDashboard(guestDashboardVm: GuestDashboardViewModel())
        }
    }
}
