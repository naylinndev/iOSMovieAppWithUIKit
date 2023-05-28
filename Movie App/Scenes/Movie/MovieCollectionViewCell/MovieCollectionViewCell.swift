//
//  MovieCollectionViewCell.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 25/05/2023.
//


import Foundation
import UIKit
import ImageLoader


class MovieCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var tvTitle : UILabel!
    @IBOutlet weak var tvDate : UILabel!
    @IBOutlet weak var imageView : UIImageView!
    
    var cornerRadius: CGFloat = 5.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        // Apply a shadow
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    
    func update(item: MovieModel.DisplayedMovie) {
        
        tvTitle.text = item.title
        tvDate.text = item.date
        imageView.load.request(with: item.image)

                         
     }
    
    func getSize(_ width: CGFloat) -> CGSize {
//        guard let title = tvTitle.text else {
//             return CGSize(width: width, height: 340)
//        }
//        let titleWidth = width - 10
//        let totalHeight = 340 + title.height(constraintedWidth: titleWidth, font: tvTitle.font) + 10
//        return CGSize(width: width, height: totalHeight)
        return CGSize(width: width, height: 350)

    }
}
