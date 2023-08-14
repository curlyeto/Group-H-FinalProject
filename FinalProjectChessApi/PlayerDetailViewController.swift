//
//  PlayerDetailViewController.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-14.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    var selectedPlayer: Player?
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userCountry: UILabel!
    
    @IBOutlet weak var userScore: UILabel!
    
    @IBOutlet weak var winGame: UILabel!
    
    @IBOutlet weak var drawGame: UILabel!
    
    @IBOutlet weak var lostGame: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                let dogdexResponse = try await ChessAPI_Helper.getCountryInfo(urlString: selectedPlayer!.country )
                // Store the fetched breeds and sub-breeds in local variables
                self.userCountry.text = dogdexResponse.name
              
                
            } catch {
                // If an error occurs during the API call, terminate the program with an error message
                preconditionFailure("Program failed with error message \(error)")
            }
        }
        let score:String = String(selectedPlayer!.score)
        self.userName.text=selectedPlayer?.username

        self.userScore.text = score
        self.winGame.text="W: \(selectedPlayer!.win_count)"
        self.drawGame.text="D: \(selectedPlayer!.draw_count)"
        self.lostGame.text="L: \(selectedPlayer!.loss_count)"
        loadImage(from: selectedPlayer!.avatar)
        
        
     
        
        // Do any additional setup after loading the view.
    }
    
    func loadImage(from urlString: String) {
        if let imageUrl = URL(string: urlString) {
            // Create a data task to fetch the image data from the URL
            let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let error = error {
                    print("Error fetching data from imageUrl:", error)
                    return
                }
                
                if let data = data, let uiImage = UIImage(data: data) {
                    // If the data is successfully converted to a UIImage, update the UI on the main queue
                    DispatchQueue.main.async {
                        self.userImage.image = uiImage
                        
                    }
                } else {
                    print("Failed to convert data to UIImage")
                }
            }
            // Resumes the execution of the data task to start fetching the image data from the URL
            task.resume()
        } else {
            print("Invalid imageUrl")
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
