//
//  PlayingViewController.swift
//  GetMyNumber
//
//  Created by Center for Innovation on 1/6/20.
//  Copyright © 2020 dinaolmelak. All rights reserved.
//

import UIKit

class PlayingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var predictedNumbers = [NumberData]()
    @IBOutlet weak var opponentCardView: UIView!
    @IBOutlet weak var myCardView: UIView!
    @IBOutlet weak var myCardTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myCardView.layer.cornerRadius = 20
        myCardView.layer.borderWidth = 3
        myCardView.clipsToBounds = true
        view.bringSubviewToFront(myCardView)
        
        opponentCardView.layer.cornerRadius = 20
        opponentCardView.layer.borderWidth = 3
        
        myCardTableView.delegate = self
        myCardTableView.dataSource = self
    }
    
    @IBAction func onTapEdit(_ sender: Any) {
        performSegue(withIdentifier: "EditMyCardSegue", sender: self)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictedNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myCardTableView.dequeueReusableCell(withIdentifier: "PlayingNumberCell") as! PlayingNumberCell
        
        return cell
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
