//
//  SwiftUIView.swift
//  
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI

struct DaxPopover: View {
  
  @State var daxIqChannel = ""
  
  var body: some View {
    HStack {
      Text("Dax IQ Channel")
      TextField("", text: $daxIqChannel)
    }
    .frame(width: 250, height: 75)
    .padding()
  }
}

struct DaxPopover_Previews: PreviewProvider {
    static var previews: some View {
      DaxPopover()
    }
}
