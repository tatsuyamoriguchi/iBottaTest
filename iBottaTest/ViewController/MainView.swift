//
//  MainView.swift
//  iBottaTest
//
//  Created by Tatsuya Moriguchi on 10/21/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

// class name MainView may be mis-leading
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
    
    // Add scrollview, product data, and layout
    func setup() {
        self.backgroundColor = ColorConvert().hexStringToUIColor(hex: "FFFFFF", alphaValue: 1.0)
        
        self.addSubview(scrollView)

        scrollView.addSubview(contentView)
        scrollView.addSubview(likeButton)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(currentValueLabel)
        scrollView.addSubview(termsLabel)
        scrollView.addSubview(idLabel)

        
        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        contentView.anchor(top: scrollView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        likeButton.anchor(top: contentView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        
        currentValueLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)

        termsLabel.anchor(top: currentValueLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)

 
        nameLabel.anchor(top: termsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)

        idLabel.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)

    }
    
    // Product image
    lazy var contentView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = ColorConvert().hexStringToUIColor(hex: "DFDFDF", alphaValue: 1.0)
        return iv
    }()
    
    
    // Favorite button
    let likeButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setTitle("🤍 Favorite?", for: .normal)
        
        return button
    }()
    
    // Product name
    let nameLabel: UILabel = {
       let labelName = UILabel()
        labelName.text = "Name"
        labelName.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        labelName.font = UIFont.init(name: "AvenirNext-Regular", size: 16)
        labelName.textAlignment = .left
        labelName.numberOfLines = 0
        return labelName
    }()

    // Product description
    let descriptionLabel: UILabel = {
       let labelDescription = UILabel()
        labelDescription.text = "Description"
        labelDescription.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        labelDescription.font = UIFont.init(name: "AvenirNext-Regular", size: 16)
        labelDescription.textAlignment = .left
        labelDescription.numberOfLines = 0
        return labelDescription
    }()

    // Product offer value
    let currentValueLabel: UILabel = {
       let labelCurrentValue = UILabel()
        labelCurrentValue.text = "Current Value"
        labelCurrentValue.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        labelCurrentValue.font = UIFont.init(name: "AvenirNext-Regular", size: 20)
        labelCurrentValue.textAlignment = .left
        labelCurrentValue.numberOfLines = 0
        return labelCurrentValue
    }()

    // Product offer terms
    let termsLabel: UILabel = {
       let labelTerms = UILabel()
        labelTerms.text = "Terms"
        labelTerms.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        labelTerms.font = UIFont.init(name: "AvenirNext-Regular", size: 16)
        labelTerms.textAlignment = .left
        labelTerms.numberOfLines = 0
        return labelTerms
    }()

    // Product ID, I assume this is immutable and non-optional
    let idLabel: UILabel = {
       let labelID = UILabel()
        labelID.text = "ID"
        labelID.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        labelID.font = UIFont.init(name: "AvenirNext-Regular", size: 16)
        labelID.textAlignment = .left
        return labelID
    }()

    // Scroll view set its height to +800, not dynamically changes its height
    let scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.frame = scrollV.bounds
        scrollV.translatesAutoresizingMaskIntoConstraints = false
        scrollV.contentSize = CGSize(width: scrollV.frame.width, height: scrollV.frame.height + 800)
        //scrollV.setContentOffset(CGPoint(x: 0, y: 1000), animated: true)
        
        return scrollV
    }()
    
}
