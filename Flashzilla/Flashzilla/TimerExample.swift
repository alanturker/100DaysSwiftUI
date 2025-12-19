//
//  TimerExample.swift
//  Flashzilla
//
//  Created by Turker Alan on 19.12.2025.
//

import SwiftUI
import Combine

struct TimerExample: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                counter += 1
            }
    }
    
    func cancelTimer() {
        timer.upstream.connect().cancel()
    }
}

#Preview {
    TimerExample()
}
