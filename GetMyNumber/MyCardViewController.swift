//
//  MyCardViewController.swift
//  GetMyNumber
//
//  Created by Center for Innovation on 1/7/20.
//  Copyright © 2020 dinaolmelak. All rights reserved.
//

import UIKit

class MyCardViewController: UIViewController {

    @IBOutlet weak var myCardView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myCardView.layer.cornerRadius = 20
        myCardView.layer.borderWidth = 3
        myCardView.clipsToBounds = true
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
