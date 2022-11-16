//
//  UICollectionViewCell+Extension.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 13/11/22.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    func shadowDecorate() {
        let radius: CGFloat = 16
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    }
}
