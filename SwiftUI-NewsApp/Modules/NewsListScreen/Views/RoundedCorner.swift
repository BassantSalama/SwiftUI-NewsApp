//
//  RoundedCorner.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import SwiftUI

// MARK: - RoundedCorner Shape
struct RoundedCorner: Shape {
    
    // MARK: - Properties
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    // MARK: - Path
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - View Extension for Custom CornerRadius
extension View {
    
    /// Apply corner radius to specific corners only
    /// - Parameters:
    ///   - radius: CGFloat, corner radius
    ///   - corners: UIRectCorner, which corners to round
    /// - Returns: some View with clipped shape
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
