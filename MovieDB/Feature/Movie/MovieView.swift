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
    
    var presenter: MovieViewToPresenter?
    
    //MARK: IBoutlets
    @IBOutlet weak var mainTableView: UITableView!
    
    
    //MARK: Functions
    init() {
        super.init(nibName: className, bundle: bundle)
        let view = self
        let presenter = MoviePresenter()
        let router = MovieRouter()
        let interactor = MovieInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        interactor.presenter = presenter
        presenter.interactor = interactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension MovieView: MoviePresenterToView {
    
    func setupTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

extension MovieView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
