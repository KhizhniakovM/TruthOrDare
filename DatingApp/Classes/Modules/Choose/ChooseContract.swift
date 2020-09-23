//
//  ChooseContract.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//

import Foundation

protocol ChooseView: class {
    func showDetail(game: Game)
    func setup(name: String, turn: Turn)
}

protocol ChooseViewPresenter: class {
    init(view: ChooseView)
    func changeTurn()
    func setupName()
    func onTruthOrAction(game: Game)
}
