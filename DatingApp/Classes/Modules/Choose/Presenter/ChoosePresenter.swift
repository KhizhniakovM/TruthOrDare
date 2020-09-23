//
//  ChoosePresenter.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//

import Foundation

class ChoosePresenter: ChooseViewPresenter {
    // MARK: - Properties
    weak var view: ChooseView?
    
    private var turn: Turn = .his
    private var hisName: String?
    private var herName: String?
    
    // MARK: - Initializers
    required init(view: ChooseView) {
        self.view = view
    }
    
    // MARK: - Methods
    func onTruthOrAction(game: Game) {
        self.view?.showDetail(game: game)
    }
    
    func setupName() {
        guard let hisName = hisName, let herName = herName else { return }
        switch self.turn {
        case .his:
            self.view?.setup(name: hisName, turn: .his)
        case .her:
            self.view?.setup(name: herName, turn: .her)
        }
    }
    
    func changeTurn() {
        if self.turn == .his {
            self.turn = .her
        } else {
            self.turn = .his
        }
    }
    
    func setupNames(hisName: String, herName: String) {
        self.hisName = hisName
        self.herName = herName
    }
}
