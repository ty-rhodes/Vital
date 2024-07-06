//
//  TabBar.swift
//  Vital
//
//  Created by Tyler Rhodes on 7/3/24.
//

import SwiftUI

struct VitalTabBar: View {
    @Environment(HealthKitManager.self) private var hkManager
    
    @State private var selectedTab: Tab = .dashboard
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // MARK: - Custom Tab Group
            Group {
                switch selectedTab {
                case .dashboard:
                    DashboardView(metric: .heartrate)
                case .account:
                    AccountView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // MARK: - TabView
            HStack(alignment: .center) {
                ForEach(tabItems) { item in
                    TabButton(selectedTab: $selectedTab, item: item)
                }
            }
            .padding(.horizontal, 8)
            .frame(width: 140, height: 24, alignment: .top)
            .multilineTextAlignment(.center)
            .padding()
            .foregroundStyle(.black)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
            .shadow(color: .secondary.opacity(0.3), radius: 6, x: 2, y: 5)
            .ignoresSafeArea()
        }
    }
}

struct TabButton: View {
    
    @Binding var selectedTab: Tab
    let item: TabItem

    var body: some View {
        Button {
            selectedTab = item.tab
        } label: {
            VStack(spacing: 2) {
                item.icon
                    .font(.body.bold())
                    .frame(width: 38, height: 26)
                    .foregroundStyle(selectedTab == item.tab ? .black : .secondary.opacity(0.8))
                Text(item.text)
                    .font(.caption2)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
        }
        .offset(y: -6)
        .foregroundStyle(selectedTab == item.tab ? .black : .secondary.opacity(0.8))
    }
}

#Preview {
    VitalTabBar()
        .environment(HealthKitManager())
}

private extension VitalTabBar {
    
    func didDismiss() {
        print("dismiss")
    }
}
