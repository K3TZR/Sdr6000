//
//  DaxView.swift
//  
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI

// ----------------------------------------------------------------------------
// MARK: - View

struct DaxView: View {
  
  @State private var selectedChannel = "none"
  @State private var channel = [
    "none",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8"
  ]
  
  var body: some View {
    HStack {
      Picker("DAX Channel", selection: $selectedChannel) {
        ForEach(channel, id: \.self) {
          Text($0)
        }
      }.frame(width: 200)
    }
    .frame(width: 275, height: 110)
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct DaxView_Previews: PreviewProvider {
  static var previews: some View {
    DaxView()
  }
}
