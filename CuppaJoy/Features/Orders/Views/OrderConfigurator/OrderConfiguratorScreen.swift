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
  
  @State var tooltipVisible = false
  
  // Configuration properties
  @State private var cupCount: Int = 1
  @State private var sugarSticks: Int = 0
  @State private var iceCubes: Int = 0
  @State private var cupSize: CupSize = .small
  @State private var variety: Variety = .standart
  @State private var milk: Milk = .none
  @State private var flavor: Flavor = .none
  
  @State private var isShownFAQ: Bool = false
  
  @State private var selectedConfig: CoffeeConfig?
  @State private var isShownSaveConfigAlert: Bool = false
  @State private var configName: String = ""
  
  @EnvironmentObject var configViewModel: CoffeeConfigViewModel
  @EnvironmentObject var orderViewModel: OrderViewModel
  
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
      Color.appBackground.ignoresSafeArea(.all)
      
      VStack {
        if orderViewModel.favoriteConfigs.isEmpty {
          emptyConfigsView
        } else {
          favoriteConfigsView
        }
        configurationsList
        totalAmountLabel
      }
      .padding(.top)
    }
    .navigationTitle("Order Configurator")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .ignoresSafeArea(.keyboard)
    
    .alert("Save Config", isPresented: $isShownSaveConfigAlert) {
      TextField("Config name", text: $configName)
      Button("Cancel", role: .cancel) { configName = "" }
      Button("Save") {
        orderViewModel.setFavoriteConfigs(config) 
        configName = ""
      }
      .disabled(configName.isEmpty)
    } message: {
      Text("Enter the name of your config.")
    }
    
    .sheet(isPresented: $isShownFAQ) {
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
        Image(systemName: "info.circle.fill")
          .foregroundStyle(.csCream)
          .onTapGesture {
            
            isShownFAQ.toggle()
          }
      }
    }
    
    .alert(item: $configViewModel.alertItem) { alertItem in
      Alert(
        title: alertItem.title,
        message: alertItem.message,
        dismissButton: alertItem.dismissButton
      )
    }
    
    .onAppear {
      isTabBarVisible = false
      setupSegmentedControlAppearance()
    }
  }
  
  // MARK: - Configurations List
  
  private var configurationsList: some View {
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
  
  // MARK: - Empty Configs View
  
  private var emptyConfigsView: some View {
    HStack(spacing: 15) {
      Text("You don't have any saved configs.")
        .underline()
        .font(.caption)
        .foregroundStyle(.gray)
      Button("Save", systemImage: "plus.circle") {
        isShownSaveConfigAlert.toggle()
      }
      .font(.footnote)
      .foregroundStyle(.orange)
      .padding(12)
      .background(.csDarkGrey)
      .clipShape(.buttonBorder)
    }
  }
  
  // MARK: - Favorite Configs View
  
  private var favoriteConfigsView: some View {
    
    HStack {
      Text("My Configs:")
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.white)
      
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          ForEach(orderViewModel.favoriteConfigs) { config in
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
                Button("Edit Config", systemImage: "pencil") {}
                Button("Delete Config", systemImage: "trash") {
                  Task {
                    await configViewModel.deleteFavoriteConfig(config)
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
      RoundedRectangle(cornerRadius: 40)
        .fill(Color.csBlack)
        .ignoresSafeArea(.all)
        .frame(height: 150)
        .shadow(color: .black, radius: 2)
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
  .environmentObject(OrderViewModel.previewMode())
  .environmentObject(CoffeeCatalogViewModel.previewMode())
  .environmentObject(CoffeeConfigViewModel())
}
