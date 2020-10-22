//
//  ViewController.swift
//  iBottaTest
//
//  Created by Tatsuya Moriguchi on 10/19/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    

    // MARK: - Properties
    let cellID = "cellID"
    var offers: [ItemOffer]?
    var selectedOffer: ItemOffer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Read local JSON file
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
        // Display collectionview cells in two columns
        //  CollectionView cells are forced to display in one column when rotating to landscape
        //  then rotating back to Portrait.
        //  iPhone SE2 simulator doesn't show this issue, but other larger display iPhone Simulators do.
        //  Unable to fix this for now.
        /*  Error message:
         2020-10-22 10:52:47.014999-0700 iBottaTest[1098:32853] The behavior of the UICollectionViewFlowLayout is not defined because:
         2020-10-22 10:52:47.015238-0700 iBottaTest[1098:32853] the item width must be less than the width of the UICollectionView minus the section insets left and right values, minus the content insets left and right values.
         2020-10-22 10:52:47.015637-0700 iBottaTest[1098:32853] The relevant UICollectionViewFlowLayout instance is <UICollectionViewFlowLayout: 0x7fc951707e80>, and it is attached to <UICollectionView: 0x7fc952020800; frame = (0 0; 414 896); clipsToBounds = YES; autoresize = W+H; gestureRecognizers = <NSArray: 0x60000386c120>; animations = { position=<CABasicAnimation: 0x600003663b00>; bounds.origin=<CABasicAnimation: 0x60000365e660>; bounds.size=<CABasicAnimation: 0x60000365e6e0>; bounds.origin-2=<CABasicAnimation: 0x600003682ea0>; bounds.size-2=<CABasicAnimation: 0x600003682120>; bounds.origin-3=<CABasicAnimation: 0x60000367efc0>; bounds.size-3=<CABasicAnimation: 0x60000367e560>; }; layer = <CALayer: 0x6000036607e0>; contentOffset: {0, 944}; contentSize: {896, 12546}; adjustedContentInset: {88, 0, 34, 0}; layout: <UICollectionViewFlowLayout: 0x7fc951707e80>; dataSource: <iBottaTest.ViewController: 0x7fc9516094d0>>.
         2020-10-22 10:52:47.028486-0700 iBottaTest[1098:32853] Make a symbolic breakpoint at UICollectionViewFlowLayoutBreakForInvalidSizes to catch this in the debugger.

         */
        return CGSize(width: (view.frame.width / 2) - 16, height: 180)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


        // Show DetailsViewController view when tapping an item
        let rootVC = DetailsViewController()
        let navVC = UINavigationController(rootViewController: rootVC)

        // To pass TemOffer type data to DetailsViewController
        rootVC.selectedOffer = offers?[indexPath.item]

        present(navVC, animated: true)
        
        
    }
}

// MARK: - Extension
// To check if url data is not nil, then convert url string data to URL to display image in collection view cell
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

