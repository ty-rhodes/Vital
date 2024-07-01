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
    @State private var selectedStat: HealthMetricContext = .heartrate
    
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
                        Text("Heart Rate List Data")
                            .frame(height: 8)
                            .foregroundStyle(.pink.gradient)
                            .font(.title3)
                            .shadow(color: .secondary.opacity(0.3), radius: 1, x: 1, y: 1)
                        Divider()
                            .frame(width: 368)
                        HeartRateListData()
                    case .steps:
                        Text("Steps List Data")
                            .frame(height: 8)
                            .foregroundStyle(.mint.gradient)
                            .font(.title3)
                            .shadow(color: .secondary.opacity(0.3), radius: 1, x: 1, y: 1)
                        Divider()
                            .frame(width: 368)
                        StepsListData()
                    case .calories:
                        Text("Calories List Data")
                            .frame(height: 8)
                            .foregroundStyle(.orange.gradient)
                            .font(.title3)
                            .shadow(color: .secondary.opacity(0.3), radius: 1, x: 1, y: 1)
                        Divider()
                            .frame(width: 368)
                        CaloriesListData()
                    }
                }
                .onAppear {
                    isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
                }
                .navigationTitle("Health Data")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $isShowingPermissionPrimingSheet, onDismiss: {
                    // fetch health data
                }, content: {
                    HealthKitPermissionView(hasSeen: $hasSeenPermissionPriming)
            })
            }
        }
    }
}

#Preview {
    NavigationStack {
        DashboardView(metric: .steps)
            .environment(HealthKitManager())
    }
}
