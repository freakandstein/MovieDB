//
//  SplashView.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import UIKit
import SwiftUI

class SplashView: UIViewController {
    
    //MARK: Properties
    private let bundle = Bundle(for: SplashView.self)
    private let className = String(describing: SplashView.self)
    private var loader: LoaderView?
    
    var presenter: SplashViewToPresenter?
    
    //MARK: IBoutlets
    
    
    //MARK: Functions
    init() {
        super.init(nibName: className, bundle: bundle)
        let view = self
        let presenter = SplashPresenter()
        let router = SplashRouter()
        presenter.view = view
        presenter.router = router
        view.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
}

extension SplashView: SplashPresenterToView {
    
    func showLoading() {
        loader = LoaderView(frame: CGRect(x: .zero, y: .zero, width: 64, height: 64))
        if let loader = loader {
            self.view.addSubview(loader)
            loader.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loader.widthAnchor.constraint(equalToConstant: loader.frame.width),
                loader.heightAnchor.constraint(equalToConstant: loader.frame.height),
                loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 64)
            ])
        }
    }
    
    func hideLoading() {
        loader?.removeFromSuperview()
    }
}
