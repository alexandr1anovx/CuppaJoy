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
  @EnvironmentObject var orderViewModel: OrderViewModel
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
      id: UUID().uuidString,
      title: configName,
      cupSize: cupSize.title,
      sugarSticks: sugarSticks,
      iceCubes: iceCubes,
      variety: variety.title,
      milk: milk.title,
      flavor: flavor.title
    )
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack {
        if orderViewModel.configs.isEmpty {
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
        orderViewModel.setFavoriteConfigs(config)
        print("✅ New Config Saved!")
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
        ForEach(orderViewModel.configs) { config in
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
        ButtonLabelWithIcon(
          "Summorize",
          icon: "plus.circle.fill",
          textColor: .white,
          bgColor: .csBrown
        )
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 40)
        .fill(Color.csBlack)
        .ignoresSafeArea(.all)
        .frame(height: 150)
        .shadow(color: .black, radius: 2)
    )
  }
  
  private func applyConfig() {
    if let sizeString = selectedConfiguration?.cupSize,
       let size = CupSize.allCases.first(where: { $0.title == sizeString }) {
      cupSize = size
    }
    
    sugarSticks = selectedConfiguration?.sugarSticks ?? 0
    iceCubes = selectedConfiguration?.iceCubes ?? 0
    
    if let varietyString = selectedConfiguration?.variety,
       let varietyValue = Variety.allCases.first(where: { $0.title == varietyString }) {
      variety = varietyValue
    }
    
    if let milkString = selectedConfiguration?.milk,
       let milkValue = Milk.allCases.first(where: { $0.title == milkString }) {
      milk = milkValue
    }
    
    if let flavorString = selectedConfiguration?.flavor,
       let flavorValue = Flavor.allCases.first(where: { $0.title == flavorString }) {
      flavor = flavorValue
    }
  }
}

#Preview {
  OrderConfiguratorScreen(
    selectedCoffee: MockData.coffee,
    path: .constant(NavigationPath()),
    isTabBarVisible: .constant(false)
  )
  .environmentObject(OrderViewModel.previewMode())
  .environmentObject(CoffeeCatalogViewModel.previewMode())
  .environmentObject(CoffeeConfigViewModel())
}
