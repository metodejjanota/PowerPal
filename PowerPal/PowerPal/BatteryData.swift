import Foundation

struct BatteryData {
    var percentage: Double = 0.0
    var chargingStatus: String = ""
    var cycleCount: Int = 0
    var temperature: Double = 0.0
    var timeRemaining: String = ""
    var batteryHealth: String = ""
    var isCharging: Bool = false
    var isPowerConnected: Bool = false
}
