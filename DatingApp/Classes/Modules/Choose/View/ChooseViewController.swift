//
//  ChooseViewController.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//

import UIKit

class ChooseViewController: BaseViewController {
    // MARK: - Properties
    var presenter: ChooseViewPresenter!

    // MARK: - UI
    lazy private var truthButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "bool"), for: .normal)
        button.addTarget(self, action: #selector(tapTruthButton), for: .touchUpInside)
        return button
    }()
    lazy private var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "action"), for: .normal)
        button.addTarget(self, action: #selector(tapActionButton), for: .touchUpInside)
        return button
    }()
    lazy private var orImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "or"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy private var nameLabel: UILabel = UILabel.getCoolLabel(withText: "", andColor: .mainDark, andSize: 30)
    lazy private var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Назад", for: .normal)
        button.addTarget(self, action: #selector(tapExitButton), for: .touchUpInside)
        button.titleLabel?.font = Fonts.MontserratBlack.of(size: 20)
        button.setTitleColor(UIColor.main, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupName()
    }
    
    // MARK: - Methods
    private func setupUI() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        self.view.addSubview(truthButton)
        self.view.addSubview(actionButton)
        self.view.addSubview(orImage)
        self.view.addSubview(nameLabel)
        self.view.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            truthButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            truthButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            truthButton.heightAnchor.constraint(equalToConstant: screenHeight / 1.75),
            truthButton.widthAnchor.constraint(equalToConstant: screenWidth / 1.8),
            
            actionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            actionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: screenHeight / 1.75),
            actionButton.widthAnchor.constraint(equalToConstant: screenWidth / 2),
            
            orImage.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: 10),
            orImage.leadingAnchor.constraint(equalTo: actionButton.leadingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            
            exitButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            exitButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupName() {
        self.presenter.setupName()
    }
    private func changeName() {
        self.presenter.changeTurn()
    }
    
    // MARK: - @objc methods
    @objc
    private func tapTruthButton() {
        self.presenter.onTruthOrAction(game: .truth)
    }
    @objc
    private func tapActionButton() {
        self.presenter.onTruthOrAction(game: .action)
    }
    @objc
    private func tapExitButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extensions
extension ChooseViewController: ChooseView {
    func showDetail(game: Game) {
        let detailVC = DetailViewController(game: game)
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .flipHorizontal
        self.present(detailVC, animated: true) {[weak self] in
            self?.changeName()
        }
    }
    
    func setup(name: String, turn: Turn) {
        self.nameLabel.text = name
        switch turn {
        case .his:
            self.nameLabel.textColor = UIColor.mainDark
        case .her:
            self.nameLabel.textColor = UIColor.main
        }
    }
}
