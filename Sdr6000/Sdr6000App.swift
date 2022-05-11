//
//  Sdr6000App.swift
//  Sdr6000
//
//  Created by Douglas Adams on 11/16/21.
//

import SwiftUI
import ComposableArchitecture

import SdrViewer
import LogViewer
import Shared

final class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationDidFinishLaunching(_ notification: Notification) {
    // disable tab view
    NSWindow.allowsAutomaticWindowTabbing = false
  }
  
  func applicationWillTerminate(_ notification: Notification) {
    LogProxy.sharedInstance.log("Sdr6000: application terminated", .debug, #function, #file, #line)
  }
  
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    true
  }
}

@main
struct Sdr6000App: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self)
  var appDelegate
  
  var body: some Scene {
    
    WindowGroup(getBundleInfo().appName + " v" + Version().string) {
      SdrView()
        .frame(minWidth: 900, maxWidth: .infinity, minHeight: 450, maxHeight: .infinity)
        .padding(.vertical)
    }
    .windowToolbarStyle(.expanded)
    .handlesExternalEvents(matching: Set(arrayLiteral: "SdrViewer"))
    .commands {
      CommandGroup(after: .windowList) {
        Button(action: { WindowChoice.ProfileView.open() }, label: { Text("Profiles List") })
        Button(action: { WindowChoice.TxView.open() }, label: { Text("Transmit Settings") })
        Button(action: { WindowChoice.Ph1View.open() }, label: { Text("Phone 1 Settings") })
        Button(action: { WindowChoice.Ph2View.open() }, label: { Text("Phone 2 Settings") })
        Button(action: { WindowChoice.CwView.open() }, label: { Text("Cw Settings") })
        Button(action: { WindowChoice.EqView.open() }, label: { Text("Equalizer Settings") })
      }
      //remove the "New" menu item
      CommandGroup(replacing: CommandGroupPlacement.newItem) {}
      ToolbarCommands()
    }

    WindowGroup("Profiles List") {
      ProfileView()
        .frame(width: 275, height: 350)
        .padding()
    }.handlesExternalEvents(matching: Set(arrayLiteral: "ProfileView"))

    WindowGroup("Transmit Settings") {
      TxView()
        .frame(width: 275, height: 230)
    }.handlesExternalEvents(matching: Set(arrayLiteral: "TxView"))
    
    WindowGroup("Phone 1 Settings") {
      Ph1View()
        .frame(width: 275, height: 210)
    }.handlesExternalEvents(matching: Set(arrayLiteral: "Ph1View"))
    
    WindowGroup("Phone 2 Settings") {
      Ph2View()
        .frame(width: 275, height: 160)
    }.handlesExternalEvents(matching: Set(arrayLiteral: "Ph2View"))
    
    WindowGroup("CW Settings") {
      CwView()
        .frame(width: 275, height: 200)
    }.handlesExternalEvents(matching: Set(arrayLiteral: "CwView"))

    WindowGroup("Equalizer Settings") {
      EqView()
        .frame(width: 275, height: 280)
    }.handlesExternalEvents(matching: Set(arrayLiteral: "EqView"))
    
    Settings {
      SettingsView()
    }
  }
}
