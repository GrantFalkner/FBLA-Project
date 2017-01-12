//
//  StoreItem.swift
//  FBLA Mobile Application
//
//  Created by Grant Falkner on 1/11/17.
//  Copyright © 2017 Grant Falkner. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}


class StoreItem: UIViewController {
    var ref: FIRDatabaseReference!

    @IBOutlet weak var nav: UINavigationBar!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemCondition: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var chatText: UITextField!
    
    
    let value = Shared.shared.stringValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        
        
        FIRDatabase.database().reference().child("posts").child(value!).observeSingleEvent(of: .value, with: {snapshot in
            print(snapshot)
            var snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue!["itemName"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            let price = snapshotValue!["price"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            let imageStr = snapshotValue!["image"] as! String
            snapshotValue = snapshot.value as? NSDictionary
            let time = snapshotValue!["currentTime"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            let condition = snapshotValue!["condition"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            let email = snapshotValue!["email"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            
            if let url = URL.init(string: imageStr) {
                self.image.downloadedFrom(url: url)
            }
            
            self.name.text = name
            self.itemPrice.text = "$ " + price!
            self.itemCondition.text = "condition: " + condition! + "/10"
            
            let timeDbl = Double(time!)
            let date:NSDate = NSDate(timeIntervalSince1970: timeDbl!)
            let dateString = ("\(date)")
            let dateArray = dateString.components(separatedBy: " ")
            
            self.date.text = "" + dateArray[0] + " by " + email!
            
        })

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func postMessage(_ sender: Any) {
        FIRDatabase.database().reference().child("posts").child(value!).observeSingleEvent(of: .value, with: {snapshot in
            var snapshotValue = snapshot.value as? NSDictionary
            let user = snapshotValue!["email"] as? String
            snapshotValue = snapshot.value as? NSDictionary

            let userShort = user?.components(separatedBy: "@")
            print("\(userShort?[0])")
            

            
            let messageInfo : [String : Any] = ["user": userShort![0],
                                                "message": self.chatText.text!]
            
            self.ref.child(self.value!).childByAutoId().setValue(messageInfo)
            
        })
        
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
