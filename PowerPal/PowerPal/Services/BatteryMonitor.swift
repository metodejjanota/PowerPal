import Foundation
import IOKit.ps
import Combine

class BatteryMonitor: ObservableObject {
    @Published var batteryData = BatteryData()
    private var timer: Timer?
    
    func startMonitoring() {
        
        updateBatteryInfo()
        
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.updateBatteryInfo()
        }
    }
    
    func updateBatteryInfo() {
        var newData = BatteryData()
        newData.percentage = Double.random(in: 75...85)
        newData.isCharging = Bool.random()
        newData.isPowerConnected = newData.isCharging || Bool.random()
        newData.cycleCount = 132
        newData.temperature = 35.6
        newData.timeRemaining = newData.isCharging ? "01:45 to full charge" : "04:30 remaining"
        newData.batteryHealth = "Good condition (95%)"
        newData.chargingStatus = newData.isCharging ? "Charging" : "Discharging"
        
        DispatchQueue.main.async {
            self.batteryData = newData
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
