//
//  DonateViewController.swift
//  
//
//  Created by Grant Falkner on 1/8/17.
//
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class donateC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    var StorageRef: FIRStorageReference!
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var ItemName: UITextField!
    @IBOutlet weak var ItemPrice: UITextField!
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var SliderLabel: UILabel!
    @IBOutlet weak var PostOutlet: UIButton!
    @IBOutlet weak var ImageName: UIImageView!

    @IBAction func SliderValue(_ sender: UISlider) {
        let SliderValue = Int(Slider.value)
        SliderLabel.text = "\(SliderValue)"
    }
    
    //image picking//
    @IBAction func ImageSelect(_ sender: UIButton) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.ImageName.image = image
            PostOutlet.isHidden = false
        }
        self.dismiss(animated: false, completion: nil)
    }
    //=-=-=-=-=-=-=-=-=-=-=-//
    
    @IBAction func Post(_ sender: UIButton)
        {
            let currentTimeInt = Int(NSDate().timeIntervalSince1970)
            let currentTime = String(currentTimeInt)
            
            if (ItemName.text != "" && ItemPrice.text != "" && ImageName.image != nil)
            {
                let imageRef = self.StorageRef.child("\(currentTime).jpg")
                let data = UIImageJPEGRepresentation(self.ImageName.image!, 1)
                let upload = imageRef.put(data!, metadata: nil, completion: { (metadata, error) in
                    if (error != nil)
                        
                    {
                        print(error!.localizedDescription)
                    }
                    imageRef.downloadURL(completion: { (url, error2) in
                        if (error2 != nil)
                        {
                            print(error!.localizedDescription)
                        }
                        if let url = url {
                            
                            let user = FIRAuth.auth()?.currentUser
                            
                            let email = String((user?.email)!)!
                            
                            let postInfo : [String : Any] = ["uid": user!.uid,
                                                             "email" : email,
                                                             "currentTime": currentTime,
                                                             "itemName" : self.ItemName.text!,
                                                             "price" : self.ItemPrice.text!,
                                                             "condition" : "\(Int(self.Slider.value))",
                                                             "image" : url.absoluteString]
                            self.ref.child("posts").child(currentTime).setValue(postInfo)
                        }
                    
                    })
                    
                })
                upload.resume()
                self.performSegue(withIdentifier: "DonateToStore", sender: nil)
                
            }
            else
            {
                Label.text = "Please Fill out all Fields"
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        let Storage = FIRStorage.storage().reference(forURL: "gs://real-fbla-project.appspot.com")
        ref = FIRDatabase.database().reference()
        StorageRef = Storage.child("posts")
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
