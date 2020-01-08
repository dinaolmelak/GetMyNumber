//
//  PredictorViewController.swift
//  GetMyNumber
//
//  Created by Dinaol Melak on 1/8/20.
//  Copyright © 2020 dinaolmelak. All rights reserved.
//

import UIKit

class PredictorViewController: UIViewController {

    var myCardCell: PlayingNumberCell!
    @IBOutlet weak var orderTextField: UITextField!
    @IBOutlet weak var groupTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapDone(_ sender: Any) {
        if groupTextField.text == nil || orderTextField.text == nil{
            print("No group or order")
        } else{
        myCardCell.setGroupAndOrder(Group: groupTextField.text!, Order: orderTextField.text!)
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
