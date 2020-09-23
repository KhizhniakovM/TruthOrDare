//
//  Buttons.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//

import UIKit

extension UIButton {
    static func getHeartButton(withImage name: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: name), for: .normal)
        return button
    }
    static func getCoolButton() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = Fonts.MontserratBlack.of(size: 20)
        button.setTitleColor(UIColor.mainDark, for: .normal)
        button.setTitle("Готово!", for: .normal)
        button.backgroundColor = .white
        
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.mainDark.cgColor
        return button
    }
}

extension UILabel {
    static func getCoolLabel(withText text: String, andColor color: UIColor, andSize size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.MontserratBlack.of(size: size)
        label.textColor = color
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }
}

extension UITextField {
    static func getCoolTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.main.cgColor
        textField.layer.borderWidth = 2
        textField.font = Fonts.MontserratBlack.of(size: 15)
        textField.textColor = UIColor.mainDark
        textField.returnKeyType = .done
        return textField
    }
}
