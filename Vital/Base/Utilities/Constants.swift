//
//  Constants.swift
//  Vital
//
//  Created by Tyler Rhodes on 5/22/24.
//

import SwiftUI

enum Symbols {
    static let heartWave = Image(systemName: "waveform.path.ecg")
    static let link      = Image(systemName: "link")
}

enum Theme {
    static let heartRateBackground = Color.pink.gradient
}

enum Hyperlinks {
    static let heartLink = URL(string: "https://www.heart.org/en/healthy-living/fitness/fitness-basics/target-heart-rates")
    static let stepsLink = URL(string: "https://www.nih.gov/news-events/nih-research-matters/number-steps-day-more-important-step-intensity")
    static let caloriesLink = URL(string: "https://health.clevelandclinic.org/calories-burned-in-a-day")
    static let termsOfService = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")
    static let privacyPolicy = URL(string: "https://sites.google.com/d/1sR_BGq4HK9F_oAkrNDxx5bBMppbiKLKH/p/10_EVKhDYDAX-S7kONJozlSYPUY1ivuOG/edit")
}
