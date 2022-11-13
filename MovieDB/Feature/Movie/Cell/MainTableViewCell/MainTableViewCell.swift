//
//  MainTableViewCell.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 13/11/22.
//

import Foundation
import UIKit

enum MainTableViewIndex: Int {
    case upcoming = 0
    case topRated = 1
    case nowPlaying = 2
    case popular = 3
    
    var value: Int {
        return rawValue
    }
}

class MainTableViewCell: UITableViewCell {
    
    //MARK: Properties
    static let id = String(describing: MainTableViewCell.self)
    private var mainTableViewIndex: MainTableViewIndex = .upcoming
    private var model: MovieModel?
    
    //MARK: IBOutlets
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    //MARK: Functions
    private func setupCollectionView() {
        mainCollectionView.register(UINib(nibName: MainCollectionViewCell.id, bundle: .main),
                                    forCellWithReuseIdentifier: MainCollectionViewCell.id)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
    
    func setup(section: MainTableViewIndex) {
        mainTableViewIndex = section
        
    }
}

extension MainTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        cell.shadowDecorate()
        return cell
    }

}
