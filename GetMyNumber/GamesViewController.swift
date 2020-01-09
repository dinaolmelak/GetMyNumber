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
    
    var onlinePlayers = [PFObject]()
    @IBOutlet weak var playersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playersTableView.delegate = self
        playersTableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        let game = PFObject(className: "Game")
        game["user"] = PFUser.current()
        game["isOnline"] = true
        game.saveInBackground { (succes, error) in
            if error != nil {
                print(error!)
            } else{
                print("saved status online")
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
                self.onlinePlayers = gamesArray!
                print(gamesArray)
                self.playersTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onlinePlayers.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "PlayersCell")
            cell.textLabel!.text = PFUser.current()!.username
            cell.detailTextLabel!.text = "Online"
            return cell
        } else{
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "PlayersCell")
            let game = onlinePlayers[indexPath.row - 1]
            let user = game["user"] as! PFUser
            let isOnline = game["isOnline"] as! Bool
            cell.textLabel!.text = user.username
            cell.detailTextLabel!.text = String(isOnline)
            
            
            return cell
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
