//
//  ContentView.swift
//  TennisMotion Watch App
//
//  Created by Prasanth Kothuri on 19.08.25.
//

import SwiftUI

// Accelerometer data
let acc = ["1","2","3"]

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Accelerometer data:")
            Text(acc.joined(separator:" "))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
