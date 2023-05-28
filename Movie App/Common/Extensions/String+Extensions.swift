//
//  String+Extensions.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 27/05/2023.
//


import Foundation
import UIKit

extension String {
    /// Get the exact height of a string in a defined container
    ///
    /// - Parameters:
    ///   - width: Width of the display
    ///   - font: The font used on the string
    /// - Returns: The height of the string expressed in CGFLoat
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
}
