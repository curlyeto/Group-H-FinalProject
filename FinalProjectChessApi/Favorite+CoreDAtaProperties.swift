//
//  Favorite+CoreDAtaProperties.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-14.
//

import Foundation
extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrevOrder> {
        return NSFetchRequest<PrevOrder>(entityName: "Favorite")
    }

   
    @NSManaged public var player_id: String?
  

}

extension Favorite : Identifiable {

}
