//
//  MainCollectionViewCell.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 13/11/22.
//

import Foundation
import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    static let id = String(describing: MainCollectionViewCell.self)
    let name = "Test"
    
    //MARK: IBOutlets
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
