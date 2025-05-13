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
  @EnvironmentObject var coffeeConfigViewModel: CoffeeConfigViewModel
  
  // Configuration properties
  @State private var cupCount: Int = 1
  @State private var sugarSticks: Int = 0
  @State private var iceCubes: Int = 0
  @State private var cupSize: CupSize = .small
  @State private var variety: Variety = .standart
  @State private var milk: Milk = .none
  @State private var flavor: Flavor = .none
  
  @State private var isShownFAQSheet: Bool = false
  
  @State private var selectedConfig: CoffeeConfig?
  @State private var isShownSaveConfigAlert: Bool = false
  @State private var configName: String = ""
  
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
      points: selectedCoffee.points,
      totalPrice: totalPrice,
      timestamp: .now
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
      Color.appBackgroundDimmed.ignoresSafeArea()
      VStack {
        if coffeeConfigViewModel.favoriteConfigs.isEmpty {
          emptyConfigsView
        } else {
          scrollableFavoriteConfigs
        }
        configurationList
        totalAmountLabel
      }
      .padding(.top)
    }
    .navigationTitle("Order Configurator")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .ignoresSafeArea(.keyboard)
    
    .alert("Config Saving", isPresented: $isShownSaveConfigAlert) {
      TextField("Enter a name", text: $configName)
      cancelConfigButton
      addConfigConfirmationButton
    } message: {
      Text("Make sure you carefully check your current config.")
    }
    
    .sheet(isPresented: $isShownFAQSheet) {
      EmptyView()
        .presentationDetents([.medium])
        .presentationCornerRadius(30)
        .presentationDragIndicator(.visible)
        .presentationCompactAdaptation(.sheet)
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
        Button { isShownFAQSheet.toggle() } label: {
          Image(systemName: "info.circle.fill")
            .foregroundStyle(.csCream)
        }
      }
    }
    .onAppear {
      isTabBarVisible = false
      setupSegmentedControlAppearance()
    }
  }
  
  // MARK: - Auxilary UI Components
  
  private var scrollableFavoriteConfigs: some View {
    HStack {
      Text("My Configs:")
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.white)
      
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          ForEach(coffeeConfigViewModel.favoriteConfigs) { config in
            Button {
              selectedConfig = config
              applyConfig()
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
        isShownSaveConfigAlert.toggle()
      } label: {
        Image(systemName: "plus.circle")
          .foregroundStyle(.orange)
          .padding(7)
          .background(.csDarkGrey)
          .clipShape(.circle)
          .shadow(radius: 3)
      }
    }.padding(.horizontal,20)
  }
  
  private var emptyConfigsView: some View {
    HStack {
      Text("You have 0 favorite configs.")
        .underline()
        .font(.caption)
        .foregroundStyle(.gray)
      Button("Add", systemImage: "plus.circle") {
        isShownSaveConfigAlert.toggle()
      }
      .font(.footnote)
      .foregroundStyle(.orange)
      .padding(12)
      .background(.csDarkGrey)
      .clipShape(.capsule)
    }
  }
  
  private var addConfigConfirmationButton: some View {
    Button("Add") {
      Task { await coffeeConfigViewModel.saveConfig(config) }
    }
    .disabled(configName.isEmpty || configName.count > 6)
  }
  
  private var cancelConfigButton: some View {
    Button("Cancel") { configName = "" }
  }
  
  private var configurationList: some View {
    List {
      Section("Cup Configurations") {
        OrderItemPicker("Size", selectedItem: $cupSize)
          .pickerStyle(.segmented)
        OrderItemCounter("Count:", min: 1, max: 4, count: $cupCount)
      }
      Section("Additives") {
        OrderItemCounter("Sugar sticks:", min: 0, max: 3, count: $sugarSticks)
        OrderItemCounter("Ice cubes:", min: 0, max: 3, count: $iceCubes)
        OrderItemPicker("Variety:", selectedItem: $variety)
        OrderItemPicker("Milk:", selectedItem: $milk)
        OrderItemPicker("Flavor:", selectedItem: $flavor)
      }
    }
    .customListStyle(rowSpacing: 15, shadowRadius: 3)
    .listSectionSpacing(8)
  }
  
  private var totalAmountLabel: some View {
    VStack(spacing: 20) {
      HStack(spacing: 0) {
        Text("Total Amount:")
          .font(.subheadline)
          .fontWeight(.bold)
          .foregroundStyle(.white)
        Text(order.formattedPrice)
          .font(.system(size: 17))
          .fontWeight(.bold)
          .foregroundStyle(.orange)
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
          textColor: .csCream,
          bgColor: .csDarkGrey
        )
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 35)
        .fill(Color.csBlack)
        .ignoresSafeArea(.all)
        .frame(height: 150)
        .shadow(radius: 5)
    )
  }
  
  private func applyConfig() {
    if let sizeString = selectedConfig?.cupSize,
       let size = CupSize.allCases.first(where: { $0.title == sizeString }) {
      cupSize = size
    }
    
    sugarSticks = selectedConfig?.sugarSticks ?? 0
    iceCubes = selectedConfig?.iceCubes ?? 0
    
    if let varietyString = selectedConfig?.variety,
       let varietyValue = Variety.allCases.first(where: { $0.title == varietyString }) {
      variety = varietyValue
    }
    
    if let milkString = selectedConfig?.milk,
       let milkValue = Milk.allCases.first(where: { $0.title == milkString }) {
      milk = milkValue
    }
    
    if let flavorString = selectedConfig?.flavor,
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
  .environmentObject(OrderViewModel())
  .environmentObject(CoffeeCatalogViewModel())
  .environmentObject(CoffeeConfigViewModel())
}
