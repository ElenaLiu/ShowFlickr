//
//  ViewController.swift
//  AjHW
//
//  Created by 劉芳瑜 on 2019/3/4.
//  Copyright © 2019 Fang-Yu. Liu. All rights reserved.
//

import UIKit
import SnapKit

class MainController: UIViewController {
    
    // MARK: Properties
    let stackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.distribution = .fillEqually
        sv.axis = .vertical
        sv.spacing = 20
        return sv
    }()
    
    lazy var contentTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.layer.borderWidth = 0.3
        tf.placeholder = "  欲搜尋的內容"
        tf.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        tf.layer.cornerRadius = 10
        tf.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        tf.setLeftPaddingPoints(10)
        tf.setRightPaddingPoints(10)
        return tf
    }()
    
    lazy var numberTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.layer.borderWidth = 0.3
        tf.placeholder = "  每頁呈現數量"
        tf.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        tf.layer.cornerRadius = 10
        tf.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        tf.setLeftPaddingPoints(10)
        tf.setRightPaddingPoints(10)
        return tf
    }()
    
    lazy var searchBtn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("搜尋", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        btn.isSelected = false
        btn.addTarget(self, action: #selector(pustTo), for: .touchUpInside)
        return btn
    }()
    
    var isContentFieldHasValue = false
    var isNumberFieldHasValue = false
    
    // MARK: Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc private func pustTo() {
        guard let text = contentTextField.text,
            let perPage = Int(numberTextField.text ?? "") else { return }

        self.navigationController?.pushViewController(TabBarController(text: text, perPage: perPage), animated: true)
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
    
    @objc func textChanged(sender: UITextField) {
        if !contentTextField.text!.isEmpty && !numberTextField.text!.isEmpty  {
            self.searchBtn.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        } else {
            self.searchBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
