import SwiftUI
import CoreMotion

// Motion Manager
let MotionManager = CMMotionManager()

struct ContentView: View {
    // State variables to store sensor data
    @State private var acc: [[Float64]] = [[0.0, 0.0, 0.0]]
    @State private var gyro: [[Float64]] = [[0.0, 0.0, 0.0]]
    
    
    // Body
    var body: some View {
        VStack {
            Button("Get data") {
                
                // Printing timestamp, acc and gyro data
                print(acc)
                print(gyro)
                print(Date().timeIntervalSince1970)
            }
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
                        
                        // Adding acceleration to array, removing first item if array exceeds 10 items
                        self.acc.append([x,y,z])
                        if self.acc.count == 11 {
                            self.acc.remove(at:0)
                        }
                        
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
                        
                        // Adding gyro reading to array, removing first item if array exceeds 10 items
                        self.gyro.append([x,y,z])
                        if self.gyro.count == 11 {
                            self.gyro.remove(at:0)
                        }
                        
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
        let scaleF: Float64 = pow(Double(10),Double(prc))
        let roundNum = (num * scaleF).rounded() / scaleF
        return roundNum
        
    }
    
}

#Preview {
    ContentView()
}
