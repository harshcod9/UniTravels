//
//  SettingsVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 23/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

class SettingsVC: UIViewController {
    
    //MARK: ~ properties
    
    @IBOutlet weak var uid: UILabel!
    @IBOutlet weak var emailadd: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    
    //MARK: ~Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            //let email:String = user.email!
            db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, error) in
                if error != nil {
                    print(error!)
                }else{
                    for document in (snapshot?.documents)! {
                        if let username = document.data()["username"] as? String {
                            if let email = document.data()["email"] as? String {
                                
                                self.uid.text  = "Username: " + username
                                self.emailadd.text = "Email address: " + email
                                //self.profileTextView.text += "\n username: \(username) \n email: \(email)"
                            }
                        }
                    }
                }
            }
        }
    }
    

    @IBAction func returnButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
