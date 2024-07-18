//
//  DashboardView.swift
//  Vital
//
//  Created by Tyler Rhodes on 5/19/24.
//

import SwiftUI
import Charts

enum HealthMetricContext: CaseIterable, Identifiable {
    case heartrate, steps, calories
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .heartrate:
            return "Heart Rate"
        case .steps:
            return "Steps"
        case .calories:
            return "Calories"
        }
    }
}

struct DashboardView: View {
    @Environment(HealthKitManager.self) private var hkManager
    
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
    
    @State private var isShowingPermissionPrimingSheet = false
    @State private var selectedStat: HealthMetricContext = .steps
    
    var metric: HealthMetricContext
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    VStack {
                        // MARK: - Date Display
                        HStack {
                            Text(Date().displayFormat)
                            Spacer()
                        }
                        .padding(.horizontal)
                        // MARK: - Chart Data
                        switch selectedStat {
                        case .heartrate:
                            HeartRateChart(selectedStat: selectedStat, chartData: hkManager.heartRateData)
                        case .steps:
                            StepsChart(selectedStat: selectedStat, chartData: hkManager.stepData)
                        case .calories:
                            CaloriesChart(selectedStat: selectedStat, chartData: hkManager.calorieData)
                        }
                        // MARK: - Data Picker
                        Picker("Selected Stat", selection: $selectedStat) {
                            ForEach(HealthMetricContext.allCases) {
                                Text($0.title)
                            }
                        }
                        .pickerStyle(.segmented)
                        .shadow(color: .secondary.opacity(0.3), radius: 0.5, x: 1, y: 1)
                    }
                    .padding()
                    // MARK: - List Data
                    switch selectedStat {
                    case .heartrate:
                        ListDataHeader(header: "Heart Rate List Data")
                            .foregroundStyle(.pink.gradient)
                        HeartRateListData()
                    case .steps:
                        ListDataHeader(header: "Steps List Data")
                            .foregroundStyle(.mint.gradient)
                        StepsListData()
                    case .calories:
                        ListDataHeader(header: "Calories List Data")
                            .foregroundStyle(.orange.gradient)
                        CaloriesListData()
                    }
                }
                .offset(y: -30)
                .onAppear {
                    isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
                }
                .navigationTitle("Health Data")
                .navigationBarTitleDisplayMode(.inline)
                .fullScreenCover(isPresented: $isShowingPermissionPrimingSheet, onDismiss: {
                    // fetch health data
                    fetchHealthData()
                }, content: {
                    HealthKitPermissionView(hasSeen: $hasSeenPermissionPriming)
            })
            }
        }
    }
    
    private func fetchHealthData() {
        Task {
            async let heartRate = hkManager.fetchRestingHeartRate()
            async let steps = hkManager.fetchStepCount()
            async let calories = hkManager.fetchCalories()
            
            hkManager.heartRateData = try await heartRate
            hkManager.stepData = try await steps
            hkManager.calorieData = try await calories
        }
    }
}

#Preview {
    NavigationStack {
        DashboardView(metric: .steps)
            .environment(HealthKitManager())
    }
}

struct ListDataHeader: View {
    
    var header: String
    
    var body: some View {
        Text(header)
            .frame(height: 8)
            .font(.title3)
            .shadow(color: .secondary.opacity(0.3), radius: 1, x: 1, y: 1)
            .offset(y: -10)
        Divider()
            .frame(width: 340)
            .offset(y: -6)
    }
}
