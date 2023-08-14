//
//  LeaderBoardTableCell.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-13.
//

import Foundation
import UIKit

class LeaderBoardTableCell : UITableViewCell {
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userName : UILabel!
    @IBOutlet weak var userScore : UILabel!
    func displayDogImage(with url: URL) {
        // Perform image loading asynchronously on a global background queue
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                // Update the image view on the main queue once the image data is loaded
                DispatchQueue.main.async {
                    self.userImage.image = image
                }
            }
        }
    }

}
