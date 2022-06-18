//
//  Sdr6000App.swift
//  Sdr6000
//
//  Created by Douglas Adams on 11/16/21.
//

import SwiftUI
import ComposableArchitecture

import LogView
import Shared

// ----------------------------------------------------------------------------
// MARK: - Private properties

private let kAntennaTitle = "Antenna Selection"
private let kBandTitle = "Band Selection"
private let kDaxTitle = "Dax Selection"
private let kDisplayTitle = "Display Selection"
private let kCwTitle = "Cw Settings"
private let kEqTitle = "Equalizer Settings"
private let kPh1Title = "Phone 1 Settings"
private let kPh2Title = "Phone 2 Settings"
private let kTxTitle = "Transmit Settings"
private let kProfileTitle = "Profiles List"
private let kLogTitle = "Log View"

// ----------------------------------------------------------------------------
// MARK: - AppDelegate

final class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationDidFinishLaunching(_ notification: Notification) {
    // disable tab view
    NSWindow.allowsAutomaticWindowTabbing = false
  }
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    true
  }
}

// ----------------------------------------------------------------------------
// MARK: - Main

@main
struct Sdr6000App: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self)
  var appDelegate

  var body: some Scene {
    
    WindowGroup("Sdr6000  v" + Version().string) {
      SdrView(
        store: Store(
          initialState: SdrState(),
          reducer: sdrReducer,
          environment: SdrEnvironment()
        )
      )
      .frame(minWidth: 900, maxWidth: .infinity, minHeight: 450, maxHeight: .infinity)
      .padding(.vertical)
    }
    .windowToolbarStyle(.expanded)
    .handlesExternalEvents(matching: Set(arrayLiteral: "SdrViewer"))
    .commands {
      CommandMenu("Left Views") {
        Button(action: { WindowChoice.antenna.open(kAntennaTitle) }, label: { Text(kAntennaTitle) }).keyboardShortcut("a", modifiers: [.control, .command])
        Button(action: { WindowChoice.band.open(kBandTitle) }, label: { Text(kBandTitle) }).keyboardShortcut("b", modifiers: [.control, .command])
        Button(action: { WindowChoice.dax.open(kDaxTitle) }, label: { Text(kDaxTitle) }).keyboardShortcut("d", modifiers: [.control, .command])
        Button(action: { WindowChoice.display.open(kDisplayTitle) }, label: { Text(kDisplayTitle) }).keyboardShortcut("s", modifiers: [.control, .command])
      }
      CommandMenu("Right Views") {
        Button(action: { WindowChoice.cw.open(kCwTitle) }, label: { Text(kCwTitle) }).keyboardShortcut("c", modifiers: [.control, .command])
        Button(action: { WindowChoice.eq.open(kEqTitle) }, label: { Text(kEqTitle) }).keyboardShortcut("e", modifiers: [.control, .command])
        Button(action: { WindowChoice.ph1.open(kPh1Title) }, label: { Text(kPh1Title) }).keyboardShortcut("1", modifiers: [.control, .command])
        Button(action: { WindowChoice.ph2.open(kPh2Title) }, label: { Text(kPh2Title) }).keyboardShortcut("2", modifiers: [.control, .command])
        Button(action: { WindowChoice.tx.open(kTxTitle) }, label: { Text(kTxTitle) }).keyboardShortcut("t", modifiers: [.control, .command])
      }
      CommandMenu("Other") {
        Button(action: { WindowChoice.profile.open(kProfileTitle) }, label: { Text(kProfileTitle) }).keyboardShortcut("p", modifiers: [.control, .command])
        Button(action: { WindowChoice.log.open(kLogTitle) }, label: { Text(kLogTitle) }).keyboardShortcut("l", modifiers: [.control, .command])
      }
      //remove the "New" menu item
      CommandGroup(replacing: CommandGroupPlacement.newItem) {}
      ToolbarCommands()
    }

    // ----------------------------------------------------------------------------
    // MARK: - Alternate windows

    Group {
      WindowGroup(kLogTitle) {
        LogView(store: Store(initialState: LogState(), reducer: logReducer, environment: LogEnvironment()))
          .frame(width: 900, height: 450)
      }.handlesExternalEvents(matching: Set(arrayLiteral: WindowChoice.log.rawValue))

      WindowGroup(kProfileTitle) {
        ProfileView()
          .frame(width: 275, height: 350)
          .padding()
      }.handlesExternalEvents(matching: Set(arrayLiteral: WindowChoice.profile.rawValue))
      
      WindowGroup(kTxTitle) {
        TxView()
          .frame(width: 275, height: 230)
      }.handlesExternalEvents(matching: Set(arrayLiteral: WindowChoice.tx.rawValue))
      
      WindowGroup(kPh1Title) {
        Ph1View()
          .frame(width: 275, height: 210)
      }.handlesExternalEvents(matching: Set(arrayLiteral: WindowChoice.ph1.rawValue))
      
      WindowGroup(kPh2Title) {
        Ph2View()
          .frame(width: 275, height: 160)
      }.handlesExternalEvents(matching: Set(arrayLiteral: WindowChoice.ph2.rawValue))
      
      WindowGroup(kCwTitle) {
        CwView()
          .frame(width: 275, height: 200)
      }.handlesExternalEvents(matching: Set(arrayLiteral: WindowChoice.cw.rawValue))
    
      WindowGroup(kEqTitle) {
        EqView()
          .frame(width: 275, height: 280)
      }.handlesExternalEvents(matching: Set(arrayLiteral: WindowChoice.eq.rawValue))
    }

    Group {
      WindowGroup(kAntennaTitle) {
        AntPopover()
          .frame(width: 250, height: 150)
          .padding()
      }.handlesExternalEvents(matching: Set(arrayLiteral: WindowChoice.antenna.rawValue))
      
      WindowGroup(kBandTitle) {
        BandPopover()
          .frame(width: 170, height: 180)
          .padding(10)
      }.handlesExternalEvents(matching: Set(arrayLiteral: WindowChoice.band.rawValue))
      
      WindowGroup(kDaxTitle) {
        DaxPopover()
          .frame(width: 250, height: 75)
          .padding()
      }.handlesExternalEvents(matching: Set(arrayLiteral: WindowChoice.dax.rawValue))
      
      WindowGroup(kDisplayTitle) {
        DisplayPopover()
          .frame(width:260)
          .padding(10)
      }.handlesExternalEvents(matching: Set(arrayLiteral: WindowChoice.display.rawValue))
    }

    // ----------------------------------------------------------------------------
    // MARK: - Settings

    Settings {
      SettingsView()
    }
  }
}

// ----------------------------------------------------------------------------
// MARK: - Helper methods

public enum WindowChoice: String, CaseIterable {
  case antenna
  case band
  case cw
  case dax
  case display
  case eq
  case log
  case ph1
  case ph2
  case profile
  case tx

  public func open(_ title: String) {
    if let url = URL(string: "Sdr6000://\(self.rawValue)") {
      if windowWasOpen(title: title) == false {
        NSWorkspace.shared.open(url)
      }
    }
  }
}

func windowWasOpen(title: String) -> Bool {
  for window in NSApplication.shared.windows where window.title == title {
    window.close()
    return true
  }
  return false
}
