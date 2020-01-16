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
    
    
    @IBOutlet weak var myNumber: UILabel!
    @IBOutlet weak var scratchView: UIView!
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
        myCardTableView.layer.cornerRadius = 20
        myCardTableView.layer.borderWidth = 1
        scratchView.layer.cornerRadius = 20
        scratchView.layer.borderWidth = 0.1
        scratchView.backgroundColor = UIColor.lightText
        
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
        getMyNumber()
    }
    func getMyNumber(){
        let query = PFUser.query()!
        query.whereKey("username", equalTo: PFUser.current()!.username!)
        query.getFirstObjectInBackground { (object, error) in
            if error != nil{
                print(error!)
            }else{
                print("->>>\(object!)<<<<-")
                if object!["myNumber"] != nil{
                    let num = object!["myNumber"]! as! String
                    //let numText = String(num)
                    self.myNumber.text = num
                }
            }
        }
    }
    
    @IBAction func onSetMyNumber(_ sender: Any) {
        let alert = UIAlertController(title: "Please Input Your Number", message: "What is the number you would like to play with?", preferredStyle: .alert)
        
        alert.addTextField { (inputNumTextField) in
            inputNumTextField.placeholder = "Type your number here ..."
            
            let set = UIAlertAction(title: "Set", style: .default) { (UIAlertAction) in
                
                self.myNumber.text = inputNumTextField.text
            }
            alert.addAction(set)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
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
    
    @IBAction func onTapQuit(_ sender: Any) {
        //set myNumber on parse to nil
        //set opponent to nil
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func onTapSend(_ sender: Any) {
        myCardCenterToRight()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return predictedNumbers.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = myCardTableView.dequeueReusableCell(withIdentifier: "PlayingNumberCell") as! PlayingNumberCell
            let guess = predictedNumbers[indexPath.row]
            if guess.getGroupNum() != nil{
                cell.groupNumLabel.text = String(guess.getGroupNum()!)
            }
            if guess.getOrderNum() != nil{
                cell.orderNumLabel.text = String(guess.getOrderNum()!)
            }
            
            cell.selectionStyle = .none
            
            return cell
            


        } else{
            let cell = myCardTableView.dequeueReusableCell(withIdentifier: "PlayingNumberCell") as! PlayingNumberCell
            cell.guessNumLabel.text = "Tap here to guess number..."
            cell.groupNumLabel.text = ""
            cell.orderNumLabel.text = ""
            
            return cell

        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let numGuessed = NumberData()
        if indexPath.row == predictedNumbers.count{
            let alert = UIAlertController(title: "Please Input Your Number", message: "What is the number you would like to play with?", preferredStyle: .alert)
            
            alert.addTextField { (inputNumTextField) in
                inputNumTextField.placeholder = "Type your number here ..."
                
                let set = UIAlertAction(title: "Set", style: .default) { (UIAlertAction) in
                    let num = Int(inputNumTextField.text!)!
                    numGuessed.setGuess(Guess: num)
                }
                alert.addAction(set)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        predictedNumbers.append(numGuessed)
        myCardTableView.reloadData()
    }
    
    func myCardCenterToRight(){
        UIView.animate(withDuration: 1) {
            self.myCardView.center.x += self.view.bounds.width
        }
        
    }
    func myCardLeftToCenter(){
        self.myCardView.center.x -= self.view.bounds.width
        UIView.animate(withDuration: 1) {
            self.myCardView.center.x += self.view.bounds.width
        }
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        if let cell = sender as? PlayingNumberCell{
//            let indexPath = myCardTableView.indexPath(for: cell)!
//            let guess = NumberData()
//            let numberObject = guess
//
//            let predictorVC = segue.destination as? CheckViewController
//            predictorVC?.myCardVC = self
//
//            predictorVC?.numberData = numberObject
//
//        }
    }
    

}
