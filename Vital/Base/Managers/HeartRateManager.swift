//
//  HeartRateManager.swift
//  Vital
//
//  Created by Tyler Rhodes on 6/11/24.
//

import SwiftUI
import AVFoundation

class HeartRateMonitor: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    @Published var heartRate: Int = 0
    private let captureSession = AVCaptureSession()
    
    private var frameCount: Int = 0
    private var lastProcessedFrameTime: TimeInterval = 0
    private var bpmValues: [Int] = []
    
    override init() {
        super.init()
        setupCamera()
    }
    
    private func setupCamera() {
        guard let camera = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            captureSession.addInput(input)
            
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            captureSession.addOutput(dataOutput)
        } catch {
            print("Error setting up camera input: \(error)")
        }
    }
    
    func startSession() {
        captureSession.startRunning()
    }
    
    func stopSession() {
        captureSession.stopRunning()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Here you can analyze the image data to estimate heart rate
        processBuffer(sampleBuffer)
        
    }
    
    func processBuffer(_ sampleBuffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let currentTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer).seconds
        
        // Only process one frame per second as an example rate
        guard currentTime - lastProcessedFrameTime >= 1 else { return }
        lastProcessedFrameTime = currentTime
        
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let buffer = baseAddress?.assumingMemoryBound(to: UInt8.self)
        
        var greenMean: Double = 0
        let rowCount = height / 10
        let columnCount = width / 10
        
        for row in 0..<rowCount {
            for column in 0..<columnCount {
                let pixelOffset = row * bytesPerRow * 10 + column * 4 * 10
                let greenOffset = pixelOffset + 1 // Green channel
                greenMean += Double(buffer![greenOffset])
            }
        }
        
        greenMean /= Double(rowCount * columnCount)
        analyzeGreenChannelValue(greenMean)
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
    }
    
    private func analyzeGreenChannelValue(_ value: Double) {
        // Algorithm to analyze green values over time to calculate BPM
        // Placeholder: you would add your algorithm here
        // Update `bpmValues` and calculate a moving average
        bpmValues.append(Int(value)) // Simplified example
        if bpmValues.count > 10 {
            bpmValues.removeFirst()
            let averageBpm = bpmValues.reduce(0, +) / bpmValues.count
            DispatchQueue.main.async {
                self.heartRate = averageBpm // Update heart rate display
            }
        }
    }
    
}

