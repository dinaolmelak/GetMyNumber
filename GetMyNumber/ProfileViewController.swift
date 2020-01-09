//
//  ProfileViewController.swift
//  GetMyNumber
//
//  Created by Dinaol Melak on 1/7/20.
//  Copyright © 2020 dinaolmelak. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        usernameLabel.text = PFUser.current()!.username
    }
    
    @IBAction func onTapLogOut(_ sender: Any) {
        let query = PFQuery(className: "Game")
        let gameID = UserDefaults.standard.object(forKey: "gameID") as! String
        query.getObjectInBackground(withId: gameID) { (pfobject, error) in
            if error != nil{
                print("getting Object error\(error!)")
            } else{
                let object = pfobject!
                object["isOnline"] = false
                print("found This\(object)")
                object.saveInBackground { (success, error) in
                    if success{
                        print("logged out")
                    }else{
                        print("failed Log out")
                    }
                }
            }
        }
        
        PFUser.logOut()
        performSegue(withIdentifier: "LoggedOutSegue", sender: self)
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
