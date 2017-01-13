//
//  SignUp.swift
//  
//
//  Created by Grant Falkner on 12/23/16.
//
//

import UIKit
import Firebase

class SignUp: UIViewController {
    
    @IBOutlet weak var LabelC2: UILabel!
    @IBOutlet weak var EmailC2: UITextField!
    @IBOutlet weak var PasswordC2: UITextField!

    @IBAction func ButtonC2(_ sender: UIButton) {
        let password = PasswordC2.text
        let email = EmailC2.text
        FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion: { (user: FIRUser?, error) in
            if error == nil {
                self.LabelC2.text = "Registration Successful"
                self.performSegue(withIdentifier: "SignUpToStore", sender: nil)
            }
            else{
                self.LabelC2.text = "Please Try Again"
            }
        })

        
    }
    
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.gray
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func textField(_ sender: AnyObject) {
        self.view.endEditing(true);
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
