//
//  ButtonView.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 28.01.2022.
//

import Foundation
import UIKit

class ButtonView: UIButton {
    func buttonView (_ buttonResetOutlet: UIButton) {
        buttonResetOutlet.layer.cornerRadius = 14
        buttonResetOutlet.layer.borderWidth = 1
        buttonResetOutlet.layer.borderColor = CGColor(red: 0, green: 0.478, blue: 1, alpha: 1)
    }
}
