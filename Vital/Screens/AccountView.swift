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
                                    Link("Heart Health", destination: Hyperlinks.heartLink!)
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundStyle(.pink.gradient)
                                    Text("Maximum and target heart rate by age.")
                                        .font(.system(size: 14, weight: .light))
                                }
                            }
                            
                            HStack {
                                Symbols.link
                                VStack(alignment: .leading) {
                                    Link("Importance of Daily Steps", destination: Hyperlinks.stepsLink!)
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundStyle(.mint.gradient)
                                    Text("The low cost of daily physical activity.")
                                        .font(.system(size: 14, weight: .light))
                                }
                            }
                            
                            HStack {
                                Symbols.link
                                VStack(alignment: .leading) {
                                    Link("Calories Burned by Age", destination: Hyperlinks.caloriesLink!)
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundStyle(.orange.gradient)
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
                                Link("Terms Of Service", destination: Hyperlinks.termsOfService!)
                            }
                            HStack {
                                Symbols.link
                                Link("Privacy Policy", destination: Hyperlinks.privacyPolicy!)
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
