//
//  RootPresenter.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//

import Foundation
import StoreKit

class RootPresenter: RootViewPresenter {
    // MARK: - Properties
    weak var view: RootView?
    
    // MARK: - Initializer
    required init(view: RootView) {
        self.view = view
    }
    
    // MARK: - Methods
    func onGame(hisName: String, herName: String) {
        self.view?.showChoose(hisName: hisName, herName: herName)
    }
    func onMail() {
        guard let url = URL(string: "mailto:foo@bar.com") else { return }
        DispatchQueue.main.async {
            UIApplication.shared.open(url)
        }
    }
    func onRate() {
        SKStoreReviewController.requestReview()
    }
    func onTutorial() {
        self.view?.showTutorial()
    }
}

