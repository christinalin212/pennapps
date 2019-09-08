//
//  AddUserViewController.swift
//  StudyGroup
//
//  Created by Christina Lin on 4/20/19.
//  Copyright © 2019 Christina Lin. All rights reserved.
//

import UIKit
import Firebase
class AddUserViewController: UIViewController {
    
    @IBOutlet weak var first: UITextField!
    @IBOutlet weak var last: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var venmoField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addUserPressed(_ sender: Any) {
        addUser()
    }
    
    func addUser() {
        // Check user input
        if ((first.text! == "") || (last.text! == "") || (emailField.text! == "") || (passwordField.text! == "") || venmoField.text! == "") {
            let alert = UIAlertController(title: "Error", message: "Must fill out all fields", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (result, error) in
                if (error == nil) {
                    let u: User = User(
                        firstName: self.first.text!,
                        lastName: self.last.text!,
                        email: self.emailField.text!,
                        password: self.passwordField.text!,
                        venmo:
                        self.venmoField.text!,
                        userId: Auth.auth().currentUser!.uid
                    )
                    FirebaseDatabaseManager.writeToUser(for: u)
                    self.performSegue(withIdentifier: "addUser", sender: nil)
                }
                else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                }
            }
            
        }
    }
    
    
    
    //   if (user != nil) {
    /*let u: User = User(
     firstName: self.first.text!,
     lastName: self.last.text!,
     email: self.emailField.text!,
     password: self.passwordField.text!//,
     //userId: Auth.auth().currentUser!.uid
     )
     FirebaseDataManager.writeToUser(for: u)*/
    // }
    //else {
    //   print ("ERROR")
    //}
    // }
    //let userId = Auth.auth().currentUser!.uid
    //print(userId)
    
    
    /*if Auth.auth().currentUser != nil {
     let u: User = User(
     firstName: first.text!,
     lastName: last.text!,
     email: emailField.text!,
     password: passwordField.text!//,
     //userId: Auth.auth().currentUser!.uid
     )
     FirebaseDataManager.writeToUser(for: u)
     } else {
     print("no user signed in")
     }*/
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

