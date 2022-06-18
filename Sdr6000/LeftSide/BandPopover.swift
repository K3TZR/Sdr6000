//
//  SwiftUIView.swift
//  
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI

struct BandPopover: View {
  
  @State var band = "40"
  @State var bands =
  [
    "160", "80", "60", "40", "30",
    "20", "17", "15", "12", "10",
    "6", "4", "", "WWV", "GEN",
    "2200", "6300", "XVTR"
  ]
  
  var body: some View {
    
    let columns = [
      GridItem(.fixed(40)),
      GridItem(.fixed(40)),
      GridItem(.fixed(40))
    ]
    LazyVGrid(columns: columns, spacing: 10) {
      ForEach(bands, id: \.self) { band in
        Button( action: {  })
        { Text(band).frame(width: 40) }
      }
    }
    .frame(width: 170, height: 180)
    .padding(10)
  }
}

struct BandPopover_Previews: PreviewProvider {
    static var previews: some View {
      BandPopover()
    }
}
