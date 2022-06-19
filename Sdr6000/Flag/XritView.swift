//
//  XritView.swift
//  
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI

// ----------------------------------------------------------------------------
// MARK: - View

struct XritView: View {
  
  @State private var ritOffset = 0
  @State private var xitOffset = 0
  @State private var ritOffsetString = "0"
  @State private var xitOffsetString = "0"
  @State private var tuningStep = 0
  @State private var tuningStepString = "0"
  
  let buttonWidth: CGFloat = 25
  //    let smallButtonWidth: CGFloat = 10
  
  var body: some View {
    VStack {
      HStack {
        VStack {
          Button(action: {}) {Text("RIT").frame(width: buttonWidth)}
          HStack(spacing: -10) {
            TextField("offset", text: $ritOffsetString)
//              .modifier(ClearButton(boundText: $ritOffsetString, trailing: false))
            
            Stepper("", value: $ritOffset, in: 0...10000)
          }.multilineTextAlignment(.trailing)
        }
        
        VStack {
          Button(action: {}) {Text("XIT").frame(width: buttonWidth)}
          HStack(spacing: -10)  {
            TextField("offset", text: $xitOffsetString)
//              .modifier(ClearButton(boundText: $xitOffsetString, trailing: false))
            
            Stepper("", value: $xitOffset, in: 0...10000)
          }.multilineTextAlignment(.trailing)
        }
      }
      
      HStack(spacing: 20) {
        Text("Tuning step")
        HStack(spacing: -10) {
          TextField("step", text: $tuningStepString)
//            .modifier(ClearButton(boundText: $tuningStepString, trailing: false))
          Stepper("", value: $tuningStep, in: 0...100000)
        }
      }.multilineTextAlignment(.trailing)
    }
    .frame(width: 275, height: 110)
    .padding(.horizontal)
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct XritView_Previews: PreviewProvider {
    static var previews: some View {
      XritView()
    }
}
