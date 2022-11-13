//
//  MainCollectionViewCell.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 13/11/22.
//

import Foundation
import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    static let id = String(describing: MainCollectionViewCell.self)
    private var model: MovieDetailModel?
    
    //MARK: IBOutlets
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupMovieDetail(movieDetailModel: MovieDetailModel?) {
        model = movieDetailModel
        if let urlPathImage = model?.posterPath {
            loadImage(urlPathImage: urlPathImage)
        }
    }
    
    private func loadImage(urlPathImage: String) {
        let baseURLImage = ConfigHelper.shared.getValue(configKey: .BaseURLImage)
        let urlImage = baseURLImage + urlPathImage
        movieImage.kf.setImage(with: URL(string: urlImage))
    }
    
}
