//
//  ViewController.swift
//  AjHW
//
//  Created by 劉芳瑜 on 2019/3/4.
//  Copyright © 2019 Fang-Yu. Liu. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    let stackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.distribution = .fillEqually
        sv.axis = .vertical
        sv.spacing = 20
        return sv
    }()
    
    let contentTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.layer.borderWidth = 0.5
        tf.placeholder = "  欲搜尋的內容"
        tf.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        tf.layer.cornerRadius = 10
        tf.font = UIFont(name: "Chalkduster", size: 18)
        return tf
    }()
    
    let numberTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.layer.borderWidth = 0.5
        tf.placeholder = "  每頁呈現數量"
        tf.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        tf.layer.cornerRadius = 10
        tf.font = UIFont(name: "Chalkduster", size: 18)
        return tf
    }()
    
    lazy var searchBtn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("搜尋", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        btn.isSelected = false
        btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        return btn
    }()
    
    // MARK: Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.title = "搜尋輸入頁"
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(contentTextField)
        self.stackView.addArrangedSubview(numberTextField)
        self.stackView.addArrangedSubview(searchBtn)
        
        stackView.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.leading.equalToSuperview().offset(16)
            m.trailing.equalToSuperview().offset(-16)
            m.height.equalTo(200)
            
        }
    }
}

