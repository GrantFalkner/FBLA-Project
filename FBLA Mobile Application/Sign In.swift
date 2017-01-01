//
//  Sign In.swift
//  
//
//  Created by Grant Falkner on 12/23/16.
//
//

import UIKit
import Firebase

class Sign_In: UIViewController {
    
    @IBOutlet weak var EmailS: UITextField!
    @IBOutlet weak var PasswordS: UITextField!
    
    @IBOutlet weak var LabelS: UILabel!

    @IBAction func ButtonS(_ sender: UIButton) {
        let email = EmailS.text
        let password = PasswordS.text
        
         FIRAuth.auth()?.signIn(withEmail: email!, password: password!) { (user, error) in
            if (error == nil)
            {
                self.LabelS.text = "Log in successful"
                self.performSegue(withIdentifier: "SignInToStore", sender: nil)
            }
            else
            {
                self.LabelS.text = "Log in failed"
            }
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
