//
//  ContentView.swift
//  BetterRest
//
//  Created by Groo on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
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
                    calculate()
                }, label: {
                    Text("Calculate")
                })
            }
            .padding()
        }
    }
    
    func calculate() {
        
    }
}

#Preview {
    ContentView()
}
