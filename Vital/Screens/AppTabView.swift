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
            HRMonitorView()
                .tabItem { Label("HRMonitor", systemImage: "waveform.path.ecg.rectangle") }
            AccountView()
                .tabItem { Label("Account", systemImage: "person") }
        }
        .tint(Color.pink.gradient)
    }
}

#Preview {
    AppTabView()
        .environment(HealthKitManager())
}
