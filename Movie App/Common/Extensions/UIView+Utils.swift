//
//  UIView+Utils.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 27/05/2023.
//
import UIKit

extension UIView {
    internal func addSubviews(_ subviews: [UIView] ) {
        for view in subviews {
            self.addSubview(view)
        }
    }
    
    class func fromNib<T: UIView>() -> T? {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?[0] as? T
    }
}
