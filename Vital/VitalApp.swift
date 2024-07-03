//
//  VitalApp.swift
//  Vital
//
//  Created by Tyler Rhodes on 5/19/24.
//

import SwiftUI

@main
struct VitalApp: App {
    
    let hkmanager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            TabBar()
                .environment(hkmanager)
                .preferredColorScheme(.light)
        }
    }
}
