//
//  HeartRateListData.swift
//  Vital
//
//  Created by Tyler Rhodes on 6/7/24.
//

import SwiftUI

struct HeartRateListData: View {
    @Environment(HealthKitManager.self) private var hkManager
    
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
    
    @State private var isShowingPermissionPrimingSheet = false
    
    var body: some View {
        VStack {
            if hkManager.heartRateData.isEmpty {
                ChartEmptyView(systemImageName: "waveform.path.ecg", title: "No Data", description: "There is no resting heart rate data to pull from the Health App")
            } else {
                List(hkManager.heartRateData.reversed()) { data in
                    HStack {
                        Text(data.date.displayFormat)
                        Spacer()
                        Text("\(data.value, format: .number.precision(.fractionLength(0))) bpm")
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
        }
        .padding(.horizontal)
        .listStyle(.inset)
        .foregroundStyle(.pink.gradient)
        .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)
        .task {
            do {
                try await hkManager.fetchRestingHeartRate()
                isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
            } catch {
                print("No heart rate list data")
            }
        }
    }
}

#Preview {
    HeartRateListData()
        .environment(HealthKitManager())
}
