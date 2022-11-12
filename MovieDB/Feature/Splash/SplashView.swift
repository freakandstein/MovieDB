//
//  SplashView.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import UIKit

class SplashView: UIViewController {
    
    //MARK: Properties
    private let bundle = Bundle(for: SplashView.self)
    private let className = String(describing: SplashView.self)
    var presenter: SplashViewToPresenter?
    
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
        let apiKey = ConfigHelper.shared.getValue(configKey: .APIKey)
        print("#API Key: \(apiKey)")
    }
}

extension SplashView: SplashPresenterToView {
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
