//
//  ProfileView.swift
//  
//
//  Created by Douglas Adams on 5/9/22.
//

import SwiftUI

public enum ProfileType: String {
  case global = "Global"
  case microphone = "Microphone"
  case transmit = "Transmit"
}

// ----------------------------------------------------------------------------
// MARK: - Views

public struct ProfileView: View {
  @State private var selectedTab: ProfileType = .global
  @State private var newProfileName: String = ""
  
  public init() {}
  
  public var body: some View {
    
    VStack {
      TabView(selection: $selectedTab) {
        GlobalView()
          .tabItem {Text("Global")}
          .tag(ProfileType.global)
        TransmitView()
          .tabItem {Text("Transmit")}
          .tag(ProfileType.transmit)
        MicrophoneView()
          .tabItem {Text("Microphone")}
          .tag(ProfileType.microphone)
      }
      
      HStack {
        Button("Load") {}
        Button("Create") {}
        Button("Reset") {}
        Button("Delete") {}
      }
      
      TextField("New Profile name", text: $newProfileName)
    }
  }
}

struct GlobalView: View {
  
  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading) {
        ForEach(1...100, id: \.self) {
          Text("Global profile \($0)")
        }
      }
    }
  }
}

struct TransmitView: View {
  
  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading) {
        ForEach(1...100, id: \.self) {
          Text("Transmit profile \($0)")
        }
      }
    }
  }
}

struct MicrophoneView: View {
  
  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading) {
        ForEach(1...100, id: \.self) {
          Text("Microphone profile \($0)")
        }
      }
    }
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
      .frame(width: 275, height: 350)
      .padding()
  }
}
