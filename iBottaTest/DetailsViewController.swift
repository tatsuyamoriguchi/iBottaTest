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
        view.backgroundColor = .systemPink
        title = "Offer Details View"
        
        mainView.likeAction = { [weak self] in self?.likeAction() }
            
        
        
        print(selectedOffer?.current_value)
        print(selectedOffer?.description)
        print(selectedOffer?.name)
        print(selectedOffer?.terms)
        print(selectedOffer?.url)
        print(selectedOffer?.id)
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        
        
    }
    
    
        private func likeAction() {
            self.liked = !self.liked
            if self.liked {
                UIView.animate(withDuration: 0.5, animations:  {
                    self.mainView.likeButton.setTitle("Dislike", for: .normal)
                    self.mainView.contentView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                })
            } else {
                UIView.animate(withDuration: 0.5, animations:  {
                    self.mainView.likeButton.setTitle("Like", for: .normal)
                    self.mainView.contentView.backgroundColor = .clear
                })
                
            }
        }
        
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped() {
        
        
        
    }
    
    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
    }
    
}


