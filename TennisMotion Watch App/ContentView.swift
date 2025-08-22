import SwiftUI
import CoreMotion

// Motion Manager
let MotionManager = CMMotionManager()

struct ContentView: View {
    // State variables to store sensor data
    @State private var acc: [Float64] = [0.0, 0.0, 0.0]
    @State private var gyro: [Float64] = [0.0, 0.0, 0.0]
    
    
    // Body
    var body: some View {
        VStack {
            Text("Accelerometer data:")
            
            // Display accelerometer data
            Text("X: \(acc[0]), Y: \(acc[1]), Z: \(acc[2])")
                .padding()
            Text("Gyro data:")
            
            // Display accelerometer data
            Text("X: \(gyro[0]), Y: \(gyro[1]), Z: \(gyro[2])")
                .padding()
        }
        .onAppear {
            // Start accelerometer data collection when the view appears
            startAccUpdates()
            startGyroUpdates()
        }
    }
    
    // Function to get accelerometer data and update the state variable
    func startAccUpdates() {
        // Check if the accelerometer is available
        if MotionManager.isAccelerometerAvailable {
            // Set the update interval (0.1s,10 Hz)
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
    
    // Function to start gyroscope updates
    func startGyroUpdates() {
        
        // Check if available
        if MotionManager.isGyroAvailable {
            
            // Set update interval (0.1s,10Hz)
            MotionManager.gyroUpdateInterval = 0.1
            
            // Start getting data (async)
            MotionManager.startGyroUpdates(to:OperationQueue.current!) { (data, error) in
                
                // If error exists
                if let error = error {
                    print("Error getting gyro data \(error.localizedDescription)")
                }
                
                // If there is data, update data
                if let data = data {
                    let x = data.rotationRate.x
                    let y = data.rotationRate.y
                    let z = data.rotationRate.z

                    // Update the state variable with the new data
                    DispatchQueue.main.async {
                        self.gyro = [x, y, z]
                    }
                }
            }
        } else {
            print("Gyro data not available")
        }
    }
    
    // Func for rounding float to a certain dp
    func dpRound(num:Float64,prc:Int) -> Float64 {
        
        // Rounding and returning
        var scaleF: Float64 = pow(Double(10),Double(prc))
        let roundNum = (num * scaleF).rounded() / scaleF
        return roundNum
        
    }
    
}

#Preview {
    ContentView()
}
