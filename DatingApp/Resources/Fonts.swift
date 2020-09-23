//
//  Fonts.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//

import UIKit

enum Fonts: String {
    case MontserratBlack = "Montserrat-Black"
    
    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
