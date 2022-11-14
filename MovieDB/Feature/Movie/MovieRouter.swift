//
//  MovieRouter.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 13/11/22.
//

import Foundation
import UIKit

class MovieRouter: MoviePresenterToRouter {
    
    func navigateToMovieDetail(model: MovieDetailModel, view: MoviePresenterToView) {
        if let view = view as? UIViewController {
            let movieDetailView = MovieDetailView(movieDetailModel: model)
            view.navigationController?.pushViewController(movieDetailView, animated: true)
        }
    }
}
