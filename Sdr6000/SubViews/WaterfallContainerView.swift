//
//  WaterfallContainerView.swift
//  
//
//  Created by Douglas Adams on 4/21/22.
//

import SwiftUI

// ----------------------------------------------------------------------------
// MARK: - View

struct WaterfallContainerView: View {
  var body: some View {
    VStack {
      Spacer()
      Text("Waterfall Container View")
      Spacer()
    }.frame(minHeight: 215)

  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct WaterfallContainerView_Previews: PreviewProvider {
  static var previews: some View {
    WaterfallContainerView()
  }
}
