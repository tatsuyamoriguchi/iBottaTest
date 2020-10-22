//
//  DetailsViewController.swift
//  iBottaTest
//
//  Created by Tatsuya Moriguchi on 10/20/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    var mainView: MainView { return self.view as! MainView }
    var liked = false
    var selectedOffer: ItemOffer?
 
    
    // Data
    var likeData: Bool?
    var aLike: Like?
    
    
    // Assuming that JSON file data format is immutable, I decided to use Core Data to keep track of
    // Favorite data associated with product ID, which I assume non-optional
    func fetchData(itemOffer: String)  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        // Reference to managed object context
        let context = appDelegate.persistentContainer.viewContext
        do {
             let fetchRequest : NSFetchRequest<Like> = Like.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", itemOffer as CVarArg)
             let fetchedResults = try context.fetch(fetchRequest)
            aLike = fetchedResults.first

            if (aLike != nil) {
                liked = true

             } else {
                // if no data found, assign false to liked
                liked = false
            }
         }
         catch {
             print ("fetch task failed", error)
         }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Offer Details View"
        
        guard let itemOffer = selectedOffer?.id else { return }
        // Get  data from Core Data
        self.fetchData(itemOffer: itemOffer)

        DispatchQueue.main.async {
            if self.liked == true {
                // If there is data in Core Data entity, which means a user pressed Favorite button in the past
                // Change background color and heart icon to red
                self.mainView.likeButton.setTitle("♥️ My Favorite", for: .normal)
                self.mainView.contentView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
              
            } else {
                print("no id found in CoreData.")
            }
        }

        mainView.likeAction = { [weak self] in self?.likeAction() }

        // Load JSON data to UI
        if selectedOffer?.url != nil, selectedOffer?.name != nil, selectedOffer?.description != nil, selectedOffer?.current_value != nil, selectedOffer?.terms != nil, selectedOffer?.id != nil {

            self.mainView.contentView.image = UIImage(url: URL(string: (selectedOffer?.url)!))
            self.mainView.nameLabel.text = selectedOffer?.name
            self.mainView.descriptionLabel.text = selectedOffer?.description
            self.mainView.currentValueLabel.text = "Offer: " + (selectedOffer?.current_value)!
            self.mainView.termsLabel.text = "Terms: " + (selectedOffer?.terms)!
            self.mainView.idLabel.text = "ID: " + (selectedOffer?.id)!

        } else {
            print("ERROR: Some data is not available.")
        }

        // Back button to go back to ViewController UI. Swiping also let you go back there.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backTapped)) //UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backTapped))
    
    }
    
    
    // Function to press Favorite button
    private func likeAction() {
        self.liked = !self.liked
        if self.liked {
            
            UIView.animate(withDuration: 0.5, animations:  {
                print("liked executed")
                self.mainView.likeButton.setTitle("♥️ My Favorite", for: .normal)
                self.mainView.contentView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                
                if self.selectedOffer?.id != nil {
                    // Save to Core Data if a user pressed Favorite button
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                    // Reference to managed object context
                    let context = appDelegate.persistentContainer.viewContext
                    
                    let newLikeItem = Like(context: context)
                    newLikeItem.id = self.selectedOffer?.id
                    newLikeItem.like = true
                    
                    do {
                        try context.save()
                    } catch {
                        print("Error while saving data.")
                    }
                    
                    
                } else {
                    print("selectedOffer.id is not available.")
                }
            })
        } else {
            
            UIView.animate(withDuration: 0.5, animations:  {
                print("unliked executed")
                self.mainView.likeButton.setTitle("🤍 Favorite?", for: .normal)
                self.mainView.contentView.backgroundColor = .clear
                if self.selectedOffer?.id != nil {
                    
                    // Delete Core Data data if a user reverted Favorite to Not Favorite
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                    // Reference to managed object context
                    let context = appDelegate.persistentContainer.viewContext
                    let predicate = NSPredicate(format: "id == %@", (self.selectedOffer?.id)! as CVarArg)
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Like")
                    fetchRequest.predicate = predicate
                    
                    do {
                        let fetchedResults = try context.fetch(fetchRequest) as! [Like]
                        if let entityToDelete = fetchedResults.first {
                            context.delete(entityToDelete)
                            
                            print("deleted entityToDelete")
                            print(entityToDelete)
                            
                            DispatchQueue.main.async {
                                do {
                                    try context.save()
                                } catch {
                                    print("Error when saving context")
                                }
                            }
                        }
                    } catch {
                        print("Error while deleting")
                    }
                    
                } else {
                    print("selectedOffer.id is not available.")
                }
            })
        }
    }
    
    
    @objc func backTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
        
    }
    
}
