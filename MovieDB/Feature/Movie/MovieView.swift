//
//  MovieView.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 13/11/22.
//

import Foundation
import UIKit
import SkeletonView

class MovieView: UIViewController {
    
    //MARK: Properties
    private let bundle = Bundle(for: MovieView.self)
    private let className = String(describing: MovieView.self)
    private var loader: LoaderView?
    private var upcomingTableViewCell: MainTableViewCell?
    private var topRatedTableViewCell: MainTableViewCell?
    private var nowPlayingTableViewCell: MainTableViewCell?
    private var popularTableViewCell: MainTableViewCell?
    
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
        title = "Movie"
        presenter?.viewDidLoad()
    }
}

extension MovieView: MoviePresenterToView {
    
    func setupTableView() {
        mainTableView.register(UINib(nibName: MainTableViewSectionHeaderCell.id,
                                     bundle: .main),
                               forHeaderFooterViewReuseIdentifier: MainTableViewSectionHeaderCell.id)
        mainTableView.register(UINib(nibName: MainTableViewCell.id, bundle: .main),
                               forCellReuseIdentifier: MainTableViewCell.id)
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    func reloadSection(_ section: MainTableViewIndex) {
        mainTableView.reloadSections([section.value], with: .automatic)
    }
    
    func reload() {
        mainTableView.reloadData()
    }
    
    func loadMore(by mainTableViewIndex: MainTableViewIndex) {
        switch mainTableViewIndex {
        case .upcoming:
            upcomingTableViewCell?.setData(movieModel: presenter?.upcomingMovie)
            upcomingTableViewCell?.hideSkeleton()
        case .popular:
            popularTableViewCell?.setData(movieModel: presenter?.popularMovie)
            popularTableViewCell?.hideSkeleton()
        case .nowPlaying:
            nowPlayingTableViewCell?.setData(movieModel: presenter?.nowPlayingMovie)
            nowPlayingTableViewCell?.hideSkeleton()
        case .topRated:
            topRatedTableViewCell?.setData(movieModel: presenter?.topRatedMovie)
            topRatedTableViewCell?.hideSkeleton()
        }
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
            upcomingTableViewCell?.isSkeletonable = true
            cell.setData(movieModel: presenter?.upcomingMovie)
        case .nowPlaying:
            nowPlayingTableViewCell = cell
            nowPlayingTableViewCell?.isSkeletonable = true
            cell.setData(movieModel: presenter?.nowPlayingMovie)
        case .topRated:
            topRatedTableViewCell = cell
            topRatedTableViewCell?.isSkeletonable = true
            cell.setData(movieModel: presenter?.topRatedMovie)
        case .popular:
            popularTableViewCell = cell
            popularTableViewCell?.isSkeletonable = true
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
        switch mainTableViewIndex {
        case .upcoming:
            upcomingTableViewCell?.showAnimatedGradientSkeleton()
        case .popular:
            popularTableViewCell?.showAnimatedGradientSkeleton()
        case .nowPlaying:
            nowPlayingTableViewCell?.showAnimatedGradientSkeleton()
        case .topRated:
            topRatedTableViewCell?.showAnimatedGradientSkeleton()
        }
        presenter?.loadmore(section: mainTableViewIndex, currentPage: currentPage)
    }
    
    func navigateToMovieDetail(mainTableViewIndex: MainTableViewIndex, row: Int) {
        presenter?.navigateToMovieDetail(section: mainTableViewIndex, row: row)
    }
}
