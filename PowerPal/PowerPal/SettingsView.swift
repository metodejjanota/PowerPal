import SwiftUI

struct SettingsView: View {
    @ObservedObject var batteryManager: BatteryManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Settings")
                .font(.title)
                .padding(.top)
            
            Form {
                Section(header: Text("Charging")) {
                    Toggle("Limit charging", isOn: $batteryManager.chargingLimitEnabled)
                    
                    HStack {
                        Text("Charging limit: \(Int(batteryManager.chargingLimit))%")
                        Spacer()
                        Slider(value: $batteryManager.chargingLimit, in: 50...95, step: 5)
                            .frame(width: 150)
                    }
                }
                
                Section(header: Text("Notifications")) {
                    Toggle("Show notification when limit is reached", isOn: .constant(true))
                    Toggle("Notification when fully charged", isOn: .constant(true))
                }
                
                Section(header: Text("Appearance")) {
                    Picker("Icon style", selection: .constant(0)) {
                        Text("Graphic").tag(0)
                        Text("Numeric").tag(1)
                        Text("Combined").tag(2)
                    }
                }
                
                Section(header: Text("App")) {
                    Toggle("Launch at system startup", isOn: Binding<Bool>(
                        get: { AutoLaunchManager.shared.isAutoLaunchEnabled },
                        set: { AutoLaunchManager.shared.isAutoLaunchEnabled = $0 }
                    ))
                }
            }
            
            Button("Done") {
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .frame(width: 400, height: 400)
    }
}
