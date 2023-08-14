//
//  PlayerCellDelegate.swift
//  FinalProjectChessApi
//
//  Created by Ertugrul on 2023-08-14.
//

import Foundation
protocol PlayerCellDelegate: AnyObject {
    func didTapButton(for player: Player)
}
