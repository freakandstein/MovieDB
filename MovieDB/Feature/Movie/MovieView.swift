//
//  MovieView.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 13/11/22.
//

import Foundation
import UIKit

class MovieView: UIViewController {
    
    //MARK: Properties
    private let bundle = Bundle(for: MovieView.self)
    private let className = String(describing: MovieView.self)
    private var loader: LoaderView?
    
    
    //MARK: IBoutlets
    
    
    //MARK: Functions
    init() {
        super.init(nibName: className, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
