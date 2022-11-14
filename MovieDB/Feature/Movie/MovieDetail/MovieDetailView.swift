//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 14/11/22.
//

import Foundation
import UIKit
import Kingfisher

class MovieDetailView: UIViewController {
    
    //MARK: Properties
    private let bundle = Bundle(for: MovieDetailView.self)
    private let className = String(describing: MovieDetailView.self)
    private let model: MovieDetailModel
    
    //MARK: IBoutlets
    
    
    
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
        print(model)
    }
    
}
