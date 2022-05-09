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
//import RemoteViewer
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
      CommandGroup(after: .appSettings) {
       Button(action: {
         WindowChoice.ProfileViewer.open()
       }, label: {
         Text("Profiles")
       })
     }
    }

    
    WindowGroup("Profiles") {
      ProfileView()
      .frame(width: 275, height: 350)
      .padding()
    }.handlesExternalEvents(matching: Set(arrayLiteral: "ProfileViewer"))

    
    WindowGroup(getBundleInfo().appName + " (Log Viewer) v" + Version().string) {
      LogView(store: Store(
        initialState: LogState(),
        reducer: logReducer,
        environment: LogEnvironment() )
      )
      .toolbar {
        Button("Close") { NSApplication.shared.keyWindow?.close()  }
      }
      .frame(minWidth: 975, minHeight: 400)
      .padding()
    }.handlesExternalEvents(matching: Set(arrayLiteral: "LogViewer"))
    
//    WindowGroup(getBundleInfo().appName + " (Remote Viewer) v" + Version().string) {
//      RemoteView(store: Store(
//        initialState: RemoteState( "Relay Status" ),
//        reducer: remoteReducer,
//        environment: RemoteEnvironment() )
//      )
//      .toolbar {
//        Button("Close") { NSApplication.shared.keyWindow?.close()  }
//      }
//
//      .frame(minWidth: 975, minHeight: 400)
//      .padding()
//    }.handlesExternalEvents(matching: Set(arrayLiteral: "RemoteViewer"))

    
    .commands {
      //remove the "New" menu item
      CommandGroup(replacing: CommandGroupPlacement.newItem) {}
      ToolbarCommands()
      SidebarCommands()
    }
    Settings {
        SettingsView()
    }

  }
}

enum OpenWindows: String, CaseIterable {
  case LogViewer = "LogViewer"
  case RemoteViewer = "RemoteViewer"
  
  func open() {
    if let url = URL(string: "Sdr6000://\(self.rawValue)") {
      NSWorkspace.shared.open(url)
    }
  }
}
