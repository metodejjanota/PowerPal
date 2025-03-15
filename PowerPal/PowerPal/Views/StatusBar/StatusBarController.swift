import SwiftUI
import AppKit

class StatusBarController {
    private var statusItem: NSStatusItem?
    private var popover: NSPopover?
    private var batteryManager: BatteryManager
    
    init(batteryManager: BatteryManager) {
        self.batteryManager = batteryManager
        setupStatusBar()
        setupObservers()
    }
    
    private func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "battery.75", accessibilityDescription: "BateryPal")
            button.action = #selector(togglePopover)
            button.target = self
        }
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateMenuBar),
            name: NSNotification.Name("BatteryDataUpdated"),
            object: nil
        )
    }
    
    @objc private func togglePopover() {
        if let popover = popover, popover.isShown {
            popover.close()
            return
        }
        
        showPopover()
    }
    
    private func showPopover() {
        popover = NSPopover()
        popover?.contentSize = NSSize(width: 300, height: 400)
        popover?.behavior = .transient
        popover?.contentViewController = NSHostingController(rootView: PopoverView(batteryManager: batteryManager))
        
        if let button = statusItem?.button, let popover = popover {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }
    
    @objc func updateMenuBar() {
        if let button = statusItem?.button {
            let batteryLevel = Int(batteryManager.batteryData.percentage)
            let imageName = batteryManager.batteryData.isCharging ? "battery.75.bolt" : "battery.75"
            button.image = NSImage(systemSymbolName: imageName, accessibilityDescription: "PowerPal \(batteryLevel)%")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
