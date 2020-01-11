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
        
//        let firstGuess = NumberData()
//        firstGuess.NumberData(Group: 5555, Order: 3333)
//        predictedNumbers.append(firstGuess)
        
        print("Here is my Object\(UserDefaults.standard.object(forKey: "gameID") as! String)")
        
        opponentLabel.text =  opponent.username!
        playerCardLabel.text = PFUser.current()!.username!
    }
    override func viewDidAppear(_ animated: Bool) {
        
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
        return predictedNumbers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == predictedNumbers.count{
            let cell = myCardTableView.dequeueReusableCell(withIdentifier: "PlayingNumberCell") as! PlayingNumberCell
            cell.guessNumLabel.text = "Tap here to guess number..."
            cell.groupNumLabel.text = ""
            cell.orderNumLabel.text = ""
            
            return cell

        } else{

            let cell = myCardTableView.dequeueReusableCell(withIdentifier: "PlayingNumberCell") as! PlayingNumberCell
            let guess = predictedNumbers[indexPath.row]
            cell.groupNumLabel.text = String(guess.getGroupNum())
            cell.orderNumLabel.text = String(guess.getOrderNum())
            cell.selectionStyle = .none
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        if let cell = sender as? PlayingNumberCell{
//            let indexPath = myCardTableView.indexPath(for: cell)!
//            let guess = NumberData()
//            guess.NumberData(Group: 0, Order: 0)
//            let numberObject = guess
//
            let predictorVC = segue.destination as? CheckViewController
            predictorVC?.myCardVC = self
//
//            predictorVC?.numberData = numberObject
            
//        }
    }
    

}
