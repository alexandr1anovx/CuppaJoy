//
//  ApplePayView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 08.01.2025.
//

import SwiftUI

struct ApplePaySheet: View {
  @State private var isShownAlert = false
  
  var body: some View {
    NavigationStack {
      List {
        orderTitleSection
        orderPriceSection
        accountNameSection
      }
      .listStyle(.insetGrouped)
      .scrollContentBackground(.hidden)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          applePayLogo
        }
        ToolbarItem(placement: .topBarTrailing) {
          DismissButton()
        }
        ToolbarItem(placement: .bottomBar) {
          footer
        }
      }
      .alert(isPresented: $isShownAlert) {
        Alert(
          title: Text("Success 😎"),
          message: Text("Payment has been successfully processed"),
          dismissButton: .default(Text("Got it!"))
        )
      }
    }
  }
  
  // MARK: - Apple Pay Logo
  private var applePayLogo: some View {
    HStack {
      Image(systemName: "apple.logo")
      Text("Pay").font(.title2)
    }
  }
  
  // MARK: - Order Title
  private var orderTitleSection: some View {
    HStack(spacing: 20) {
      Image(.rocket)
        
        .foregroundStyle(.csCreamy)
      VStack(alignment: .leading, spacing: 5) {
        Text("Medium Coffee Cup")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundStyle(.white)
        Text("Cuppa Joy")
          .font(.footnote)
          .foregroundStyle(.gray)
        Text("In-App Purchase")
          .font(.footnote)
          .foregroundStyle(.gray)
      }
    }
    .listRowBackground(Color.gray.opacity(0.1))
  }
  
  // MARK: - Order Price
  private var orderPriceSection: some View {
    VStack {
      Text("35.00 UAH")
        .font(.title3).bold()
        .foregroundStyle(.white)
      Text("One-time charge")
        .font(.footnote)
        .foregroundStyle(.gray)
    }
    .listRowBackground(Color.gray.opacity(0.1))
  }
  
  // MARK: - Account Name
  private var accountNameSection: some View {
    Text("Account: sashaandrianov@icloud.com")
      .font(.callout)
      .foregroundStyle(.gray)
      .tint(.gray)
      .listRowBackground(Color.gray.opacity(0.1))
  }
  
  // MARK: - Footer (confirmation action)
  private var footer: some View {
    Button {
      isShownAlert = true
    } label: {
      Text("Confirm Payment")
        .fontWeight(.medium)
        .foregroundStyle(.white)
        .padding(13)
        .background(Color.black)
        .clipShape(.buttonBorder)
    }
  }
}

#Preview {
  ApplePaySheet()
}
