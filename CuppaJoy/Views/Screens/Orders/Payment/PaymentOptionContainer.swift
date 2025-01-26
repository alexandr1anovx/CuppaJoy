//
//  OrderPaymentView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentOptionContainer: View {
  
  @State private var isShownApplePay = false
  
  var body: some View {
    ZStack {
      Color.mainGradientBackground
        .clipShape(.rect(cornerRadius: 30))
        .ignoresSafeArea(.all)
      
      VStack {
        userDataView
        PaymentOptionList()
        Spacer()
        footerView
      }
      .padding(.vertical, 25)
    }
    .sheet(isPresented: $isShownApplePay) {
      ApplePaySheet()
        .presentationDetents([.height(380)])
        .presentationBackgroundInteraction(.disabled)
    }
    .shadow(radius: 5)
  }
  
  // MARK: - User Data
  private var userDataView: some View {
    HStack {
      Image(.man)
        .resizable()
        .frame(width: 23, height: 23)
        .foregroundStyle(.csYellow)
        .padding(12)
        .background(Color.csBrown)
        .clipShape(.capsule)
      VStack(alignment: .leading, spacing: 8) {
        Text("Username")
          .font(.headline)
          .foregroundStyle(.white)
        Text("Coffee Store Address")
          .font(.footnote)
          .foregroundStyle(.gray)
          .lineLimit(2)
          .multilineTextAlignment(.leading)
      }
      Spacer()
    }
    .padding(.top, 10)
    .padding(.leading, 20)
  }
  
  // MARK: - Footer
  private var footerView: some View {
    HStack {
      VStack {
        Text("Total Amount:")
          .font(.poppins(.medium, size: 16))
          .foregroundStyle(.gray)
        Text("₴ 35.00")
          .font(.poppins(.bold, size: 20))
          .foregroundStyle(.csCreamy)
      }
      Spacer()
      Button {
        isShownApplePay = true
      } label: {
        Text("Confirm")
          .font(.poppins(.bold, size: 15))
          .foregroundStyle(.white)
          .padding(10)
      }
      .tint(.csDarkBrown)
      .buttonStyle(.borderedProminent)
    }
    .padding(.horizontal, 20)
  }
}

#Preview {
  PaymentOptionContainer()
}
