//
//  OrderPaymentView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentOptionContainer: View {
  
  let order: Order
  @State private var isShownPaymentSheet = false
  
  var body: some View {
    VStack(spacing:25) {
      userDataStack
      checkDetailsButton
      PaymentOptionList()
      Spacer()
      paymentStack
    }
    .padding(.top, 25)
    .sheet(isPresented: $isShownPaymentSheet) {
      ApplePaySheet(order: order)
        .presentationDetents([.height(340)])
        .presentationBackgroundInteraction(.disabled)
        .presentationCornerRadius(30)
    }
  }
  
  private var userDataStack: some View {
    HStack(spacing:10) {
      Image(systemName: "person.fill")
        .imageScale(.large)
        .foregroundStyle(.white)
        .padding(10)
        .background(.csDarkGrey)
        .clipShape(.circle)
      VStack(alignment: .leading, spacing: 8) {
        Text("Alexander Andrianov")
          .font(.headline)
          .fontDesign(.rounded)
          .fontWeight(.bold)
        Text("+380669732145")
          .font(.footnote)
          .fontWeight(.bold)
          .foregroundStyle(.gray)
          .lineLimit(2)
          .multilineTextAlignment(.leading)
      }
      Spacer()
    }
    .padding(.top, 10)
    .padding(.leading, 20)
  }
  
  private var checkDetailsButton: some View {
    Button {
      // ...
    } label: {
      ButtonLabelWithIcon(
        "Check order configurations",
        icon: "list.bullet",
        textColor: .orange,
        pouring: .csDarkGrey
      )
    }
  }
  
  private var paymentStack: some View {
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
          .frame(minWidth: 75)
      }
      Button {
        isShownPaymentSheet.toggle()
      } label: {
        ButtonLabelWithIconAnimated(
          "Confirm Payment",
          icon: "checkmark.circle.fill",
          textColor: .white,
          bgColor: Color.pointsGradient
        )
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 30)
        .fill(Color.csBlack)
        .ignoresSafeArea(.all)
        .frame(height: 140)
        .shadow(radius: 5)
    )
  }
}

#Preview {
  PaymentOptionContainer(order: MockData.order)
}
