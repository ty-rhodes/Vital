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
            List(MockData.heartrates) { data in
                HStack {
                    Text(data.date.displayFormat)
                    Spacer()
                    Text("\(data.value, format: .number.precision(.fractionLength(0))) bpm")
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .padding(.horizontal)
        .listStyle(.inset)
        .foregroundStyle(.pink.gradient)
        .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)
        .task {
//            await hkManager.fetchRestingHeartRate()
            isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
    }
    }
}

#Preview {
    HeartRateListData()
        .environment(HealthKitManager())
}
