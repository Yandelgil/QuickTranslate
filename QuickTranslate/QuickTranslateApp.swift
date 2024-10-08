//
//  QuickTranslateApp.swift
//  Translate
//
//  Created by Yandel Gil on 10/1/24.
//

import Cocoa
import SwiftUI

@main
struct BarTranslateApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    // Rendering a WindowGroup enables macOS default keyboard shortcuts (e.g. copy/paste) on macOS versions <= Monterey.
    // The WindowGroup serves no other purpose, and is thus automatically closed on startup (see 'applicationDidFinishLaunching').
    WindowGroup {
      EmptyView()
    }.commands {
      // Although the empty window group is closed on startup, the user could still force it to open using the shortcut '⌘ + N'.
      // This shouldn't be possible, thus that keyboard shortcut is disabled here.
      CommandGroup(replacing: CommandGroupPlacement.newItem) {}
    }
    Settings {
      SettingsView()
    }
  }
}

class AppDelegate: NSObject, NSApplicationDelegate {
  static private(set) var instance: AppDelegate!
  
  var popover: NSPopover!
  var statusBarItem: NSStatusItem!
  
  @AppStorage("translationProvider") private var translationProvider: TranslationProvider = DefaultSettings.translationProvider
  @AppStorage("menuBarIcon") private var menuBarIcon: MenuBarIcon = DefaultSettings.menuBarIcon
  
  override init() {
    super.init()
    UserDefaults.standard.addObserver(self, forKeyPath: "showHideKey", options: .new, context: nil)
    UserDefaults.standard.addObserver(self, forKeyPath: "showHideModifier", options: .new, context: nil)
    UserDefaults.standard.addObserver(self, forKeyPath: "menuBarIcon", options: .new, context: nil)
  }
  
  deinit {
    UserDefaults.standard.removeObserver(self, forKeyPath: "showHideKey")
    UserDefaults.standard.removeObserver(self, forKeyPath: "showHideModifier")
    UserDefaults.standard.removeObserver(self, forKeyPath: "menuBarIcon")
  }
  
  
  func updateMenuBarIcon() {
    if let button = self.statusBarItem.button {
      button.image = NSImage(named: menuBarIcon.id)
    }
  }
  
  func applicationDidFinishLaunching(_ notification: Notification) {
    
    // Immediately close the main (empty) app window defined in 'BarTranslateApp'.
    if let window = NSApplication.shared.windows.first {
      window.close()
    }
    
    let contentView = ContentView()
    
    // Application Bubble
    let popover = NSPopover()
    popover.contentSize = NSSize(width: Constants.AppSize.width, height: Constants.AppSize.height)
    popover.behavior = .transient
    popover.contentViewController = NSHostingController(rootView: contentView)
    self.popover = popover
    
    // Setup status bar item
    self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
    if let button = self.statusBarItem.button {
      button.image = NSImage(named: menuBarIcon.id)
      button.action = #selector(togglePopover(_:))
    }
    
  }
  
  // Show or hide BarTranslate
  @objc func togglePopover(_ sender: AnyObject?) {
    if let button = self.statusBarItem.button {
      if self.popover.isShown {
        self.popover.performClose(sender)
      } else {
        self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
      }
    }
  }
  
}

