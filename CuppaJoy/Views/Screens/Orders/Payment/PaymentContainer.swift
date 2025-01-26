//
//  OrderPaymentView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentOptionsContainer: View {
  
  var body: some View {
    ZStack {
      Color.mainGradientBackground
        .clipShape(.rect(cornerRadius: 30))
        .ignoresSafeArea(.all)
      
      VStack {
        userDataView
        PaymentOptionsList()
        Spacer()
        footerView
      }
      .padding(.vertical, 25)
    }
    .shadow(radius: 8)
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
    .padding(.top,10)
    .padding(.leading,20)
  }
  
  // MARK: - Footer
  private var footerView: some View {
    HStack {
      VStack {
        Text("Total Amount:")
          .font(.headline)
          .foregroundStyle(.gray)
        Text("₴ 35.00")
          .font(.title2).bold()
          .foregroundStyle(.csYellow)
      }
      
      Spacer()
      
      Button {
        // action
      } label: {
        Text("Confirm")
          .font(.callout).bold()
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
  PaymentOptionsContainer()
}

