//
//  OnboardScreen.swift
//  Vital
//
//  Created by Tyler Rhodes on 7/3/24.
//

import SwiftUI

struct OnboardScreen: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .mint], startPoint: .top, endPoint: .bottom)
                .opacity(0.2)
                .ignoresSafeArea()
            VStack(spacing: 15) {
                Text("Welcome to \nVital")
                    .font(.system(size: 40, weight: .light))
                    .multilineTextAlignment(.center)
                    .padding(.top, 65)
                    .padding(.bottom, 35)
                
                // Points View
                VStack(alignment: .leading, spacing: 25) {
                    PointView(symbol: "heart.text.square",
                              title: "Sync Apple Health Data",
                              subTitle: "Sync your Apple Health data with Vital..")
                    
                    PointView(symbol: "chart.bar",
                              title: "Visualize Data",
                              subTitle: "Once synced, see a visual representation of your health data within charts and lists.")
                    
                    PointView(symbol: "heart",
                              title: "Stay Healthy!",
                              subTitle: "With your data visualized, have a better understanding of your health goals.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                
                Spacer()
                
                Button(action: {
                    isFirstTime = false
                }, label: {
                    Text("Get Started")
                        .frame(width: 350, height: 50)
                        .background(.pink.gradient)
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .cornerRadius(25)
                        .controlSize(.large)
                        .padding(.vertical, 14)
                })
                
                Spacer()
            }
            .padding(15)
            .padding(.vertical, 20)
        }
    }
    
    // Point View
    @ViewBuilder
    func PointView(symbol: String, title: String, subTitle: String) -> some View {
        HStack(spacing: 20) {
            Image(systemName: symbol)
                .frame(width: 45)
                .font(.largeTitle)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(subTitle)
                    .foregroundStyle(.black)
                    .minimumScaleFactor(0.6)
            }
        }
    }
}

#Preview {
    OnboardScreen()
}
