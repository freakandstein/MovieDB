//
//  MainView.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import UIKit

class MainView: UIViewController {
    
    //MARK: Properties
    private let bundle = Bundle(for: MainView.self)
    private let className = String(describing: MainView.self)
    
    //MARK: IBoutlets
    
    
    //MARK: Functions
    init() {
        super.init(nibName: className, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
