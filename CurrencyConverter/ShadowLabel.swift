//
//  ShadowLabel.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 28.01.2022.
//

import Foundation
import UIKit

class ShadowLabel: UILabel {
    func labelBackground(_ view: UIView, _ background: UILabel) {
        background.layer.cornerRadius = 10
        background.layer.borderColor = UIColor.systemGray3.cgColor
        background.layer.borderWidth = 0.5
        background.clipsToBounds = false
        background.layer.backgroundColor = UIColor.white.cgColor
        background.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        background.layer.shadowOffset = CGSize(width: 0, height: 4)
        background.layer.shadowOpacity = 1
        background.layer.shadowRadius = 4
    }
}
