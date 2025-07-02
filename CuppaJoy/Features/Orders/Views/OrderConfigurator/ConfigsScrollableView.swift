//
//  ConfigsScrollableView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 01.07.2025.
//

import SwiftUI

struct ConfigsScrollableView: View {
  
  @EnvironmentObject var configVM: CoffeeConfigViewModel
  @EnvironmentObject var configuratorVM: OrderConfiguratorViewModel
  
  var body: some View {
    HStack {
      Text("My Configs:")
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.white)
      ScrollView(.horizontal) {
        HStack(spacing:10) {
          ForEach(configVM.configs) { config in
            Button {
              configuratorVM.selectedConfig = config
              configuratorVM.applyConfig()
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
                    await configVM.deleteConfig(config)
                  }
                }
              }
            }
          }
        }
      }
      Button {
        configuratorVM.isShownSaveConfigAlert.toggle()
      } label: {
        Image(systemName: "plus.circle")
          .foregroundStyle(.orange)
          .padding(8)
          .background(.csDarkGrey)
          .clipShape(.circle)
          .shadow(radius:3)
      }
    }.padding(.horizontal,20)
  }
}
