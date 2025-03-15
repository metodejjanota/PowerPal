import Foundation

class SettingsManager {
    private let settingsKey = "PowerPalSettings"
    
    func saveSettings(_ settings: Settings) {
        if let encoded = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encoded, forKey: settingsKey)
        }
    }
    
    func loadSettings() -> Settings? {
        if let savedSettings = UserDefaults.standard.object(forKey: settingsKey) as? Data,
           let decodedSettings = try? JSONDecoder().decode(Settings.self, from: savedSettings) {
            return decodedSettings
        }
        return Settings.defaultSettings
    }
}
