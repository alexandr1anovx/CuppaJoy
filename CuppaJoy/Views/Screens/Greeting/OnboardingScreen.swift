//
//  OnboardingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 11.01.2025.
//

import SwiftUI

struct OnboardingScreen: View {
  @State private var currentStep = 0
  @State private var isFinished = false
  let onboardingSteps = MockData.onboardingSteps
  
  var body: some View {
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      if isFinished {
        withAnimation(.spring) {
          SignInScreen()
        }
      } else {
        VStack {
          OnboardingProgressView(steps: 3, currentStep: $currentStep)
          Spacer()
          DetailsView(onboardingSteps: onboardingSteps, currentStep: currentStep)
          Spacer()
        }
        .padding()
        
        OnboardingNextButton(currentStep: $currentStep) {
          
          if currentStep < onboardingSteps.count - 1 {
            currentStep += 1
          } else {
            withAnimation(.linear.delay(0.2)) {
              isFinished = true
            }
          }
        }
      }
    }
  }
}

#Preview {
  OnboardingScreen()
}

struct DetailsView: View {
  var onboardingSteps = MockData.onboardingSteps
  var currentStep: Int
  
  var body: some View {
    VStack {
      Text(onboardingSteps[currentStep].title)
        .font(.poppins(.bold, size: 23))
      
      Text(onboardingSteps[currentStep].description)
        .font(.poppins(.medium, size: 15))
        .foregroundStyle(.gray)
    }
    .id(currentStep)
    //    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    .animation(.bouncy, value: currentStep)
    .frame(maxWidth: .infinity)
  }
}


struct OnboardingProgressView: View {
  var steps: Int
  @Binding var currentStep: Int
  
  var body: some View {
    HStack(spacing: 30) {
      ForEach(0..<steps, id: \.self) { item in
        GeometryReader { geo in
          ZStack(alignment: .leading) {
            Capsule()
              .frame(width: geo.size.width, height: 5)
              .foregroundStyle(Color.cstBlue)
            Capsule()
              .frame(width: currentStep >= item ? geo.size.width : 0, height: 5)
              .foregroundStyle(.cstCream)
              .opacity(0.8)
              .animation(.bouncy(duration: 0.5), value: currentStep)
          }
        }
      }
    }
    .frame(height: 6)
  }
}

struct OnboardingNextButton: View {
  @State private var isShownAnimatedCircle = false
  @Binding var currentStep: Int
  var action: () -> Void
  
  var body: some View {
    ZStack {
      Group {
        Circle()
          .frame(width: 68, height: 68)
          .foregroundStyle(.accent)
          .scaleEffect(
            isShownAnimatedCircle ? 1 : 0, anchor: .leading
          )
        Circle()
          .frame(width: 60, height: 60)
          .foregroundStyle(.cstDarkBrown)
      }
      Image(systemName: "arrow.right")
        .font(.title3)
        .foregroundStyle(.cstWhite)
    }
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity,
      alignment: .bottomTrailing
    )
    .padding(.horizontal)
    
    // Shows the next view.
    .onTapGesture {
      action()
    }
    // Redraws each time the onboarding view changes.
    .onChange(of: currentStep) { oldValue, newValue in
      isShownAnimatedCircle.toggle()
      withAnimation(.smooth(duration: 1)) {
        isShownAnimatedCircle.toggle()
      }
    }
    // Provide a smooth animation when the view appears.
    .onAppear {
      withAnimation(.smooth(duration: 1)) {
        isShownAnimatedCircle.toggle()
      }
    }
  }
}
