//
//  Store.swift
//  FBLA Mobile Application
//
//  Created by Grant Falkner on 1/1/17.
//  Copyright © 2017 Grant Falkner. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct post {
    let name : String!
    let image : String!
    let price : String!
    let time : String!
}

final class Shared {
    static let shared = Shared() //lazy init, and it only runs once
    
    var stringValue : String!
    var boolValue   : Bool!
}


class Store: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts = [post]()
    var bubso = ["tub", "bub", "rub"]
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Signinout: UIBarButtonItem!
    
    @IBAction func Signinoutbutton(_ sender: Any) {
        if FIRAuth.auth()?.currentUser != nil {
            // User is signed in.
           try! FIRAuth.auth()!.signOut()
           self.Signinout.title = "Sign In"
        }
        else {
            self.performSegue(withIdentifier: "StoreToSignIn", sender: nil)
            
        }
    }

    @IBAction func Donate(_ sender: UIBarButtonItem) {

        if FIRAuth.auth()?.currentUser != nil {
            // User is signed in.
            // ...
            self.performSegue(withIdentifier: "StoreToDonate", sender: nil)
        } else {
            self.performSegue(withIdentifier: "StoreToSignIn", sender: nil)

            // No user is signed in.
            // ...
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        if FIRAuth.auth()?.currentUser != nil {
            // User is signed in.
            self.Signinout.title = "Sign Out"
        }
        else {
            // No user is signed in.
            self.Signinout.title = "Sign In"
        }

        FIRDatabase.database().reference().child("posts").observe(.childAdded, with: {snapshot in
            var snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue!["itemName"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            let price = snapshotValue!["price"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            let image = snapshotValue!["image"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            let time = snapshotValue!["currentTime"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            
            self.posts.insert(post(name : name, image:image, price : price, time:time), at: 0)
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
                })
            })
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let labelName = view.viewWithTag(1) as! UILabel
        labelName.text = "       " + posts[indexPath.row].name
        
        let labelPrice = view.viewWithTag(2) as! UILabel
        labelPrice.text = "$" + posts[indexPath.row].price
        
        let imageView = view.viewWithTag(5) as! UIImageView
        
        if let url = URL.init(string: posts[indexPath.row].image) {
            imageView.downloadedFrom(url: url)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(posts[indexPath.row].time)!")
        let selected = posts[indexPath.row].time
        Shared.shared.stringValue = selected
        self.performSegue(withIdentifier: "StoreToStoreItem", sender: nil)
    }
    

}
