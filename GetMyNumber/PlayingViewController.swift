//
//  PlayingViewController.swift
//  GetMyNumber
//
//  Created by Center for Innovation on 1/6/20.
//  Copyright © 2020 dinaolmelak. All rights reserved.
//

import UIKit
import Parse

class PlayingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var opponent: PFUser!
    var predictedNumbers = [NumberData]()
    @IBOutlet weak var opponentCardView: UIView!
    @IBOutlet weak var opponentLabel: UILabel!
    @IBOutlet weak var playerCardLabel: UILabel!
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
        
        let firstGuess = NumberData()
        firstGuess.NumberData(Group: 5555, Order: 3333)
        predictedNumbers.append(firstGuess)
        
        print("Here is my Object\(UserDefaults.standard.object(forKey: "gameID") as! String)")
        
        opponentLabel.text =  opponent.username!
        playerCardLabel.text = PFUser.current()!.username!
    }
    
    @IBAction func onTapAvailableNum(_ sender: Any) {
        
        let button = sender as! UIButton
        if button.isSelected{
            let buttonNum = button.tag
            let image = UIImage(systemName: "\(buttonNum).circle")
            button.setImage(image, for: .normal)
            button.isSelected = false
        }else{
            let buttonNum = button.tag
            let image = UIImage(systemName: "\(buttonNum).circle.fill")
            button.setImage(image, for: .normal)
            button.isSelected = true
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictedNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myCardTableView.dequeueReusableCell(withIdentifier: "PlayingNumberCell") as! PlayingNumberCell
        let guess = predictedNumbers[indexPath.row]
        cell.groupNumLabel.text = String(guess.getGroupNum())
        cell.orderNumLabel.text = String(guess.getOrderNum())
        
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
