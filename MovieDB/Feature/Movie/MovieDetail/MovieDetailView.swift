//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 14/11/22.
//

import Foundation
import UIKit
import Kingfisher
import SkeletonView

class MovieDetailView: UIViewController {
    
    //MARK: Properties
    private let bundle = Bundle(for: MovieDetailView.self)
    private let className = String(describing: MovieDetailView.self)
    private let model: MovieDetailModel
    
    //MARK: IBoutlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewMovieLabel: UILabel!
    
    //MARK: Functions
    init(movieDetailModel: MovieDetailModel) {
        model = movieDetailModel
        super.init(nibName: className, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func loadImage() {
        let baseURLImage = ConfigHelper.shared.getValue(configKey: .BaseURLImage)
        let urlPathImage = model.backdropPath ?? .empty
        let urlImage = baseURLImage + urlPathImage
        movieImageView.isSkeletonable = true
        movieImageView.showAnimatedGradientSkeleton()
        movieImageView.kf.setImage(with: URL(string: urlImage)) { [weak self] result in
            guard let self = self else { return }
            self.movieImageView.hideSkeleton()
        }
    }
    
    private func setup() {
        let titleMovie = model.title ?? .empty
        title = titleMovie
        titleMovieLabel.text = titleMovie
        overviewMovieLabel.text = model.overview ?? .empty
        loadImage()
    }
    
}
