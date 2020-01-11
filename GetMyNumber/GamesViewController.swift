//
//  GamesViewController.swift
//  GetMyNumber
//
//  Created by Center for Innovation on 1/6/20.
//  Copyright © 2020 dinaolmelak. All rights reserved.
//

import UIKit
import Parse

class GamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var playGameID: String!
    var onlinePlayers = [PFObject]()
    @IBOutlet weak var playersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playersTableView.delegate = self
        playersTableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        onlinePlayers.removeAll()
        let query = PFQuery(className: "Game")
        query.includeKey("user")
        query.whereKey("user", equalTo: PFUser.current()!)
        query.findObjectsInBackground { (pfobjectS, error) in
            if error != nil{
                print(error!)
            } else{
                print(pfobjectS!)
                if pfobjectS!.count == 0{
                    // do something
                    let object = PFObject(className: "Game")
                    object["user"] = PFUser.current()!
                    object["isOnline"] = true
                    object.saveInBackground()
                    UserDefaults.standard.set(object.objectId!, forKey: "gameID")
                    self.playGameID = object.objectId!
                }else{
                    let object = pfobjectS![0]
                    object["isOnline"] = true
                    object.saveInBackground()
                    UserDefaults.standard.set(object.objectId!, forKey: "gameID")
                    self.playGameID = object.objectId!
                    print("-----\(object.objectId!)-------")
                }
            }
        }
        getPlayers()
        
        
    }
    
    func getPlayers(){
        let query = PFQuery(className: "Game")
        query.whereKey("isOnline", equalTo: true)
        query.includeKey("user")
        query.findObjectsInBackground { (gamesArray, error) in
            if error != nil{
                print(error!)
            } else{
                let players = gamesArray!
                let gameID = self.playGameID//UserDefaults.standard.object(forKey: "gameID") as! String
                for object in players{
                    if object.objectId! != gameID{
                        self.onlinePlayers.append(object)
                    }
                }

                print("------\(self.onlinePlayers)-------")
                self.playersTableView.reloadData()
            }
        }
    }
    
    @IBAction func onTapPerson(_ sender: Any) {
        performSegue(withIdentifier: "ProfileSegue", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onlinePlayers.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "PlayersCell")
            cell.textLabel!.text = PFUser.current()!.username
            cell.detailTextLabel!.text = "Online"
            cell.selectionStyle = .none
            return cell
        } else{
            let cell = playersTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
            let game = onlinePlayers[indexPath.row - 1]
            let user = game["user"] as! PFUser
            let isOnline = game["isOnline"] as! Bool
            cell.usernameLabel.text = user.username
            cell.statusLabel.text = String(isOnline)
            
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let playingVC = segue.destination as? PlayingViewController{
            let tableViewCell = sender as! UITableViewCell
            let indexPath = playersTableView.indexPath(for: tableViewCell)!
            let playerPFObject = onlinePlayers[indexPath.row - 1]
            
            
            
            let opponentUser = playerPFObject["user"] as! PFUser
            playingVC.opponent = opponentUser
        }
        
        
        
    }
    

}
