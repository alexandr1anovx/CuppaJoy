//
//  CoffeeOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct OrderConfiguratorScreen: View {
  
  let selectedCoffee: Coffee
  @Binding var path: NavigationPath
  @Binding var isTabBarVisible: Bool
  @State private var cupCount: Int = 1
  @State private var sugarSticks: Int = 0
  @State private var iceCubes: Int = 0
  @State private var cupSize: CupSize = .small
  @State private var variety: Variety = .standart
  @State private var milk: Milk = .none
  @State private var flavor: Flavor = .none
  @State private var isShownSaveConfigAlert = false
  @State private var configName: String = ""
  
  @EnvironmentObject var configViewModel: CoffeeConfigViewModel
  @State private var selectedConfiguration: CoffeeConfig?
  
  var totalPrice: Double {
    let basePrice = selectedCoffee.price
    let configurations = cupSize.price + milk.price + flavor.price
    let total = (basePrice + configurations) * Double(cupCount)
    return total
  }
  
  var order: Order {
    Order(
      id: UUID().uuidString,
      coffee: selectedCoffee.title,
      cupSize: cupSize.title,
      cupCount: cupCount,
      sugarSticks: sugarSticks,
      iceCubes: iceCubes,
      variety: variety.title,
      milk: milk.title,
      flavor: flavor.title,
      timestamp: .now,
      points: selectedCoffee.points,
      totalPrice: totalPrice
    )
  }
  
  var config: CoffeeConfig {
    CoffeeConfig(
      title: configName,
      cupSize: cupSize,
      sugarSticks: sugarSticks,
      iceCubes: iceCubes,
      variety: variety,
      milk: milk,
      flavor: flavor
    )
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack {
        if configViewModel.favoriteConfigs.isEmpty {
          emptyConfigsView
        } else {
          configsView
        }
        
        
        
        List {
          Section("Cup Configurations") {
            OrderItemPicker("Size", selectedItem: $cupSize)
              .pickerStyle(.segmented)
            OrderItemCounter("Count:", min: 1, max: 4, count: $cupCount)
          }
          Section("Additives") {
            OrderItemCounter("Sugar sticks:", min: 0, max: 2, count: $sugarSticks)
            OrderItemCounter("Ice cubes:", min: 0, max: 2, count: $iceCubes)
            OrderItemPicker("Variety:", selectedItem: $variety)
            OrderItemPicker("Milk:", selectedItem: $milk)
            OrderItemPicker("Flavor:", selectedItem: $flavor)
          }
        }
        .customListStyle(rowSpacing: 15, shadowRadius: 3)
        .listSectionSpacing(8)
        
        totalAmountLabel
      }.padding(.top)
    }
    .navigationTitle("Order Configurator")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .alert("Save Config", isPresented: $isShownSaveConfigAlert) {
      TextField("Config name", text: $configName)
      Button("Cancel", role: .cancel) { configName = "" }
      Button("Save") {
        configViewModel.saveFavoriteConfig(config)
        print("Config saved!")
        print(configViewModel.favoriteConfigs)
      }
    } message: {
      Text("Enter the name of your config.")
    }
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button {
          path.removeLast()
          isTabBarVisible = true
        } label: {
          ReturnButtonLabel()
        }
      }
      ToolbarItem(placement: .topBarTrailing) {
        Button("Save") {
          isShownSaveConfigAlert.toggle()
        }
      }
    }
    .onAppear {
      isTabBarVisible = false
      setupSegmentedControlAppearance()
    }
  }
  
  private var emptyConfigsView: some View {
    Text("You don't have any saved configs.")
      .underline()
      .font(.caption)
      .foregroundStyle(.gray)
      .padding()
      .background(.csDarkGrey)
      .clipShape(.capsule)
  }
  
  private var configsView: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        Text("Configs:")
          .font(.subheadline)
          .foregroundStyle(.gray)
        ForEach(configViewModel.favoriteConfigs) { config in
          Button {
            selectedConfiguration = config
            applyConfig()
          } label: {
            ButtonLabelShort(
              config.title,
              textColor: .orange,
              bgColor: .csDarkGrey
            )
          }
        }
      }
    }.padding(.horizontal,28)
  }
  
  private var totalAmountLabel: some View {
    VStack(spacing: 20) {
      HStack(spacing: 0) {
        Text("Total Amount:")
          .font(.subheadline)
          .fontWeight(.bold)
          .foregroundStyle(.white)
        Text(order.stringPrice)
          .font(.system(size: 17))
          .fontWeight(.bold)
          .foregroundStyle(.csCream)
          .contentTransition(.numericText())
          .animation(.bouncy, value: totalPrice)
          .frame(minWidth: 75)
      }
      
      Button {
        path.append(OrderPage.summary(order))
      } label: {
        ButtonLabelAnimated(
          "Summorize",
          textColor: .white,
          bgColor: Color.gradientBrownBlack
        )
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 40)
        .fill(Color.csBlack)
        .ignoresSafeArea(.all)
        .frame(height: 170)
        .shadow(color: .black, radius: 2)
    )
  }
  
  private func applyConfig() {
    cupSize = selectedConfiguration?.cupSize ?? .small
    sugarSticks = selectedConfiguration?.sugarSticks ?? 0
    iceCubes = selectedConfiguration?.iceCubes ?? 0
    variety = selectedConfiguration?.variety ?? .standart
    milk = selectedConfiguration?.milk ?? .none
    flavor = selectedConfiguration?.flavor ?? .none
  }
}

#Preview {
  OrderConfiguratorScreen(
    selectedCoffee: MockData.coffee,
    path: .constant(NavigationPath()),
    isTabBarVisible: .constant(false)
  )
    .environmentObject(OrderViewModel.previewMode())
    .environmentObject(CoffeeViewModel.previewMode())
    .environmentObject(CoffeeConfigViewModel())
}
