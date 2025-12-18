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
  @State var coffeeConfigViewModel: CoffeeConfigViewModel
  @State var orderConfigViewModel: OrderConfiguratorViewModel
  
  var body: some View {
    ZStack {
      Color.appBackgroundDimmed.ignoresSafeArea()
      VStack {
        if coffeeConfigViewModel.configs.isEmpty {
          emptyConfigsView
        } else {
          ConfigsScrollableView()
        }
        configurationForm
        totalAmountLabel
      }
      .padding(.top)
    }
    .navigationTitle("Configurator")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .ignoresSafeArea(.keyboard)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) { toolbarBackButton }
      ToolbarItem(placement: .topBarTrailing) { toolbarHintButton }
    }
    .onAppear {
      isTabBarVisible = false
      setupSegmentedControlAppearance()
    }
    .environment(coffeeConfigViewModel)
    .environment(orderConfigViewModel)
    .alert(
      "Config Saving",
      isPresented: $orderConfigViewModel.showSaveConfigAlert
    ) {
      TextField("Enter a name", text: $orderConfigViewModel.configName)
      Button("Cancel") {}
      Button("Add") {
        Task {
          await coffeeConfigViewModel.saveConfig(orderConfigViewModel.config)
        }
      }
      .disabled(orderConfigViewModel.configName.isEmpty)
    } message: {
      Text("Make sure you carefully check your current config.")
    }
  }
  
  // MARK: - Subviews
  
  private var emptyConfigsView: some View {
    HStack {
      Text("You have no configs yet.")
        .font(.footnote)
        .foregroundStyle(.gray)
      Button("Add", systemImage: "plus.circle.fill") {
        orderConfigViewModel.showSaveConfigAlert.toggle()
      }
      .font(.footnote)
      .foregroundStyle(.orange)
      .padding(12)
      .background(.csDarkGrey)
      .clipShape(.capsule)
      
    }
  }
  
  private var configurationForm: some View {
    Form {
      Section("Cup Configurations") {
        OrderItemPicker("Size", selectedItem: $orderConfigViewModel.cupSize)
          .pickerStyle(.segmented)
        OrderItemCounter(
          "Count:",
          min: 1, max: 4,
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
      ReturnButtonLabel()
    }
  }
  
  private var toolbarHintButton: some View {
    Button {
      orderConfigViewModel.showHintPopover.toggle()
    } label: {
      Image(systemName: "info.circle.fill")
        .foregroundStyle(.pink)
    }
    .popover(
      isPresented: $orderConfigViewModel.showHintPopover,
      attachmentAnchor: .point(.trailing),
      arrowEdge: .trailing) {
        VStack(alignment: .leading, spacing: 8) {
          Text("• To save the configuration, select all the desired parameters and click the **Add** button.")
          Divider()
          Text("• For additional actions with the configuration, hold down its button.")
        }
        .font(.caption)
        .multilineTextAlignment(.leading)
        .frame(height: 80)
        .presentationBackground(.csBlack)
        .presentationCompactAdaptation(.popover)
        .padding()
      }
  }
}
