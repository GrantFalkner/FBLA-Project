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
}


class Store: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts = [post]()
    var bubso = ["tub", "bub", "rub"]
    
    
    @IBOutlet weak var tableView: UITableView!
    

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
        
        FIRDatabase.database().reference().child("posts").observe(.childAdded, with: {snapshot in
        print(snapshot)
            var snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue!["itemName"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            let price = snapshotValue!["price"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            let image = snapshotValue!["image"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            print("\(name)")
            print("\(price)")
            print("\(image)")
            
            self.posts.insert(post(name : name, image:image, price : price), at: 0)
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
        
        cell.textLabel?.text = posts[indexPath.row].name
        
        return cell
    }
    

}
