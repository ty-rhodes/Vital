//
//  AccountView.swift
//  Vital
//
//  Created by Tyler Rhodes on 5/19/24.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Label("General Health Info", systemImage: "scroll")
                        .foregroundStyle(.secondary)) {
                            HStack {
                                Symbols.link
                                VStack(alignment: .leading) {
                                    Link("Heart Health", destination: Links.heartLink!)
                                        .font(.system(size: 18, weight: .medium))
                                    Text("Maximum and target heart rate by age.")
                                        .font(.system(size: 14, weight: .light))
                                }
                            }
                            
                            HStack {
                                Symbols.link
                                VStack(alignment: .leading) {
                                    Link("Importance of Daily Steps", destination: Links.stepsLink!)
                                        .font(.system(size: 18, weight: .medium))
                                    Text("The low cost of daily physical activity.")
                                        .font(.system(size: 14, weight: .light))
                                }
                            }
                            
                            HStack {
                                Symbols.link
                                VStack(alignment: .leading) {
                                    Link("Calories Burned by Age", destination: Links.caloriesLink!)
                                        .font(.system(size: 18, weight: .medium))
                                    Text("Average calories burned by age.")
                                        .font(.system(size: 14, weight: .light))
                                }
                            }

                        }
                        .foregroundStyle(.primary)
                    
                    Section(header: Label("Legal", systemImage: "scroll")
                        .foregroundStyle(.secondary)) {
                            HStack {
                                Symbols.link
                                Link("Terms Of Service", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                            }
                            HStack {
                                Symbols.link
                                Link("Privacy Policy", destination: URL(string: "https://sites.google.com/view/ritualbrewandrenew/home")!)
                            }
                        }
                        .foregroundStyle(.primary)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AccountView()
}
