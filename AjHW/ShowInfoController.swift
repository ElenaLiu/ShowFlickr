//
//  ShowInfoController.swift
//  AjHW
//
//  Created by 劉芳瑜 on 2019/3/5.
//  Copyright © 2019 Fang-Yu. Liu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ShowInfoCell"

class ShowInfoController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // MARK: Properties
    let space: CGFloat = 5
    var photoResponse: Photos? = nil {
        didSet {
            let favorites = CoreDataManager.shared.fetchFavorites() ?? []
            let urls = favorites.compactMap { $0.imageURLString }
            
            photoResponse?.photo.forEach({ (photo) in
                var newPhoto = photo
                newPhoto.isFavorite = urls.contains(photo.imageURLString)
                self.photos.append(newPhoto)
            })
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    var photos: [photo] = []
    var keyword: String
    var perPage: Int
    var isWating: Bool = false
    
    init(text: String, perPage: Int) {
        self.keyword = text
        self.perPage = perPage
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        layout.minimumLineSpacing = space
        APIManager.shared.getPhotos(text, perPage) { (photoResponse, error) in
            if let _ = error {
                return
            }
            
            if let photoResponse = photoResponse {
                self.photoResponse = photoResponse
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.collectionView.backgroundColor = .white
        // Register cell classes
        self.collectionView!.register(ShowInfoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShowInfoCell
    
        // Configure the cell
        cell.setImage(photos[indexPath.row].imageURLString)
        cell.setTitle(photos[indexPath.row].title)
        cell.favoriteBtn.isSelected = photos[indexPath.row].isFavorite ?? false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - self.space*3)/2, height: self.view.frame.width/2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let isScrolledBottom = (indexPath.row == (self.photos.count - 1))
        
        if isScrolledBottom {
            self.isWating = true
            APIManager.shared.getPhotos(keyword, perPage, (self.photoResponse?.page ?? 0) + 1) {[weak self] (photoResponse, error) in
                
                guard let weakSelf = self else {
                    return
                }
                
                weakSelf.isWating = false
                if let _ = error {
                    return
                }
                
                if let photoResponse = photoResponse {
                    weakSelf.photoResponse = photoResponse
                }
            }
        }
    }
}

