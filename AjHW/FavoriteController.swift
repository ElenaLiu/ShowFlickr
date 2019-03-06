//
//  FavoriteController.swift
//  AjHW
//
//  Created by 劉芳瑜 on 2019/3/6.
//  Copyright © 2019 Fang-Yu. Liu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ShowInfoCell"

class FavoriteController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // MARK: Properties
    let space: CGFloat = 5
    
    var photos: [photo] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        layout.minimumLineSpacing = space
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.collectionView.backgroundColor = .white
        // Register cell classes
        self.collectionView!.register(ShowInfoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - self.space*3)/2, height: self.view.frame.width/2)
    }
}

