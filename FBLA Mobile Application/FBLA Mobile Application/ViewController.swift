//
//  ViewController.swift
//  FBLA Mobile Application
//
//  Created by Grant Falkner on 12/21/16.
//  Copyright © 2016 Grant Falkner. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var EmailC: UITextField!
    
    @IBOutlet weak var PasswordC: UITextField!
    
    @IBOutlet weak var LabelC: UILabel!
    
    @IBAction func ButtonC(_ sender: UIButton) {
        let email = EmailC.text
        let password = PasswordC.text
        
        FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion: { (user: FIRUser?, error) in
            if error == nil {
                self.LabelC.text = "Registration Successful"
                self.performSegue(withIdentifier: "HomeToStore", sender: nil)
                            }
            else{
                self.LabelC.text = "Please Try Again"
            }
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view, typically from a nib.
        
        FIRApp.configure()
        
        if FIRAuth.auth()?.currentUser != nil {
            // User is signed in.
            self.performSegue(withIdentifier: "HomeToStore", sender: nil)
            
        }
    }
    
    @IBAction func textField(_ sender: AnyObject) {
        self.view.endEditing(true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

