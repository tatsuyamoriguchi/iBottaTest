//
//  MainView.swift
//  iBottaTest
//
//  Created by Tatsuya Moriguchi on 10/21/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    var likeAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
//        setupViews()
//        setupConstraints()
        setup()
        
        addAction()

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAction() {
        likeButton.addTarget(self, action: #selector(self.onLikeButton), for: .touchUpInside)
    }
    
    @objc func onLikeButton() {
        likeAction?()
        
    }
    
    
    func setup() {
         self.backgroundColor = ColorConvert().hexStringToUIColor(hex: "FFFFFF", alphaValue: 1.0)
         
         self.addSubview(contentView)
         self.addSubview(likeButton)
         
         contentView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
         
         likeButton.anchor(top: contentView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
         
      }
    
    
//    func setupViews() {
//        self.addSubview(contentView)
//        self.addSubview(likeButton)
//
//    }
//
//    func setupConstraints() {
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
//        contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
//        contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
//
//        likeButton.translatesAutoresizingMaskIntoConstraints = false
//        likeButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
//        likeButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
//
//
//    }
    
    
    
    
//    let contentView: UIView = {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        view.layer.borderWidth = 1.0
//        view.layer.borderColor = UIColor.lightGray.cgColor
//        return view
//    }()
    
    let contentView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = ColorConvert().hexStringToUIColor(hex: "DFDFDF", alphaValue: 1.0)
        return iv
    }()
    
    
    let likeButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setTitle("Like", for: .normal)
        return button
    }()
    
    
}

