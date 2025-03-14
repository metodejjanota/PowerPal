import SwiftUI

struct PopoverView: View {
    @ObservedObject var batteryManager: BatteryManager
    @State private var showSettings = false
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("BatteryPal")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Button(action: {
                    showSettings.toggle()
                }) {
                    Image(systemName: "gear")
                }
            }
            .padding(.bottom, 8)
            
            Divider()
            
            Group {
                InfoRow(title: "Battery status:", value: "\(Int(batteryManager.batteryData.percentage))%")
                InfoRow(title: "Status:", value: batteryManager.batteryData.chargingStatus)
                InfoRow(title: "Time remaining:", value: batteryManager.batteryData.timeRemaining)
                InfoRow(title: "Cycle count:", value: "\(batteryManager.batteryData.cycleCount)")
                InfoRow(title: "Temperature:", value: "\(String(format: "%.1f", batteryManager.batteryData.temperature))°C")
                InfoRow(title: "Battery health:", value: batteryManager.batteryData.batteryHealth)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Toggle("Limit charging to \(Int(batteryManager.chargingLimit))%", isOn: $batteryManager.chargingLimitEnabled)
                
                Slider(value: $batteryManager.chargingLimit, in: 50...95, step: 5)
                    .disabled(!batteryManager.chargingLimitEnabled)
            }
            
            Divider()
            
            Button(action: {
                batteryManager.chargeToFull()
            }) {
                Text("Charge to 100%")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
            Spacer()
        }
        .padding()
        .frame(width: 300)
        .sheet(isPresented: $showSettings) {
            SettingsView(batteryManager: batteryManager)
        }
    }
}
