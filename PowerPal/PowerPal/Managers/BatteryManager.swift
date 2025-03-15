import Foundation
import Combine

class BatteryManager: ObservableObject {
    @Published var batteryData = BatteryData()
    @Published var chargingLimitEnabled: Bool = true
    @Published var chargingLimit: Double = 80.0
    
    private var batteryMonitor: BatteryMonitor
    private var chargingController: ChargingController
    private var settingsManager: SettingsManager
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.batteryMonitor = BatteryMonitor()
        self.chargingController = ChargingController()
        self.settingsManager = SettingsManager()
        
        loadSettings()
        
        batteryMonitor.$batteryData
            .assign(to: \.batteryData, on: self)
            .store(in: &cancellables)
        
        startMonitoring()
    }
    
    func startMonitoring() {
        batteryMonitor.startMonitoring()
        
        Timer.publish(every: 5.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.checkChargingLimit()
            }
            .store(in: &cancellables)
    }
    
    func checkChargingLimit() {
        if chargingLimitEnabled &&
           batteryData.isCharging &&
           batteryData.percentage >= chargingLimit {
            stopCharging()
        }
    }
    
    func stopCharging() {
        chargingController.stopCharging()
    }
    
    func chargeToFull() {
        chargingController.chargeToFull()
    }
    
    func setChargingLimit(_ limit: Double) {
        chargingLimit = limit
        saveSettings()
    }
    
    private func loadSettings() {
        if let settings = settingsManager.loadSettings() {
            self.chargingLimit = settings.chargingLimit
            self.chargingLimitEnabled = settings.chargingLimitEnabled
        }
    }
    
    private func saveSettings() {
        let settings = Settings(
            chargingLimit: chargingLimit,
            chargingLimitEnabled: chargingLimitEnabled
        )
        settingsManager.saveSettings(settings)
    }
}
