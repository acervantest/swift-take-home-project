//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-01.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String?
    var followers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerViewCell.self, forCellWithReuseIdentifier: FollowerViewCell.reuseId)
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username!, page: 1) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { 
            (collectionView, indexPath, follower) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerViewCell.reuseId, for: indexPath) as! FollowerViewCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
