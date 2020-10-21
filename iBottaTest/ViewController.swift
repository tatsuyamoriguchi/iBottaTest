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
    var offers: [ItemOffer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Store JSON data to offers
        offers = ViewController.readJSONFromFile()

        collectionView?.backgroundColor = ColorConvert().hexStringToUIColor(hex: "FFFFFF", alphaValue: 1.0)
        
        
        navigationItem.title = "iBottaTest Offers"
        navigationController?.navigationBar.barTintColor = ColorConvert().hexStringToUIColor(hex: "ABFCD6", alphaValue: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        collectionView?.register(OfferCell.self, forCellWithReuseIdentifier: cellID)

    }

    
    // Access to Offers.json file, decode JSON
    static func readJSONFromFile() -> [ItemOffer]? {

        // url to a local json file
        if let path = Bundle.main.path(forResource: "Offers", ofType: "json") {
        let fileUrl = URL(fileURLWithPath: path)
            
            do {
                // Getting data from JSON file
                let data = try Data(contentsOf: fileUrl)
                // Decode json format data to Offer codable
                let decoder = JSONDecoder()
                let json = try decoder.decode([ItemOffer].self, from: data)
                return json

            } catch {
                // Handle error here
                print("ERROR: \(error)")
            }
        }
        return nil
    }
    
    // MARK: - Collection View
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! OfferCell
        guard let offerItem = offers?[indexPath.item] else { return cell }
        
        if offerItem.url != nil {
            cell.offerImageView.image = UIImage(url: URL(string: offerItem.url!))
        } else { print("No offerItem found") }
        cell.offerValueLabel.text = offerItem.current_value
        cell.offerNameLabel.text = offerItem.name

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 16, height: 180)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        
        let rootVC = DetailsViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        //navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        
    }
    
    
}



// to check if url data is not nil, then convert url string data to URL to display image in collection view cell
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

