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
    let teams = [Team(image: "iu-1.jpg", name: "Banana"),
                 Team(image: "iu-2.jpg", name: "Peach"),
                 Team(image: "iu-3.jpg", name: "Kiwi"),
                 Team(image: "iu-4.jpg", name: "Grape"),
                 Team(image: "iu-5.jpg", name: "Apple"),
                 Team(image: "iu-6.jpg", name: "Pear"),
                 Team(image: "iu-7.jpg", name: "Passion Fruit"),
                 Team(image: "iu-8.jpg", name: "Lemon"),
                 Team(image: "iu-9.jpg", name: "Strawberry"),
                 Team(image: "iu-10.jpg", name: "Pomegranate"),
                 Team(image: "iu-11.jpg", name: "Watermelon"),
                 Team(image: "iu-12.jpg", name: "Orange"),
                 Team(image: "iu-13.jpg", name: "Blueberry"),
                 Team(image: "iu-14.jpg", name: "Blackberry"),
                 Team(image: "iu-15.jpg", name: "Cherry"),
                 Team(image: "iu-16.png", name: "Scotch Brite")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = ColorConvert().hexStringToUIColor(hex: "FFFFFF", alphaValue: 1.0)
        navigationItem.title = "iBottaTest"
        navigationController?.navigationBar.barTintColor = ColorConvert().hexStringToUIColor(hex: "ABFCD6", alphaValue: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        collectionView?.register(TeamCell.self, forCellWithReuseIdentifier: cellID)
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TeamCell
        cell.team = teams[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 16, height: 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
    }
    
    
}


class TeamCell: UICollectionViewCell {
    
    
    var team: Team? {
        
        didSet {
            guard let teamImage = team?.image else { return }
            guard let teamName = team?.name else { return }
            
            teamImageView.image = UIImage(named: teamImage)
            teamNameLabel.text = teamName
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
        
        self.addSubview(teamImageView)
        self.addSubview(teamNameLabel)
        
        
        teamImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 50)
        teamNameLabel.anchor(top: teamImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        
    }
    
    let teamImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = ColorConvert().hexStringToUIColor(hex: "DFDFDF", alphaValue: 1.0)
        return iv
    }()
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemented.")
    }
}

struct Team {
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

