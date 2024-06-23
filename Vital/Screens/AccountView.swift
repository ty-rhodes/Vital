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
                    Section(header: Label("Legal", systemImage: "scroll")
                        .foregroundColor(.secondary)){
                            HStack {
                                Symbols.link
                                Link("Terms Of Service", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                            }
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(.black)
                            
                            HStack {
                                Symbols.link
                                Link("Privacy Policy", destination: URL(string: "https://sites.google.com/view/ritualbrewandrenew/home")!)
                            }
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(.black)
                        }
                }
            }
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AccountView()
}
