//
//  OrderConfiguratorScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct OrderConfiguratorScreen: View {
  
  @Binding var path: NavigationPath
  @Binding var isTabBarVisible: Bool
  @State var coffeeRecipeViewModel: CoffeeRecipeViewModel
  @State var orderConfigViewModel: OrderConfiguratorViewModel
  
  let remoteConfigService: RemoteConfigServiceProtocol
  
  var body: some View {
    ZStack {
      Color.appBackgroundDimmed.ignoresSafeArea()
      VStack {
        if coffeeRecipeViewModel.recipes.isEmpty {
          emptyRecipesView
        } else {
          RecipesScrollableView()
        }
        configurationForm
        totalAmountLabel
      }
      .padding(.top)
    }
    .alert("Save Your Coffee Recipe", isPresented: $orderConfigViewModel.showSaveRecipeAlert) {
      TextField("Give your recipe a name", text: $orderConfigViewModel.recipeName)
      Button("Maybe Later") {}
      Button("Save Recipe") {
        Task {
          await coffeeRecipeViewModel.saveRecipe(orderConfigViewModel.recipe)
        }
      }
      .disabled(orderConfigViewModel.recipeName.isEmpty)
    } message: {
      Text("Give your coffee a name so you can easily find it again later.")
    }
    .navigationTitle("Customize Your Coffee")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .ignoresSafeArea(.keyboard)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) { toolbarBackButton }
    }
    .onAppear {
      isTabBarVisible = false
      setupSegmentedControlAppearance()
    }
    .environment(coffeeRecipeViewModel)
    .environment(orderConfigViewModel)
  }
  
  // MARK: - Subviews
  
  private var emptyRecipesView: some View {
    HStack {
      Text("No saved recipes yet.")
        .font(.footnote)
        .foregroundStyle(.gray)
        .multilineTextAlignment(.center)
      Button("Create Recipe", systemImage: "plus.circle.fill") {
        orderConfigViewModel.showSaveRecipeAlert.toggle()
      }
      .font(.footnote)
      .fontWeight(.medium)
      .foregroundStyle(.orange)
      .padding(12)
      .background(.csDarkGrey)
      .clipShape(.capsule)
    }
  }
  
  private var configurationForm: some View {
    Form {
      Section("Cup") {
        OrderItemPicker("Size", selectedItem: $orderConfigViewModel.cupSize)
          .pickerStyle(.segmented)
        OrderItemCounter(
          "Count:",
          min: 1,
          max: remoteConfigService.getInt(forKey: RemoteConfigKeys.maxCoffeeItems),
          count: $orderConfigViewModel.cupCount
        )
      }
      Section("Additives") {
        OrderItemCounter(
          "Sugar sticks:",
          min: 0, max: 3,
          count: $orderConfigViewModel.sugarSticks
        )
        OrderItemCounter(
          "Ice cubes:",
          min: 0, max: 3,
          count: $orderConfigViewModel.iceCubes
        )
        OrderItemPicker("Variety:", selectedItem: $orderConfigViewModel.variety)
        OrderItemPicker("Milk:", selectedItem: $orderConfigViewModel.milk)
        OrderItemPicker("Flavor:", selectedItem: $orderConfigViewModel.flavor)
      }
    }
    .customListStyle(rowSpacing: 15, sectionSpacing: 8, shadow: 3)
  }
  
  private var totalAmountLabel: some View {
    VStack(spacing: 20) {
      HStack(spacing: 0) {
        Text("Total Amount:")
          .font(.subheadline)
          .fontWeight(.bold)
          .foregroundStyle(.white)
        Text(orderConfigViewModel.order.formattedPrice)
          .font(.headline)
          .fontWeight(.bold)
          .foregroundStyle(.orange)
          .contentTransition(.numericText())
          .animation(.bouncy, value: orderConfigViewModel.totalPrice)
          .frame(minWidth: 75)
      }
      Button {
        path.append(OrderPage.summary(orderConfigViewModel.order))
      } label: {
        CapsuleLabelWithIcon(
          "Summorize",
          icon: "plus.circle.fill",
          textColor: .csCream,
          bgColor: .csDarkGrey
        )
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 50)
        .fill(.csDarkGrey)
        .ignoresSafeArea()
        .frame(height: 150)
        .shadow(radius: 5)
    )
  }
  
  private var toolbarBackButton: some View {
    Button {
      path.removeLast()
      isTabBarVisible = true
    } label: {
      BackButton()
    }
  }
}
