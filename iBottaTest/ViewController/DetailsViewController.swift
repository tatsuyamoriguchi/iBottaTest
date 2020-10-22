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
    
    
    
    func fetchData(itemOffer: String)  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        // Reference to managed object context
        let context = appDelegate.persistentContainer.viewContext
        do {
             let fetchRequest : NSFetchRequest<Like> = Like.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", itemOffer as CVarArg)
             let fetchedResults = try context.fetch(fetchRequest)
             //if let aContact = fetchedResults.first {
            aLike = fetchedResults.first

            if (aLike != nil) {
                liked = true
                print("aLike")
                print(aLike?.id as Any)
                print(aLike?.like as Any)
             } else {
                liked = false
            }
         }
         catch {
             print ("fetch task failed", error)
         }
        
//        // Cast the result returned from the fetchRequest as Person class
//         let fetchRequest = NSFetchRequest<Like>(entityName: "Like")
////        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Like")
//
//        // fetch records which match this condition
//        fetchRequest.predicate = NSPredicate(format: "id == %@", itemOffer.id! as CVarArg)
//
//        if (fetchRequest.predicate != nil) {
//            likeData = true
//        } else {
//            likeData = false
//        }
//
//        do {
//            try context.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//
//        do {
//            localData = try context.fetch(Like.fetchRequest())
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    
    /*
     var contactIdentifierString = ""

     func userSelectedContact(contactIdentifier: String) {

         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

         do {
             let fetchRequest : NSFetchRequest<Contact> = Contact.fetchRequest()
             fetchRequest.predicate = NSPredicate(format: "uniqueId == %@", contactIdentifier)
             let fetchedResults = try context.fetch(fetchRequest) as! [Contact]
             if let aContact = fetchedResults.first {
                providerName.text = aContact.providerName
             }
         }
         catch {
             print ("fetch task failed", error)
         }

     }
     */
    
/*
     var people : [Person] = []

     guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
         return
     }

     let context = appDelegate.persistentContainer.viewContext

     // Cast the result returned from the fetchRequest as Person class
     let fetchRequest = NSFetchRequest<Person>(entityName: "Person")

     // fetch records which match this condition
     fetchRequest.predicate = NSPredicate(format: "money > %i", 100)

     do {
       people = try context.fetch(fetchRequest)
     } catch let error as NSError {
       print("Could not fetch. \(error), \(error.userInfo)")
     }
     */
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Offer Details View"
        
        // Get selectedItemLike data from Core Data
        guard let itemOffer = selectedOffer?.id else { return }
        self.fetchData(itemOffer: itemOffer)
        DispatchQueue.main.async {
            if self.liked == true {
                print("********liked")
                print(self.liked)
                print("")
                self.mainView.likeButton.setTitle("♥️ My Favorite", for: .normal)
                self.mainView.contentView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
              
            } else {
                print("no id found in CoreData.")
            }
        }
        
        

        
        mainView.likeAction = { [weak self] in self?.likeAction() }
        
        
        
        
        
//        print(selectedOffer?.url)
//        print(selectedOffer?.name)
//        print(selectedOffer?.description)
//        print(selectedOffer?.current_value)
//        print(selectedOffer?.terms)
//        print(selectedOffer?.id)

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

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backTapped)) //UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backTapped))
    
    }
    
    
    
    private func likeAction() {
        self.liked = !self.liked
        if self.liked {
            
            UIView.animate(withDuration: 0.5, animations:  {
                print("liked executed")
                self.mainView.likeButton.setTitle("♥️ My Favorite", for: .normal)
                self.mainView.contentView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                
                if self.selectedOffer?.id != nil {
                    //self.saveLike(id: (self.selectedOffer?.id)!, like: true)
                    
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
                    
                    // delete the item from CoreData, instead
                    //self.saveLike(id: (self.selectedOffer?.id)!, like: false)
                    
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                    // Reference to managed object context
                    let context = appDelegate.persistentContainer.viewContext
                    
                    let predicate = NSPredicate(format: "id == %@", (self.selectedOffer?.id)! as CVarArg)
                    
                    print("*******self.selectedOffer?.id!")
                    print(self.selectedOffer?.id! as Any)
                    
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
    
    func saveLike(id: String, like: Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        // Reference to managed object context
        let context = appDelegate.persistentContainer.viewContext

        let selectedOfferLike = Like(context: context)
        selectedOfferLike.id = id
        selectedOfferLike.like = like
        do {
            try context.save()
            print("context was saved")
            
        }catch{
            print("Saving Error: \(error.localizedDescription)")
        }
        
    }
    
    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
        
    }
    
}



