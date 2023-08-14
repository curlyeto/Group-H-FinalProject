//
//  FavoriteViewController.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-14.
//

import UIKit

class FavoriteViewController: UIViewController,UITableViewDataSource {
    var selectedPlayer: Player?
    
    @IBOutlet weak var favTableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var playerList: [Player] = []
    var favList: [Favorite] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Favorite Page")
        self.showAll()
        Task {
            do {
                let dogdexResponse = try await ChessAPI_Helper.fetchLedearBoards()
                var list = dogdexResponse.daily
                favList.forEach{fav in
                    print("Player id in fav list \(fav.player_id)")
                    list.forEach{player in
          
                        if ( fav.player_id == Int64(player.player_id)){
                            print("Is matched")
                            playerList.append(player)
                        }
                        
                    }
                    
                }
                favTableView.dataSource=self
                favTableView.reloadData()
              
                
            
            } catch {
                // If an error occurs during the API call, terminate the program with an error message
                preconditionFailure("Program failed with error message \(error)")
            }
        }
        
        
        
        
      
       
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return playerList.count
   
    }
   

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! LeaderBoardTableCell
        var user:Player
        user = playerList[indexPath.row]
        
       
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
        print("Button tapped for player: \(player.player_id)")
        favList.forEach{fav in
            if(fav.player_id == Int64(player.player_id)){
                context.delete(fav)
                dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func showAll(){
        do{
            favList = try context.fetch(Favorite.fetchRequest())
            print("Count \(favList.count)")
        
        }
        catch{
            
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
