//
//  ApplePayView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 08.01.2025.
//

import SwiftUI

struct ApplePayView: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      List {
        AppOverviewSection()
        ServicePriceSection()
        CancellationGuideSection()
        AccountNameSection()
      }
      .listStyle(.insetGrouped)
      .scrollContentBackground(.hidden)
      .background(Color.gray.opacity(0.2))
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          HStack {
            Image(systemName: "apple.logo")
            Text("Pay")
          }
          .font(.title2)
          .foregroundStyle(.white)
        }
        ToolbarItem(placement: .primaryAction) {
          Image(systemName: "xmark.circle.fill")
            .font(.title2)
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.gray)
            .onTapGesture {
              dismiss()
            }
        }
        ToolbarItem(placement: .bottomBar) {
          ApplePayFooter()
            .padding(.top,20)
        }
      }
    }
  }
}

#Preview {
  ApplePayView()
}

private extension ApplePayView {
  
  struct ApplePayHeaderView: View {
    var body: some View {
      HStack {
        Label("Pay", systemImage: "apple.logo")
          .foregroundStyle(.black)
          .font(.title)
        Spacer()
        Image(systemName: "xmark.circle.fill")
          .font(.title)
          .symbolRenderingMode(.hierarchical)
          .foregroundStyle(.gray)
      }
    }
  }
  
  struct AppOverviewSection: View {
    var body: some View {
      HStack(spacing: 18) {
        Image("beans")
          .resizable()
          .frame(width: 40, height: 40)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(Color.cstBlack)
              .frame(width: 50, height: 50)
          )
        VStack(alignment: .leading, spacing: 5) {
          Text("Cuppa Joy")
            .foregroundStyle(.white)
          Text("Medium Coffee Cup")
            .font(.footnote)
            .foregroundStyle(.gray)
        }
      }
      .listRowBackground(Color.gray.opacity(0.1))
    }
  }
  
  struct ServicePriceSection: View {
    var body: some View {
      Text("35.00 UAH")
        .font(.title3)
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .listRowBackground(Color.gray.opacity(0.1))
    }
  }
  
  struct CancellationGuideSection: View {
    var body: some View {
      Text("Cancel at any time in Settings > Apple Account at least a day before each renewal date. Plan automatically renews until cancelled.")
        .font(.callout)
        .foregroundStyle(.white)
        .listRowBackground(Color.gray.opacity(0.1))
    }
  }
  
  struct AccountNameSection: View {
    var body: some View {
      Text("Account: sashaandrianov@icloud.com")
        .font(.callout)
        .foregroundStyle(.gray)
        .tint(.gray)
        .listRowBackground(Color.gray.opacity(0.1))
    }
  }
  
  struct ApplePayFooter: View {
    var body: some View {
      HStack {
        Image(systemName: "iphone.radiowaves.left.and.right.circle.fill")
          .resizable()
          .frame(width: 35, height: 35)
          .symbolRenderingMode(.hierarchical)
          .foregroundStyle(.blue)
        Text("Confirm with Side Button")
          .font(.callout)
          .foregroundStyle(.white)
      }
    }
  }
}
