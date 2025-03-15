import Foundation
import SwiftUI

extension NSNotification.Name {
    static let batteryDataUpdated = NSNotification.Name("BatteryDataUpdated")
}

extension Color {
    static let batteryGreen = Color(red: 0.3, green: 0.8, blue: 0.4)
    static let batteryYellow = Color(red: 0.9, green: 0.8, blue: 0.3)
    static let batteryRed = Color(red: 0.9, green: 0.3, blue: 0.3)
    
    static func forBatteryPercentage(_ percentage: Double) -> Color {
        if percentage > 50 {
            return batteryGreen
        } else if percentage > 20 {
            return batteryYellow
        } else {
            return batteryRed
        }
    }
}

extension Double {
    func formattedAsPercentage() -> String {
        return "\(Int(self))%"
    }
    
    func formattedTemperature() -> String {
        return String(format: "%.1f°C", self)
    }
}

extension View {
    func standardPadding() -> some View {
        self.padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
    }
    
    func batteryCardStyle() -> some View {
        self
            .padding()
            .background(Color(.windowBackgroundColor))
            .cornerRadius(8)
            .shadow(radius: 1)
    }
}

extension Date {
    func timeIntervalFormatted() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .short
        return formatter.string(from: self.timeIntervalSinceNow) ?? "Neznámý čas"
    }
}
