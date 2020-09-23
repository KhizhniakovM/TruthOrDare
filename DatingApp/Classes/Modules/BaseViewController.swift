//
//  BaseViewController.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - UI
    lazy private var background: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "back")
        return imageView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }
    
    // MARK: - Methods
    private func setupBackground() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.view.topAnchor),
            background.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
