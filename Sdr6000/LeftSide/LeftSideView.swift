//
//  LeftSideView.swift
//  
//
//  Created by Douglas Adams on 4/21/22.
//

import SwiftUI

struct LeftSideView: View {
  
  let width: CGFloat = 40
  @State var daxPopover = false
  @State var antPopover = false
  @State var bandPopover = false
  @State var displayPopover = false
    
  var body: some View {
    VStack {
      Group {
        Button(action: {}, label: { Text("X") })
        Button(action: {}, label: { Text("+RX").frame(width: width) })
        Button(action: {}, label: { Text("+Tnf").frame(width: width) })
        Button(action: { bandPopover = true }, label: { Text("Band").frame(width: width) })
          .popover(isPresented: $bandPopover, arrowEdge: .trailing) {
            BandPopover() }
        
        Button(action: { antPopover = true }, label: { Text("Ant").frame(width: width) })
          .popover(isPresented: $antPopover, arrowEdge: .trailing) {
            AntPopover() }
        Button(action: { displayPopover = true }, label: { Text("Disp").frame(width: width) })
          .popover(isPresented: $displayPopover, arrowEdge: .trailing) {
            DisplayPopover() }
        Button(action: { daxPopover = true }, label: { Text("Dax").frame(width: width) })
          .popover(isPresented: $daxPopover, arrowEdge: .trailing) {
            DaxPopover() }
      }
      
      HStack {
        Button("S") {}
        Button("B") {}
      }
      HStack {
        Button("+") {}
        Button("-") {}
      }
    }
    
    //    .popover(item: $popoverParams, attachmentAnchor: popoverParams!.anchor, arrowEdge: .trailing) { _ in AntPopover() }
    
    
  }
}

struct LeftSideView_Previews: PreviewProvider {
  static var previews: some View {
    LeftSideView()
  }
}

//struct AntPopover: View {
//  
//  @State var rxAntennas = ["Ant1", "Ant2", ]
//  @State var selectedRxAntenna = "Ant1"
//  @State var rfGain: CGFloat = 25.0
//  
//  var body: some View {
//    VStack(alignment: .leading, spacing: 20) {
//      HStack {
//        Text("RX Ant")
//        Picker("", selection: $selectedRxAntenna) {
//          ForEach(rxAntennas, id: \.self) {
//            Text($0)
//          }
//        }
//        .pickerStyle(.menu)
//        .frame(width: 100)
//      }
//      Button("Loop A") {}
//      HStack(spacing: 10) {
//        Text("RF Gain")
//        Slider(value: $rfGain, in: 0...100).frame(width: 100)
//        Text("\(String(format: "%.0f", rfGain))").frame(width: 50)
//      }
//    }
//    .padding()
//    .frame(width: 250, height: 150)
//  }
//}

//struct DaxPopover: View {
//  
//  @State var daxIqChannel = ""
//  
//  var body: some View {
//    HStack {
//      Text("Dax IQ Channel")
//      TextField("", text: $daxIqChannel)
//    }
//    .padding()
//    .frame(width: 250, height: 75)
//  }
//}


//struct BandPopover: View {
//  
//  @State var band = "40"
//  @State var bands =
//  [
//    "160", "80", "60", "40", "30",
//    "20", "17", "15", "12", "10",
//    "6", "4", "", "WWV", "GEN",
//    "2200", "6300", "XVTR"
//  ]
//  
//  var body: some View {
//    
//    let columns = [
//      GridItem(.fixed(40)),
//      GridItem(.fixed(40)),
//      GridItem(.fixed(40))
//    ]
//    LazyVGrid(columns: columns, spacing: 10) {
//      ForEach(bands, id: \.self) { band in
//        Button( action: {  })
//        { Text(band).frame(width: 40) }
//      }
//    }
//    .padding(10)
//    .frame(width: 170, height: 180)
//  }
//}
