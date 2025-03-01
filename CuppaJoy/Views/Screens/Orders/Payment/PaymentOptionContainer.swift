//
//  OrderPaymentView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentOptionContainer: View {
  
  let order: Order
  @State private var isShownApplePay = false
  
  var body: some View {
    VStack(spacing:30) {
      userDataStack
      checkDetailsButton
      PaymentOptionList()
      Spacer()
      paymentStack
    }
    .padding(.top, 25)
    .sheet(isPresented: $isShownApplePay) {
      ApplePaySheet(order: order)
        .presentationDetents([.height(340)])
        .presentationBackgroundInteraction(.disabled)
        .presentationCornerRadius(20)
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
        "Check Order Details",
        icon: "receipt.fill",
        textColor: .white,
        pouring: .black
      )
    }
  }
  
  private var paymentStack: some View {
    VStack(spacing: 20) {
      HStack(spacing: 5) {
        Text("Total Amount:")
          .font(.headline)
          .fontWeight(.bold)
          .foregroundStyle(.white)
        Text(order.stringPrice)
          .font(.title3)
          .fontWeight(.bold)
          .foregroundStyle(.pink)
          .frame(minWidth: 75)
      }
      Button {
        isShownApplePay.toggle()
      } label: {
        ButtonLabelAnimated("Confirm Payment", textColor: .white)
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
