//
//  PanadapterContainerView.swift
//  
//
//  Created by Douglas Adams on 4/21/22.
//

import SwiftUI

// ----------------------------------------------------------------------------
// MARK: - View

struct PanadapterContainerView: View {
  var body: some View {
    VStack {
      Spacer()
      Text("Panadapter Container View")
      Spacer()
    }.frame(minHeight: 215)
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct PanadapterContainerView_Previews: PreviewProvider {
  static var previews: some View {
    PanadapterContainerView()
  }
}
