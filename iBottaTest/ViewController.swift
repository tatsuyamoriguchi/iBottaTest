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
    
    // Access to Offers.json file, decode JSON
    static func readJSONFromFile() -> [Offer]? {

        // url to a local json file
        if let path = Bundle.main.path(forResource: "Offers", ofType: "json") {
        let fileUrl = URL(fileURLWithPath: path)
            
            do {
                // Getting data from JSON file
                let data = try Data(contentsOf: fileUrl)
                // Decode json format data to Offer codable
                let decoder = JSONDecoder()
                let json = try decoder.decode([Offer].self, from: data)
                // For test to see the json contents in console
                    print("json: ")
                    print(json as Any)
                    print("**********")

                return json

            } catch {
                // Handle error here
                print("ERROR: \(error)")
            }
        }
        return nil
    }
    
    
    /*
     // JSON data sample
     {
     "id":"110579",
     "url":"https://product-images.ibotta.com/offer/dUxYcQPeq391-DiywFZF8g-normal.png",
     "name":"Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges",
     "description":"Any variety - 2 ct. pack or larger",
     "terms":"Rebate valid on Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges for any variety, 2 ct. pack or larger.",
     "current_value":"$0.75 Cash Back"}
     */
    
    // Map json data
    struct Offer: Codable {
        var id: String?
        var url: String?
        var name: String?
        var description: String?
        var terms: String?
        var current_value: String?
    }
    
    
    
    
    
    var offers: [Offer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        offers = ViewController.readJSONFromFile()

        collectionView?.backgroundColor = ColorConvert().hexStringToUIColor(hex: "FFFFFF", alphaValue: 1.0)
        navigationItem.title = "iBottaTest Offers"
        navigationController?.navigationBar.barTintColor = ColorConvert().hexStringToUIColor(hex: "ABFCD6", alphaValue: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        collectionView?.register(OfferCell.self, forCellWithReuseIdentifier: cellID)
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! OfferCell
        
        guard let offerItem = offers?[indexPath.item] else { return cell }
        cell.offerNameLabel.text = offerItem.name
        if offerItem.url != nil {
            cell.offerImageView.image = UIImage(url: URL(string: offerItem.url!))
        } else { print("No offerItem found") }
        
        
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
        label.font = UIFont.init(name: "Avenir", size: 14)
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


extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }
            
    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}

