//
//  CheckViewController.swift
//  GetMyNumber
//
//  Created by Dinaol Melak on 1/11/20.
//  Copyright © 2020 dinaolmelak. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController {

    var numberData: NumberData!
    var myCardVC: PlayingViewController!
    @IBOutlet weak var orderTextField: UITextField!
    @IBOutlet weak var groupTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.cornerRadius = 20
        view.layer.borderWidth = 3
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapDone(_ sender: Any) {
        if groupTextField.text == nil || orderTextField.text == nil || groupTextField.text == "" || orderTextField.text == ""{
            showAlert(title: "No group or order", message: "Please input group and order together")
        } else{
            let groupNum = Int(groupTextField.text!)!
            let orderNum = Int(orderTextField.text!)!
            let newPredication = NumberData()
            newPredication.setResults(Group: groupNum, Order: orderNum)
            myCardVC.predictedNumbers.append(newPredication)
            myCardVC.myCardTableView.reloadData()
            
            dismiss(animated: true, completion: nil)
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
