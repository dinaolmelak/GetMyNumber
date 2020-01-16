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
        //let query = PFUser.query()!
        getPlayers()
        //let userQueries = PFUser.query()!
        
//        query.findObjectsInBackground { (pfobjects, error) in
//            if let error = error{
//                print(error)
//            } else{
//                print(pfobjects!)
//            }
//        }
        
        
    }
    
    func getPlayers(){
        let query = PFUser.query()!
        query.whereKey("isOnline", equalTo: true)
        query.findObjectsInBackground { (gamesArray, error) in
            if error != nil{
                print(error!)
            } else{
                let players = gamesArray!
                //UserDefaults.standard.object(forKey: "gameID") as! String
                print("------\(players)-------")
                for object in players{
                    if object.objectId! != PFUser.current()!.objectId!{
                        self.onlinePlayers.append(object)
                    }
                }

                
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
            let user = game as! PFUser
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
            let playerPFObject = onlinePlayers[indexPath.row - 1] as! PFUser
            
            let query = PFUser.query()!
            query.whereKey("username", equalTo: playerPFObject)
            query.findObjectsInBackground { (array, error) in
                if error != nil {
                    print(error!)
                }else{
                    print(array)
                }
                
            }
            
            
            playingVC.opponent = playerPFObject

        }
        
        
        
    }
    

}
