import SwiftUI
import SwiftData


@main
struct PowerPalApp: App {
    @StateObject private var batteryManager = BatteryManager()
    @State private var statusBarController: StatusBarController?
    
    init() {
        
    }
    
    var body: some Scene {
        
        MenuBarExtra {
        
            PopoverView(batteryManager: batteryManager)
        } label: {
        
            Image(systemName: "battery.75")
        }
        .menuBarExtraStyle(.window)
        
        
        WindowGroup {
            EmptyView()
                .frame(width: 0, height: 0)
                .opacity(0)
                .onAppear {
                    statusBarController = StatusBarController(batteryManager: batteryManager)
                }
        }
        .defaultSize(width: 0, height: 0)
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}
