//
//  StepsListData.swift
//  Vital
//
//  Created by Tyler Rhodes on 6/7/24.
//

import SwiftUI

struct StepsListData: View {
    @Environment(HealthKitManager.self) private var hkManager
    
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
    
    @State private var isShowingPermissionPrimingSheet = false
    
    var body: some View {
        VStack {
            if hkManager.stepData.isEmpty {
                ChartEmptyView(systemImageName: "figure.walk", title: "No Data", description: "There is no resting heart rate data to pull from the Health App")
            } else {
                List(hkManager.stepData.reversed()) { data in
                    HStack {
                        Text(data.date.displayFormat)
                        Spacer()
                        Text("\(data.value, format: .number.precision(.fractionLength(0))) steps")
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
        }
        .padding(.horizontal)
        .listStyle(.inset)
        .frame(height: 260)
        .offset(y: -6)
        .foregroundStyle(.mint.gradient)
        .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)
        .task {
            do {
                try await hkManager.fetchStepCount()
                isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
            } catch {
                print("No step list data")
            }
        }
    }
}

#Preview {
    StepsListData()
        .environment(HealthKitManager())
}

struct StepsListCell: View {
    
    var metric: HealthMetric
    
    var body: some View {
        HStack {
            Text(metric.date.displayFormat)
                .fontWeight(.light)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
            Spacer()
                
            Text("\(metric.value, format: .number.precision(.fractionLength(0))) steps")
                .fontWeight(.light)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
        }
    }
}
