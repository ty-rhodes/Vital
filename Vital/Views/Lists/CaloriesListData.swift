//
//  CaloriesListData.swift
//  Vital
//
//  Created by Tyler Rhodes on 6/20/24.
//

import SwiftUI

struct CaloriesListData: View {
    @Environment(HealthKitManager.self) private var hkManager
    
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
    
    @State private var isShowingPermissionPrimingSheet = false
    
    var body: some View {
        VStack {
            if hkManager.stepData.isEmpty {
                ChartEmptyView(systemImageName: "flame.fill", title: "No Data", description: "There is no resting heart rate data to pull from the Health App")
            } else {
                List(hkManager.calorieData.reversed()) { data in
                    HStack {
                        Text(data.date.displayFormat)
                        Spacer()
                        Text("\(data.value, format: .number.precision(.fractionLength(0))) kcals")
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
        }
        .padding(.horizontal)
        .listStyle(.inset)
        .foregroundStyle(.orange.gradient)
        .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)
        .task {
//            await hkManager.fetchCalories()
            isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
    }
    }}

#Preview {
    CaloriesListData()
        .environment(HealthKitManager())

}
