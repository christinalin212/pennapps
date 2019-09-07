//
//  LoginPageViewController.swift
//  StudyGroup
//
//  Created by Christina Lin on 4/21/19.
//  Copyright © 2019 Christina Lin. All rights reserved.
//

import UIKit
import Firebase
class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if error == nil {
                strongSelf.performSegue(withIdentifier: "loginToHome", sender: self)
            }
            else {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .invalidEmail:
                        let alert = UIAlertController(title: "Error", message: "Invalid Email", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        strongSelf.present(alert, animated: true)
                        
                    case .emailAlreadyInUse:
                        let alert = UIAlertController(title: "Error", message: "Email Already In Use", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        strongSelf.present(alert, animated: true)
                        
                    case .wrongPassword:
                        let alert = UIAlertController(title: "Error", message: "Wrong Password", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        
                        strongSelf.present(alert, animated: true)
                        
                    default:
                        let alert = UIAlertController(title: "Error", message: "Something was wrong! Try again or create a new account", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        strongSelf.present(alert, animated: true)
                    }
                }
            }
        }
    }
   
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
