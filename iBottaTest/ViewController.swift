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

        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView?.backgroundColor = ColorConvert().hexStringToUIColor(hex: "FFFFFF", alphaValue: 1.0)
            navigationItem.title = "Teams"
            navigationController?.navigationBar.barTintColor = ColorConvert().hexStringToUIColor(hex: "ABFCD6", alphaValue: 1.0)
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
            
            collectionView?.register(TeamCell.self, forCellWithReuseIdentifier: cellID)
            
        
            
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 6
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TeamCell
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
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        func setup() {
            self.backgroundColor = ColorConvert().hexStringToUIColor(hex: "4A4A4A", alphaValue: 1.0)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not implemented.")
        }
    }




