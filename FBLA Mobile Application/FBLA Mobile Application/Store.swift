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

class Store: UIViewController {

    @IBOutlet weak var Table: UITableView!
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
            DispatchQueue.main.async(execute: {
                self.Table.reloadData()
                })
            })
        }
        // Do any additional setup after loading the view.


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
