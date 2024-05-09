//
//  ContentView.swift
//  BetterRest
//
//  Created by Groo on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Date.now
    var body: some View {
        VStack {
            Text(Date.now, format: .dateTime.year().month().day().hour().minute())
            Text(Date.now.formatted(date: .complete, time: .standard))
        }
        .padding()
    }
    func dataExamples() {
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? .now
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        
    }
}

#Preview {
    ContentView()
}
