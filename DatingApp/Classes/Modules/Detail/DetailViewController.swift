//
//  DetailViewController.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Properties
    private var listOfQuestions = ListOfQuestions()
    private var game: Game
    private var truthTimer = 30
    private var actionTimer = 300
    
    // MARK: - UI
    lazy private var timeLabel: UILabel = UILabel.getCoolLabel(withText: "", andColor: UIColor.mainDark, andSize: 40)
    lazy private var textLabel: UILabel = UILabel.getCoolLabel(withText: chooseText(), andColor: .white, andSize: 20)
    lazy private var finishButton: UIButton = {
        let button = UIButton.getCoolButton()
        button.addTarget(self, action: #selector(finishGame), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializer
    init(game: Game) {
        self.game = game
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTimeLabel()
        runTimer()
    }
    
    // MARK: - Methods
    private func setupUI() {
        self.view.backgroundColor = UIColor.main
        self.view.addSubview(timeLabel)
        self.view.addSubview(textLabel)
        self.view.addSubview(finishButton)
        
        finishButton.isHidden = true
        
        NSLayoutConstraint.activate([
            finishButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            finishButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            finishButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            finishButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        switch game {
        case .truth:
            NSLayoutConstraint.activate([
                timeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                timeLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
                
                textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                textLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
                textLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                textLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            ])
        case .action:
            NSLayoutConstraint.activate([
                timeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                timeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
                
                textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                textLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
                textLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                textLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            ])
        }
    }
    
    private func setupTimeLabel() {
        switch game {
        case .truth:
            self.timeLabel.text = "00:30"
        case .action:
            self.timeLabel.text = "05:00"
        }
    }
    private func chooseText() -> String {
        var text = String()
        switch game {
        case .truth:
            let count = self.listOfQuestions.listOfQuestions.count
            let random = Int.random(in: 0..<count)
            text = self.listOfQuestions.listOfQuestions[random]
        case .action:
            let count = self.listOfQuestions.listOfActions.count
            let random = Int.random(in: 0..<count)
            text = self.listOfQuestions.listOfActions[random]
        }
        return text
    }
    private func runTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            switch self.game {
            case .truth:
                self.truthTimer -= 1
                self.timeLabel.text = self.timeFormatted(self.truthTimer)
                if self.truthTimer == 25 {
                    self.finishButton.isHidden = false
                }
                if self.truthTimer == 0 {
                    timer.invalidate()
                    self.finishButton.setTitle("Время вышло!", for: .normal)
                }
            case .action:
                self.actionTimer -= 1
                self.timeLabel.text = self.timeFormatted(self.actionTimer)
                if self.actionTimer == 295 {
                    self.finishButton.isHidden = false
                }
                if self.actionTimer == 0 {
                    timer.invalidate()
                    self.finishButton.setTitle("Время вышло!", for: .normal)
                }
            }
        }
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // MARK: - @objc methods
    @objc
    private func finishGame() {
        self.dismiss(animated: true, completion: nil)
    }
}
