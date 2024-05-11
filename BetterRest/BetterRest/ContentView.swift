//
//  ContentView.swift
//  BetterRest
//
//  Created by Groo on 5/9/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Enter a time to wake up", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hour(s)", value: $sleepAmount, in: 5...12, step: 0.5)
                }
                Section("Daily coffee intake") {
                    Picker("coffee amount", selection: $coffeeAmount, content: {
                        ForEach(0..<11) { cup in
                            Text(cup < 2 ? "\(cup) cup" : "\(cup) cups")
                        }
                    })
                    .labelsHidden()
                }
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button(action: {
                    calculateBedTime()
                }, label: {
                    Text("Calculate")
                })
            }
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Okay") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUpTime - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
