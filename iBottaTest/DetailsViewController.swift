//
//  DetailsViewController.swift
//  iBottaTest
//
//  Created by Tatsuya Moriguchi on 10/20/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var mainView: MainView { return self.view as! MainView }
    
    var liked = false
    var selectedOffer: ItemOffer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Offer Details View"
        

        mainView.likeAction = { [weak self] in self?.likeAction() }
        
//        print(selectedOffer?.url)
//        print(selectedOffer?.name)
//        print(selectedOffer?.description)
//        print(selectedOffer?.current_value)
//        print(selectedOffer?.terms)
//        print(selectedOffer?.id)

        if selectedOffer?.url != nil, selectedOffer?.name != nil, selectedOffer?.description != nil, selectedOffer?.current_value != nil, selectedOffer?.terms != nil, selectedOffer?.id != nil {

            self.mainView.contentView.image = UIImage(url: URL(string: (selectedOffer?.url)!))
            self.mainView.nameLabel.text = "Product Name: " + ((selectedOffer?.name)!)
            self.mainView.descriptionLabel.text = "Description: " + (selectedOffer?.description)!
            self.mainView.currentValueLabel.text = "Offer: " + (selectedOffer?.current_value)!
            self.mainView.termsLabel.text = "Terms: " + (selectedOffer?.terms)!
            self.mainView.idLabel.text = "Product ID: " + (selectedOffer?.id)!

        } else {
            print("ERROR: Some data is not available.")
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
    
    }
    
    
    
    private func likeAction() {
        self.liked = !self.liked
        if self.liked {
            UIView.animate(withDuration: 0.5, animations:  {
                self.mainView.likeButton.setTitle("♥️ My Favorite", for: .normal)
                self.mainView.contentView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            })
        } else {
            UIView.animate(withDuration: 0.5, animations:  {
                self.mainView.likeButton.setTitle("🤍 Favorite?", for: .normal)
                self.mainView.contentView.backgroundColor = .clear
            })
        }
    }
        
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
        
    }
    
}



