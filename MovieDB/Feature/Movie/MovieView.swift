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
    private var upcomingTableViewCell: MainTableViewCell?
    private var topRatedTableViewCell: MainTableViewCell?
    private var nowPlayingTableViewCell: MainTableViewCell?
    private var popularTableViewCell: MainTableViewCell?
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    private var isRefreshing: Bool = false
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Movie"
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
}

extension MovieView: MoviePresenterToView {
    
    func setupTableView() {
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        mainTableView.register(UINib(nibName: MainTableViewSectionHeaderCell.id,
                                     bundle: .main),
                               forHeaderFooterViewReuseIdentifier: MainTableViewSectionHeaderCell.id)
        mainTableView.register(UINib(nibName: MainTableViewCell.id, bundle: .main),
                               forCellReuseIdentifier: MainTableViewCell.id)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.addSubview(refreshControl)
    }
    
    func reload() {
        mainTableView.reloadData()
    }
    
    func load(by mainTableViewIndex: MainTableViewIndex) {
        switch mainTableViewIndex {
        case .upcoming:
            upcomingTableViewCell?.setData(movieModel: presenter?.upcomingMovie)
        case .popular:
            popularTableViewCell?.setData(movieModel: presenter?.popularMovie)
        case .nowPlaying:
            nowPlayingTableViewCell?.setData(movieModel: presenter?.nowPlayingMovie)
        case .topRated:
            topRatedTableViewCell?.setData(movieModel: presenter?.topRatedMovie)
        }
        if isRefreshing {
            refreshControl.endRefreshing()
            isRefreshing = false
        }
    }
    
    func loadFailed(by mainTableViewIndex: MainTableViewIndex, error: ErrorModel) {
        var errorMessage: String = .empty
        switch mainTableViewIndex {
        case .upcoming:
            errorMessage = "Up Coming movie: \(errorMessage)"
        case .popular:
            errorMessage = "Popular movie: \(errorMessage)"
        case .nowPlaying:
            errorMessage = "Now Playing movie: \(errorMessage)"
        case .topRated:
            errorMessage = "Top Rated movie: \(errorMessage)"
        }
        showError(errorMessage: errorMessage, statusCode: error.statusCode)
    }
    
    private func showError(errorMessage: String, statusCode: Int) {
        let alertController = UIAlertController(title: "Error \(statusCode)", message: errorMessage, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    @objc private func pullToRefresh() {
        refreshControl.beginRefreshing()
        isRefreshing = true
        presenter?.viewDidLoad()
    }
}

extension MovieView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.id) as? MainTableViewCell else { return UITableViewCell() }
        
        let section = MainTableViewIndex(rawValue: indexPath.section) ?? .upcoming
        
        cell.setupSection(section: section)
        cell.setupDelegate(mainTableViewDelegate: self)
        switch section {
        case .upcoming:
            upcomingTableViewCell = cell
            cell.setData(movieModel: presenter?.upcomingMovie)
        case .nowPlaying:
            nowPlayingTableViewCell = cell
            cell.setData(movieModel: presenter?.nowPlayingMovie)
        case .topRated:
            topRatedTableViewCell = cell
            cell.setData(movieModel: presenter?.topRatedMovie)
        case .popular:
            popularTableViewCell = cell
            cell.setData(movieModel: presenter?.popularMovie)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableViewSectionHeaderCell.id) as? MainTableViewSectionHeaderCell else { return nil }
        switch section {
        case MainTableViewIndex.upcoming.value:
            cell.titleLabel.text = "Upcoming Movie"
        case MainTableViewIndex.topRated.value:
            cell.titleLabel.text = "Top Rated Movie"
        case MainTableViewIndex.nowPlaying.value:
            cell.titleLabel.text = "Now Playing Movie"
        case MainTableViewIndex.popular.value:
            cell.titleLabel.text = "Popular Movie"
        default:
            return nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
}

extension MovieView: MainTableViewCellDelegate {
    func loadmore(mainTableViewIndex: MainTableViewIndex, currentPage: Int) {
        presenter?.loadmore(section: mainTableViewIndex, currentPage: currentPage)
    }
    
    func navigateToMovieDetail(mainTableViewIndex: MainTableViewIndex, row: Int) {
        presenter?.navigateToMovieDetail(section: mainTableViewIndex, row: row)
    }
}
