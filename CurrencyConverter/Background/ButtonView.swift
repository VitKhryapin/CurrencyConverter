//
//  ButtonView.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 28.01.2022.
//

import Foundation
import UIKit

class ButtonView: UIButton {
    lazy var buttonLayer: CAGradientLayer = {
        let buttonLayer = CAGradientLayer()
        buttonLayer.cornerRadius = 14
        buttonLayer.borderWidth = 1
        buttonLayer.borderColor = CGColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        return buttonLayer
    }()

    override var bounds: CGRect {
        didSet {
            updateButton()
        }
    }

    func updateButton() {
        if buttonLayer.superlayer == nil {
            self.layer.insertSublayer(buttonLayer, at: 0)
        }
        buttonLayer.frame = self.bounds
    }
}
