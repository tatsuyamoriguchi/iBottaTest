//
//  ViewController.swift
//  iBottaTest
//
//  Created by Tatsuya Moriguchi on 10/19/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"
    let offers = [Offer(image: "iu-1.jpg", name: "Banana"),
                 Offer(image: "iu-2.jpg", name: "Peach"),
                 Offer(image: "iu-3.jpg", name: "Kiwi"),
                 Offer(image: "iu-4.jpg", name: "Grape"),
                 Offer(image: "iu-5.jpg", name: "Apple"),
                 Offer(image: "iu-6.jpg", name: "Pear"),
                 Offer(image: "iu-7.jpg", name: "Passion Fruit"),
                 Offer(image: "iu-8.jpg", name: "Lemon"),
                 Offer(image: "iu-9.jpg", name: "Strawberry"),
                 Offer(image: "iu-10.jpg", name: "Pomegranate"),
                 Offer(image: "iu-11.jpg", name: "Watermelon"),
                 Offer(image: "iu-12.jpg", name: "Orange"),
                 Offer(image: "iu-13.jpg", name: "Blueberry"),
                 Offer(image: "iu-14.jpg", name: "Blackberry"),
                 Offer(image: "iu-15.jpg", name: "Cherry"),
                 Offer(image: "iu-16.png", name: "Scotch Brite")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = ColorConvert().hexStringToUIColor(hex: "FFFFFF", alphaValue: 1.0)
        navigationItem.title = "iBottaTest"
        navigationController?.navigationBar.barTintColor = ColorConvert().hexStringToUIColor(hex: "ABFCD6", alphaValue: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        collectionView?.register(OfferCell.self, forCellWithReuseIdentifier: cellID)
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! OfferCell
        cell.offer = offers[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 16, height: 150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
    }
    
    
}


class OfferCell: UICollectionViewCell {
    
    
    var offer: Offer? {
        
        didSet {
            guard let offerImage = offer?.image else { return }
            guard let offerName = offer?.name else { return }
            
            offerImageView.image = UIImage(named: offerImage)
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
        self.addSubview(offerNameLabel)
        
        
        offerImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        offerNameLabel.anchor(top: offerImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        
    }
    
    let offerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = ColorConvert().hexStringToUIColor(hex: "DFDFDF", alphaValue: 1.0)
        return iv
    }()
    
    let offerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        label.font = UIFont.init(name: "Avenir", size: 14) //.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemented.")
    }
}

struct Offer {
    let image: String?
    let name: String?
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

