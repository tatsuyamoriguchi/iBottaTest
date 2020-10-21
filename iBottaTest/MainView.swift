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
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(currentValueLabel)
        
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        
        likeButton.anchor(top: contentView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        
        nameLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        
        currentValueLabel.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)

        
    }
    
    
    let contentView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = ColorConvert().hexStringToUIColor(hex: "DFDFDF", alphaValue: 1.0)
        return iv
    }()
    
    
    
    let likeButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setTitle("🤍 Favorite?", for: .normal)
        
        return button
    }()
    
    let nameLabel: UILabel = {
       let labelName = UILabel()
        labelName.text = "Name"
        labelName.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        labelName.font = UIFont.init(name: "AvenirNext-Regular", size: 16)
        labelName.textAlignment = .left
        return labelName
    }()

    let descriptionLabel: UILabel = {
       let labelDescription = UILabel()
        labelDescription.text = "Description"
        labelDescription.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        labelDescription.font = UIFont.init(name: "AvenirNext-Regular", size: 16)
        labelDescription.textAlignment = .left
        return labelDescription
    }()

    let currentValueLabel: UILabel = {
       let labelCurrentValue = UILabel()
        labelCurrentValue.text = "Description"
        labelCurrentValue.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        labelCurrentValue.font = UIFont.init(name: "AvenirNext-Regular", size: 16)
        labelCurrentValue.textAlignment = .left
        return labelCurrentValue
    }()

    
    

}

