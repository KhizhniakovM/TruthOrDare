//
//  TutorialViewController.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//

import UIKit

class TutorialViewController: BaseViewController {
    // MARK: - UI
    lazy private var tutorialView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.main.cgColor
        return view
    }()
    lazy private var tutorialText: UILabel = {
        let label = UILabel.getCoolLabel(withText: "Эта игра не оставит равнодушными любовные пары. Игра поможет вам не заскучать со своим любимым человеком на карантине сидя дома. Выбрав 'Правда' - вы говорите чистую правду, на вопросы, которые задает приложение. Выбрал 'Действие' и придется выполнять задания. Любите друг друга!", andColor: UIColor.main, andSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    lazy private var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "exit"), for: .normal)
        button.addTarget(self, action: #selector(tapExitButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        self.view.addSubview(tutorialView)
        tutorialView.addSubview(tutorialText)
        tutorialView.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            tutorialView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            tutorialView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            tutorialView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            tutorialView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            
            tutorialText.topAnchor.constraint(equalTo: tutorialView.topAnchor, constant: 50),
            tutorialText.leadingAnchor.constraint(equalTo: tutorialView.leadingAnchor, constant: 20),
            tutorialText.trailingAnchor.constraint(equalTo: tutorialView.trailingAnchor, constant: -20),
            tutorialText.bottomAnchor.constraint(equalTo: tutorialView.bottomAnchor, constant: -50),
            
            exitButton.topAnchor.constraint(equalTo: tutorialView.topAnchor, constant: 20),
            exitButton.trailingAnchor.constraint(equalTo: tutorialView.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - @objc methods
    @objc
    private func tapExitButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
