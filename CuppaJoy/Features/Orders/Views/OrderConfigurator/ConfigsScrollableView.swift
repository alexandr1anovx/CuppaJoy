//
//  ConfigsScrollableView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 01.07.2025.
//

import SwiftUI

struct ConfigsScrollableView: View {
  
  @Environment(CoffeeConfigViewModel.self) var coffeeConfigViewModel
  @Environment(OrderConfiguratorViewModel.self) var orderConfigViewModel
  
  var body: some View {
    HStack {
      Text("My Configs:")
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.white)
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          ForEach(coffeeConfigViewModel.configs) { config in
            Button {
              orderConfigViewModel.selectedConfig = config
              orderConfigViewModel.applyConfig()
            } label: {
              ButtonLabelShort(
                config.title,
                textColor: .orange,
                bgColor: .csDarkGrey
              )
            }
            .contextMenu {
              Group {
                Button("Delete Config", systemImage: "trash") {
                  Task {
                    await coffeeConfigViewModel.deleteConfig(config)
                  }
                }
              }
            }
          }
        }
      }
      Button {
        orderConfigViewModel.showSaveConfigAlert.toggle()
      } label: {
        Image(systemName: "plus.circle")
          .foregroundStyle(.orange)
          .padding(8)
          .background(.csDarkGrey)
          .clipShape(.circle)
          .shadow(radius: 3)
      }
    }.padding(.horizontal, 20)
  }
}
