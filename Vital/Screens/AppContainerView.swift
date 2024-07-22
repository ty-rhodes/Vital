//
//  AppContainerView.swift
//  Vital
//
//  Created by Tyler Rhodes on 7/21/24.
//

import SwiftUI

struct AppContainerView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    
    var body: some View {
        if hasCompletedOnboarding {
            VitalTabBar()
        } else {
            OnboardScreen(hasCompletedOnboarding: $hasCompletedOnboarding)
        }
    }
}

#Preview {
    AppContainerView()
        .environment(HealthKitManager())
}
