//
//  ViewController.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-13.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    @IBOutlet weak var UserTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var playerList: [Player] = []
    var searchedPlayer: [Player] = []
    var searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.showsCancelButton = true
        Task {
            do {
                let dogdexResponse = try await ChessAPI_Helper.fetchLedearBoards()
                playerList = dogdexResponse.daily
                UserTableView.dataSource=self
                UserTableView.reloadData()
            
            } catch {
                // If an error occurs during the API call, terminate the program with an error message
                preconditionFailure("Program failed with error message \(error)")
            }
        }
    }
   
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        if searching {
            return searchedPlayer.count
        } else {
            return playerList.count
        }
   
    }
   

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! LeaderBoardTableCell
        var user:Player
        if searching {
             user = searchedPlayer[indexPath.row]
        }else{
             user = playerList[indexPath.row]
        }
       
       
        cell.userName.text=user.username
        if let imageUrl = URL(string: user.avatar) {
            cell.displayDogImage(with: imageUrl)
        }
       
        cell.userScore.text=String(user.score)
       
        return cell
    }

   
}
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedPlayer = playerList.filter { player in player.username.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        UserTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        UserTableView.reloadData()
    }
}

