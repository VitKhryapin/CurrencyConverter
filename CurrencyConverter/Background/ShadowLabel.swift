//
//  ShadowLabel.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 28.01.2022.
//

import Foundation
import UIKit

class ShadowLabel: UILabel {
    lazy var shadowLayer: CALayer = {
        let shadowLayer = CALayer()
        shadowLayer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shadowLayer.cornerRadius = 10
        shadowLayer.borderColor = UIColor.systemGray3.cgColor
        shadowLayer.borderWidth = 0.5
        shadowLayer.masksToBounds = false
        shadowLayer.backgroundColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 4)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 4
        return shadowLayer
    }()

    override var bounds: CGRect {
        didSet {
            updateShadow()
        }
    }

    func updateShadow() {
        if shadowLayer.superlayer == nil {
            self.layer.insertSublayer(shadowLayer, at: 0)
        }
        shadowLayer.frame = self.bounds
    }
}
