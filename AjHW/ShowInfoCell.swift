//
//  ShowInfoCell.swift
//  AjHW
//
//  Created by 劉芳瑜 on 2019/3/5.
//  Copyright © 2019 Fang-Yu. Liu. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

protocol ShowInfoCellDelegate: class {
    func updatedData()
}
class ShowInfoCell: UICollectionViewCell {
    // MARK: Properties
    static let notification = "update"
    var urlString: String = ""
    
    var title: String = ""
    
    weak var delegate: ShowInfoCellDelegate?
    
    private let titleLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    lazy var favoriteBtn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setImage(#imageLiteral(resourceName: "like"), for: .selected)
        btn.setImage(#imageLiteral(resourceName: "unlike"), for: .normal)
        btn.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self,
                                       selector: #selector(updateFavoriteStatus),
                                       name: NSNotification.Name(rawValue: ShowInfoCell.notification),
                                       object: nil)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    @objc private func updateFavoriteStatus(notifictation: Notification) {
        if let status = notifictation.object as? (String, Bool) {
            if status.0 == urlString {
                self.favoriteBtn.isSelected = status.1
            }
        }
    }
    
    private func setupViews() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(favoriteBtn)
        self.contentView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (m) in
            m.top.trailing.leading.equalToSuperview()
            m.bottom.equalTo(titleLabel.snp.top).offset(-5)
        }
        
        titleLabel.snp.makeConstraints { (m) in
            m.bottom.leading.equalToSuperview()
            m.trailing.equalTo(favoriteBtn.snp.leading).offset(-5)
            m.height.equalTo(50)
        }
        
        favoriteBtn.snp.makeConstraints { (m) in
            m.centerY.equalTo(titleLabel)
            m.trailing.equalToSuperview().offset(-5)
            m.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
    
    @objc private func favoriteTapped() {
        favoriteBtn.isSelected = !favoriteBtn.isSelected
        if favoriteBtn.isSelected {
            //save
            CoreDataManager.shared.createFavorite(urlString, title)
            delegate?.updatedData()
        } else {
           //delete
            CoreDataManager.shared.deleteFavorite(urlString)
            delegate?.updatedData()
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ShowInfoCell.notification),
                                        object: (urlString, favoriteBtn.isSelected))
    }
    
    func setImage(_ string: String) {
        guard let url = URL(string: string) else {
            return
        }
        self.urlString = string
        self.imageView.sd_setImage(with: url, completed: nil)
    }
    
    func setTitle(_ text: String) {
        self.title = text
        self.titleLabel.text = text
    }
}
