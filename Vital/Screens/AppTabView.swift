//
//  AppTabView.swift
//  Vital
//
//  Created by Tyler Rhodes on 5/19/24.
//

import SwiftUI

struct AppTabView: View {
    @Environment(HealthKitManager.self) private var hkManager
    
    var body: some View {
        TabView {
            DashboardView(metric: .heartrate)
                .tabItem { Label("Data", systemImage: "heart.text.square") }
            AccountView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
        .tint(Color.pink.gradient)
    }
}

#Preview {
    AppTabView()
        .environment(HealthKitManager())
}
