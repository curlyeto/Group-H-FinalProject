//
//  Favorite+CoreDataProperties.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-14.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var player_id: Int64

}

extension Favorite : Identifiable {

}
