//
//  Store.swift
//  FBLA Mobile Application
//
//  Created by Grant Falkner on 1/1/17.
//  Copyright © 2017 Grant Falkner. All rights reserved.
//

import UIKit
import Firebase

class Store: UIViewController {

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

        // Do any additional setup after loading the view.
    }

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