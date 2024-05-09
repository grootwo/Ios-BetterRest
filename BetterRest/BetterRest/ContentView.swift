//
//  ContentView.swift
//  BetterRest
//
//  Created by Groo on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 3...12, step: 0.5)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
