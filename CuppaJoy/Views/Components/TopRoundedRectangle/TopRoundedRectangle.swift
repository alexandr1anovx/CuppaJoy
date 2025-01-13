//
//  TopRoundedRectangle.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.12.2024.
//

import SwiftUI

struct TopRoundedRectangle: Shape {
  var cornerRadius: CGFloat
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: 0, y: rect.height))
    path.addLine(to: CGPoint(x: 0, y: cornerRadius))
    path.addQuadCurve(to: CGPoint(x: cornerRadius, y: 0),
                      control: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
    path.addQuadCurve(to: CGPoint(x: rect.width, y: cornerRadius), control: CGPoint(x: rect.width, y: 0))
    
    path.addLine(to: CGPoint(x: rect.width, y: rect.height))
    path.addLine(to: CGPoint(x: 0, y: rect.height))
    path.closeSubpath()
    
    return path
  }
}
