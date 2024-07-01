//
//  HealthKitManager.swift
//  Vital
//
//  Created by Tyler Rhodes on 5/19/24.
//

import Foundation
import HealthKit
import Observation

@Observable class HealthKitManager {
    
    // MARK: - HealthKit Store
    let store = HKHealthStore()
    
    // MARK: - HealthKit Data Types
    let types: Set = [HKQuantityType(.restingHeartRate),
                      HKQuantityType(.stepCount),
                      HKQuantityType(.activeEnergyBurned)
    ]
    
    // MARK: - HealthMetric Data values
    var heartRateData: [HealthMetric] = []
    var stepData: [HealthMetric] = []
    var calorieData: [HealthMetric] = []
    
    // MARK: - Functions
    func fetchRestingHeartRate() async throws -> [HealthMetric] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.restingHeartRate), predicate: queryPredicate)
        let heartRateQuery = HKStatisticsCollectionQueryDescriptor(predicate: samplePredicate,
                                                                   options: .discreteAverage,
                                                                   anchorDate: endDate,
                                                                   intervalComponents: .init(day: 1))
        //        do {
        //            let heartRateCounts = try await heartRateQuery.result(for: store)
        //            heartRateData = heartRateCounts.statistics().map {
        //                .init(date: $0.startDate, value: $0.sumQuantity()?.doubleValue(for: .count()) ?? 0)
        //            }
        //        } catch {
        //
        //        }
        
        for try await result in heartRateQuery.results(for: store) {
            heartRateData = result.statisticsCollection.statistics().map{
                HealthMetric(date: $0.startDate, value: $0.sumQuantity()?.doubleValue(for: .count()) ?? 0)
            }
        }
        
        return heartRateData
    }
    
    func fetchStepCount() async throws -> [HealthMetric] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.stepCount), predicate: queryPredicate)
        let stepsQuery = HKStatisticsCollectionQueryDescriptor(predicate: samplePredicate,
                                                               options: .cumulativeSum,
                                                               anchorDate: endDate,
                                                               intervalComponents: .init(day: 1))
        //        do {
        //            let stepCounts = try await stepsQuery.result(for: store)
        //            stepData = stepCounts.statistics().map {
        //                .init(date: $0.startDate, value: $0.sumQuantity()?.doubleValue(for: .count()) ?? 0)
        //            }
        //        } catch {
        //
        //        }
        
        for try await result in stepsQuery.results(for: store) {
            stepData = result.statisticsCollection.statistics().map{
                HealthMetric(date: $0.startDate, value: $0.sumQuantity()?.doubleValue(for: .count()) ?? 0)
            }
        }
        
        return stepData
    }
    
    func fetchCalories() async throws -> [HealthMetric] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)
        
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.activeEnergyBurned), predicate: queryPredicate)
        
        let caloriesQuery = HKStatisticsCollectionQueryDescriptor(predicate: samplePredicate,
                                                                  options: .cumulativeSum,
                                                                  anchorDate: endDate,
                                                                  intervalComponents: .init(day: 1)
        )
        
        for try await result in caloriesQuery.results(for: store) {
            calorieData = result.statisticsCollection.statistics().map{
                HealthMetric(date: $0.startDate, value: $0.sumQuantity()?.doubleValue(for: .kilocalorie()) ?? 0)
            }
        }
        
        return calorieData
    }
    
}
