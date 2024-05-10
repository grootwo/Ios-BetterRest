//
//  ContentView.swift
//  BetterRest
//
//  Created by Groo on 5/9/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker("Enter a time to wake up", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper("\(sleepAmount.formatted()) hour(s)", value: $sleepAmount, in: 5...12, step: 0.5)
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper("\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 0...10)
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button(action: {
                    calculateBedTime()
                }, label: {
                    Text("Calculate")
                })
            }
            .padding()
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
