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
    VStack {
      userDataView
      PaymentOptionList()
      Spacer()
      footerView
    }
    .padding(.vertical, 25)
    .sheet(isPresented: $isShownApplePay) {
      ApplePaySheet()
        .presentationDetents([.height(380)])
        .presentationBackgroundInteraction(.disabled)
    }
    .shadow(radius: 8)
  }
  
  // MARK: - User Data
  private var userDataView: some View {
    HStack {
      Image(.man)
        .resizable()
        .frame(width: 23, height: 23)
        .foregroundStyle(.accent)
        .padding(12)
        .background(Color.black)
        .clipShape(.capsule)
      VStack(alignment: .leading, spacing: 8) {
        Text("Username")
          .font(.headline)
          .fontDesign(.monospaced)
          .foregroundStyle(.white)
        Text("Coffee Store Address")
          .font(.footnote)
          .fontDesign(.monospaced)
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
      VStack(spacing: 10) {
        Text("Total Amount:")
          .font(.callout).bold()
          .fontDesign(.monospaced)
          .foregroundStyle(.gray)
        Text("₴ 35.00")
          .font(.title2).bold()
          .foregroundStyle(.white)
      }
      Spacer()
      Button {
        isShownApplePay.toggle()
      } label: {
        Text("Confirm")
          .font(.callout).bold()
          .fontDesign(.monospaced)
          .foregroundStyle(.accent)
          .padding(10)
      }
      .tint(.black)
      .buttonStyle(.borderedProminent)
    }
    .padding(.horizontal, 20)
  }
}

#Preview {
  PaymentOptionContainer()
}
