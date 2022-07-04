//
//  LeftSideView.swift
//  
//
//  Created by Douglas Adams on 4/21/22.
//

import SwiftUI
import ComposableArchitecture

import Api6000

struct LeftSideView: View {
  let store: Store<LeftSideState, LeftSideAction>

  public init(store: Store<LeftSideState, LeftSideAction>) {
    self.store = store
  }

  static func == (lhs: LeftSideView, rhs: LeftSideView) -> Bool {
    true
  }
  let width: CGFloat = 40
  @State var daxPopover = false
  @State var antPopover = false
  @State var bandPopover = false
  @State var displayPopover = false
    
  var body: some View {

    WithViewStore(store) { viewStore in
      
      VStack {
        Group {
          Button(action: {}, label: { Text("X") })
          Button(action: {}, label: { Text("+RX").frame(width: width) })
          Button(action: {}, label: { Text("+Tnf").frame(width: width) })

          Button(action: { bandPopover = true }, label: { Text("Band").frame(width: width) })
            .popover(isPresented: $bandPopover, arrowEdge: .trailing) { BandPopover(store: store) }

          Button(action: { antPopover = true }, label: { Text("Ant").frame(width: width) })
            .popover(isPresented: $antPopover, arrowEdge: .trailing) { AntPopover() }

          Button(action: { displayPopover = true }, label: { Text("Disp").frame(width: width) })
            .popover(isPresented: $displayPopover, arrowEdge: .trailing) { DisplayPopover() }

          Button(action: { daxPopover = true }, label: { Text("Dax").frame(width: width) })
            .popover(isPresented: $daxPopover, arrowEdge: .trailing) { DaxPopover() }
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
      .onAppear() {viewStore.send( .onAppear)}
    }
    //    .frame(width: 50)
    //    .padding(.horizontal)
  }
}

//struct LeftSideView_Previews: PreviewProvider {
//  static var previews: some View {
//    LeftSideView(
//      store: Store(
//        initialState: LeftSideState(),
//        reducer: leftSideReducer,
//        environment: LeftSideEnvironment()
//      )
//    )
//  }
//}
