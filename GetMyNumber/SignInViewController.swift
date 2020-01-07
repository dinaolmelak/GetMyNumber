//
//  SignInViewController.swift
//  GetMyNumber
//
//  Created by Center for Innovation on 1/6/20.
//  Copyright © 2020 dinaolmelak. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapSignUp(_ sender: Any) {
        if usernameField.text == nil || usernameField.text == "" || passwordField.text == nil || passwordField.text == ""{
            showAlert(title: "Invalid Entry", message: "Please check username or password")
            
        } else{
            
            var user = PFUser()
            user.username = usernameField!.text
            user.password = passwordField!.text
            // other fields can be set just like with PFObject
            
            user.signUpInBackground { (success, error) in
                if error != nil{
                    print(error!)
                    
                } else{
                    self.performSegue(withIdentifier: "SignedIn", sender: self)
                    
                }
            }

        }
        
    }
    @IBAction func onTapSignIn(_ sender: Any) {
        
        
    }

    func showAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
