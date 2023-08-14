//
//  ViewController.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-13.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource {
    @IBOutlet weak var UserTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var playerList: [Player] = []
    var searchedPlayer: [Player] = []
    var searching = false
    var favList: [Favorite] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.showsCancelButton = true
    
        self.showAll()
        
       
        
        
        
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
    func showAll(){
        do{
            favList = try context.fetch(Favorite.fetchRequest())
            print("Fav item list \(favList.count)")
        }
        catch{
            
        }
    }
    
    func addFavorite(player_id:Int){
       
        
        let newItem=Favorite(context: context)
        newItem.player_id = Int64(player_id)
        do{
            try context.save()
            self.showAll()
            self.showToast(message: "Favorite Added", font: .systemFont(ofSize: 15.0),color: UIColor.green)
        }
        catch{
            
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
       
        cell.buttonTappedClosure = { [weak self] in
                   self?.handleButtonTap(for: user)
               }
               
        cell.configure(with: user)
        
        
        return cell
    }
    func handleButtonTap(for player: Player) {
            // Access the 'player' object and perform actions here
        print("Button tapped for player: \(player.loss_count)")
        let status = checkStatus(player_id: player.player_id)
        if(status == true){
            return ;
        }
        addFavorite(player_id: player.player_id)
    }
    func checkStatus(player_id: Int) -> Bool {
        return favList.contains { fav in
            return fav.player_id == Int64(player_id)
        }
    }
    // Implement the protocol method to handle the button tap
        func didTapButton(for player: Player) {
            // Here you can navigate to the new page and send data
            performSegue(withIdentifier: "ShowPlayerFavs", sender: self)
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPlayerDetails",
                   let indexPath = UserTableView.indexPathForSelectedRow,
                   let destinationVC = segue.destination as? PlayerDetailViewController {
                    let user: Player
                    if searching {
                        user = searchedPlayer[indexPath.row]
                    } else {
                        user = playerList[indexPath.row]
                    }
                    destinationVC.selectedPlayer = user
                }
     
    }
    func showToast(message : String, font: UIFont, color:UIColor) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = color.withAlphaComponent(1)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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

