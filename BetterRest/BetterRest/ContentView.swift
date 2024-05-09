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
            DatePicker("Wake up time", selection: $wakeUpTime, in: Date.now..., displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
        .padding()
    }
    func dataExamples() {
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tomorrow
    }
}

#Preview {
    ContentView()
}
