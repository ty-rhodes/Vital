//
//  HealthKitPermissionView.swift
//  Vital
//
//  Created by Tyler Rhodes on 5/25/24.
//

import SwiftUI
import HealthKitUI

struct HealthKitPermissionView: View {
    @Environment(HealthKitManager.self) private var hkManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var isShowingHealthKitPermissions = false
    
    @Binding var hasSeen: Bool
    
    var description = """
This app displays your resting heart rate, steps, and calories burned data in interactive charts. Your data is private and secured.
"""
    
    var body: some View {
        VStack(spacing: 130) {
            // MARK: - Connect Health Description
            VStack(alignment: .center, spacing: 10) {
                Image(.appleHealth)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .shadow(color: .gray.opacity(0.3), radius: 16)
                    .padding(.bottom, 12)
                
                Text("Apple Health Connection")
                    .font(.title2.bold())
                
                Text(description)
                    .foregroundStyle(.secondary)
            }
            // MARK: - Connect Health Button
            Button("Connect Apple Health") {
                isShowingHealthKitPermissions = true
            }
            .frame(width: 200, height: 50)
            .background(Color.red.gradient)
            .foregroundStyle(.white.gradient)
            .font(.system(size: 16, weight: .semibold))
            .cornerRadius(16)
            .controlSize(.large)
        }
        .padding(30)
        .interactiveDismissDisabled()
        .onAppear { hasSeen = true }
        .healthDataAccessRequest(store: hkManager.store,
                                 shareTypes: hkManager.types,
                                 readTypes: hkManager.types,
                                 trigger: isShowingHealthKitPermissions) { result in
            switch result {
            case .success(_):
                dismiss()
            case .failure(_):
                // handle error later
                dismiss()
            }
        }
    }
}

#Preview {
    HealthKitPermissionView(hasSeen: .constant(true))
        .environment(HealthKitManager())
}
