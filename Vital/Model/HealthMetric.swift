//
//  HealthMetric.swift
//  Vital
//
//  Created by Tyler Rhodes on 5/19/24.
//

import Foundation

struct HealthMetric: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let value: Double
}
