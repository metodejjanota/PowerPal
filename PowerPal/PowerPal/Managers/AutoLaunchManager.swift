import Foundation
import ServiceManagement

class AutoLaunchManager {
    static let shared = AutoLaunchManager()
    
    private init() {}
    
    var isAutoLaunchEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isAutoLaunchEnabled")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isAutoLaunchEnabled")
            setLaunchAtLogin(enabled: newValue)
        }
    }
    
    private func setLaunchAtLogin(enabled: Bool) {
        do {
            if enabled {
                try SMAppService.mainApp.register()
            } else {
                try SMAppService.mainApp.unregister()
            }
        } catch {
            print("Failed to set auto-launch: \(error)")
        }
    }
    
    func checkCurrentStatus() {
        let status = SMAppService.mainApp.status
        switch status {
        case .enabled:
            UserDefaults.standard.set(true, forKey: "isAutoLaunchEnabled")
        case .notRegistered:
            UserDefaults.standard.set(false, forKey: "isAutoLaunchEnabled")
        default:
            break
        }
    }
}
