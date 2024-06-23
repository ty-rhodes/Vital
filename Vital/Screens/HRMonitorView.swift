//
//  HRMonitorView.swift
//  Vital
//
//  Created by Tyler Rhodes on 5/19/24.
//

import SwiftUI

struct HRMonitorView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Heart Rate Circle and Text
                VStack(spacing: 80) {
                    
                    Spacer()
                    
                    ZStack {
//                        Circle().opacity(0.1)
//                            .frame(width: 180, height: 180)
//                            .foregroundStyle(.red.gradient)
//                        Circle().opacity(0.3)
//                            .frame(width: 160, height: 160)
//                            .foregroundStyle(.red.gradient)
                        Circle()
                            .frame(width: 140, height: 140)
                            .foregroundStyle(.red.gradient)
                            .shadow(color: .secondary.opacity(0.3), radius: 2, x: 2, y: 2)
                        
                        VStack(alignment: .center) {
                            Symbols.heartWave
                                .font(.title)
                            HStack(alignment: .center, spacing: 4) {
                                Text("00")
                                    .font(.largeTitle)
                                Text("bpm")
                                    .font(.title3)
                                    .offset(x: 0, y: 5.0)
                            }
                        }
                        .fontWeight(.light)
                        .foregroundStyle(.white.gradient)
                    }
                    .shadow(color: .secondary.opacity(0.3), radius: 2, x: 2, y: 2)
                    
                    Text("Press Start and Place Your Finger\n Over The Camera Lens")
                        .frame(width: 260, height: 50)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .fontWeight(.regular)
                    
                    // MARK: - Monitor Button
                    Button("Start") {
                        // Start monitor
                    }
                    .frame(width: 140, height: 50)
                    .background(Color.red.gradient)
                    .foregroundStyle(.white.gradient)
                    .font(.system(size: 16, weight: .semibold))
                    .cornerRadius(22)
                    .controlSize(.large)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 42)
                    .shadow(color: .secondary.opacity(0.3), radius: 2, x: 2, y: 2)
                    
                    
                    Spacer()
                }
            }
            .navigationTitle("Heart Rate Monitor")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        HRMonitorView()
    }
}
