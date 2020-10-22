//
//  CollectionViewCell.swift
//  iBottaTest
//
//  Created by Tatsuya Moriguchi on 10/20/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

// To map JSON data
struct Offer {
    let image: String?
    let name: String?
    let value: String?
}


class OfferCell: UICollectionViewCell {
    
    var offer: Offer? {
        
        didSet {
            guard let offerImage = offer?.image else { return }
            guard let offerValue = offer?.value else { return }
            guard let offerName = offer?.name else { return }
            
            offerImageView.image = UIImage(named: offerImage)
            offerValueLabel.text = offerValue
            offerNameLabel.text = offerName
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setCellShadow()
    }
    
    
    func setCellShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = 5
    }
    
    
    func setup() {
        self.backgroundColor = ColorConvert().hexStringToUIColor(hex: "FFFFFF", alphaValue: 1.0)
        
        self.addSubview(offerImageView)
        self.addSubview(offerValueLabel)
        self.addSubview(offerNameLabel)

        
        offerImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 120)
        
        offerValueLabel.anchor(top: offerImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        
        offerNameLabel.anchor(top: offerValueLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
    }
    
    
    let offerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = ColorConvert().hexStringToUIColor(hex: "DFDFDF", alphaValue: 1.0)
        return iv
    }()
    
    
    let offerValueLabel: UILabel = {
        let labelValue = UILabel()
        labelValue.text = "Current Value"
        labelValue.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        labelValue.font = UIFont.init(name: "AvenirNext-DemiBold", size: 12)
        labelValue.textAlignment = .left
        return labelValue
    }()
    
    let offerNameLabel: UILabel = {
        let labelName = UILabel()
        labelName.text = "Name"
        labelName.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        labelName.font = UIFont.init(name: "AvenirNext-Regular", size: 11)
        labelName.textAlignment = .left
        return labelName
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemented.")
    }
}



extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }
    
}

