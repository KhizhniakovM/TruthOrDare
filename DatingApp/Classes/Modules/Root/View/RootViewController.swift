//
//  RootViewController.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//
import Foundation
import UIKit

class RootViewController: BaseViewController {
    // MARK: - Properties
    var presenter: RootViewPresenter!

    // MARK: - UI
    lazy private var mainLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mainLabel")
        return imageView
    }()
    lazy private var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = Fonts.MontserratBlack.of(size: 41)
        button.setTitleColor(UIColor.main, for: .normal)
        button.setTitle("Начать!", for: .normal)
        button.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
        return button
    }()
    
    // Heart-buttons in stack
    lazy private var helpButton: UIButton = {
        let button = UIButton.getHeartButton(withImage: "help")
        button.addTarget(self, action: #selector(tapHelpButton), for: .touchUpInside)
        return button
    }()
    lazy private var rateButton: UIButton = {
        let button = UIButton.getHeartButton(withImage: "rate")
        button.addTarget(self, action: #selector(tapRateButton), for: .touchUpInside)
        return button
    }()
    lazy private var mailButton: UIButton = {
        let button = UIButton.getHeartButton(withImage: "mail")
        button.addTarget(self, action: #selector(tapMailButton), for: .touchUpInside)
        return button
    }()
    lazy private var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [helpButton, rateButton, mailButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    // TextFields
    lazy private var hisTextField: UITextField = UITextField.getCoolTextField()
    lazy private var herTextField: UITextField = UITextField.getCoolTextField()
    lazy private var hisLabel: UILabel = UILabel.getCoolLabel(withText: "Его имя:", andColor: UIColor.mainDark, andSize: 12)
    lazy private var herLabel: UILabel = UILabel.getCoolLabel(withText: "Её имя:", andColor: UIColor.main, andSize: 12)
    lazy private var hisImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "he"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy private var herImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "she"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy private var hisTextFieldStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [hisLabel, hisTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    lazy private var herTextFieldStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [herLabel, herTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        return stack
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addObservers()
        
        // Delegate
        hisTextField.delegate = self
        herTextField.delegate = self
    }
    
    // MARK: - Methods
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func setupUI() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        self.view.addSubview(mainLabel)
        self.view.addSubview(startButton)
        self.view.addSubview(buttonsStack)
        self.view.addSubview(hisTextFieldStack)
        self.view.addSubview(herTextFieldStack)
        self.view.addSubview(hisImage)
        self.view.addSubview(herImage)
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: screenHeight / 10),
            mainLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: screenWidth / 5),
            mainLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -screenWidth / 5),
            
            startButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -screenHeight / 10),
            startButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: screenWidth / 5),
            startButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -screenWidth / 5),
            
            buttonsStack.bottomAnchor.constraint(equalTo: self.startButton.topAnchor, constant: -screenHeight / 30),
            buttonsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: screenWidth / 5),
            buttonsStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -screenWidth / 5),
            buttonsStack.heightAnchor.constraint(equalToConstant: 40),
            
            hisTextFieldStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            hisTextFieldStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -screenWidth / 10),
            hisTextField.trailingAnchor.constraint(equalTo: self.herTextField.trailingAnchor),
            hisTextField.widthAnchor.constraint(equalToConstant: screenWidth / 3),
            
            herTextFieldStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            herTextFieldStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: screenWidth / 10),
            herTextField.leadingAnchor.constraint(equalTo: self.hisTextField.leadingAnchor),
            
            hisImage.centerYAnchor.constraint(equalTo: self.hisTextFieldStack.centerYAnchor),
            hisImage.trailingAnchor.constraint(equalTo: self.hisTextFieldStack.leadingAnchor, constant: -10),
            
            herImage.centerYAnchor.constraint(equalTo: self.herTextFieldStack.centerYAnchor),
            herImage.leadingAnchor.constraint(equalTo: self.herTextFieldStack.trailingAnchor, constant: 10),
            
            hisImage.widthAnchor.constraint(equalToConstant: screenWidth / 4.5),
            herImage.widthAnchor.constraint(equalToConstant: screenWidth / 5)
        ])
    }
    
    // MARK: - @objc methods
    @objc
    private func tapStartButton() {
        guard hisTextField.text != "" && herTextField.text != "" else { return }
        guard let hisName = hisTextField.text, let herName = herTextField.text else { return }
        self.presenter.onGame(hisName: hisName, herName: herName)
    }
    @objc
    private func tapHelpButton() {
        self.presenter.onTutorial()
    }
    @objc
    private func tapRateButton() {
        self.presenter.onRate()
    }
    @objc
    private func tapMailButton() {
        self.presenter.onMail()
    }
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height / 2
        }
    }
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
// MARK: - Extensions
extension RootViewController: RootView {
    func showChoose(hisName: String, herName: String) {
        let chooseVC = ChooseViewController()
        let choosePresenter = ChoosePresenter(view: chooseVC)
        choosePresenter.setupNames(hisName: hisName, herName: herName)
        chooseVC.presenter = choosePresenter
        self.hisTextField.text = nil
        self.herTextField.text = nil
        self.navigationController?.pushViewController(chooseVC, animated: true)
    }
    
    func showTutorial() {
        let tutorialVC = TutorialViewController()
        tutorialVC.modalPresentationStyle = .fullScreen
        tutorialVC.modalTransitionStyle = .crossDissolve
        self.present(tutorialVC, animated: true, completion: nil)
    }
}
extension RootViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
