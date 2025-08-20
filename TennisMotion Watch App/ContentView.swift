import SwiftUI
import CoreMotion

// Motion Manager
let MotionManager = CMMotionManager()

struct ContentView: View {
    // State variable to store the accelerometer data
    @State private var acc: [Float64] = [0.0, 0.0, 0.0]
    
    // Body
    var body: some View {
        VStack {
            Text("Accelerometer data:")
            
            // Display accelerometer data
            Text("X: \(acc[0]), Y: \(acc[1]), Z: \(acc[2])")
                .padding()
        }
        .onAppear {
            // Start accelerometer data collection when the view appears
            startAccelerometerUpdates()
        }
    }
    
    // Function to get accelerometer data and update the state variable
    func startAccelerometerUpdates() {
        // Check if the accelerometer is available
        if MotionManager.isAccelerometerAvailable {
            // Set the update interval (0.1 Hz)
            MotionManager.accelerometerUpdateInterval = 0.1

            // Start receiving accelerometer updates asynchronously
            MotionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let error = error {
                    print("Error getting accelerometer data: \(error.localizedDescription)")
                    return
                }

                // If data is available, update the accelerometer data
                if let data = data {
                    // Get the accelerometer values (x, y, z)
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z

                    // Update the state variable with the new data
                    DispatchQueue.main.async {
                        self.acc = [x, y, z]
                    }
                }
            }
        } else {
            print("Accelerometer data not available")
        }
    }
}

#Preview {
    ContentView()
}
