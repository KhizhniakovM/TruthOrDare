//
//  RootContract.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//

import Foundation

protocol RootView: class {
    func showTutorial()
    func showChoose(hisName: String, herName: String)
}

protocol RootViewPresenter: class {
    init(view: RootView)
    func onRate()
    func onMail()
    func onTutorial()
    func onGame(hisName: String, herName: String)
}
