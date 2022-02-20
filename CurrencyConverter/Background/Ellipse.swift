//
//  Ellipse.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 28.01.2022.
//

import Foundation
import UIKit

class Ellipse: UILabel {
    func createEllipse(_ view: UIView) {
        ellipseVeryLightBlue(view)
        ellipseLightBlue(view)
        ellipseBlue(view)
    }
    
    func ellipseBlue (_ view: UIView) {
        let ellipseBlue = UILabel()
        ellipseBlue.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        
        let parent = view
        parent.addSubview(ellipseBlue)
        parent.insertSubview(ellipseBlue, at: 0)
        ellipseBlue.translatesAutoresizingMaskIntoConstraints = false
        ellipseBlue.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        ellipseBlue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20).isActive = true
        ellipseBlue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        ellipseBlue.topAnchor.constraint(equalTo: view.topAnchor, constant: -view.frame.width / 3 ).isActive = true
        ellipseBlue.layer.cornerRadius = 150
        
    }
    func ellipseLightBlue (_ view: UIView) {
        let ellipseLightBlue = UILabel()
        ellipseLightBlue.layer.backgroundColor = UIColor(red: 0.1, green: 0.531, blue: 1, alpha: 1).cgColor
        let parent = view
        parent.addSubview(ellipseLightBlue)
        parent.insertSubview(ellipseLightBlue, at: 0)
        ellipseLightBlue.translatesAutoresizingMaskIntoConstraints = false
        ellipseLightBlue.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        ellipseLightBlue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -30).isActive = true
        ellipseLightBlue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        ellipseLightBlue.topAnchor.constraint(equalTo: view.topAnchor, constant: -view.frame.width / 2.5 ).isActive = true
        ellipseLightBlue.layer.cornerRadius = 150
        
    }
    
    func ellipseVeryLightBlue(_ view: UIView) {
        let ellipseVeryLightBlue = UILabel()
        ellipseVeryLightBlue.layer.backgroundColor = UIColor(red: 0.2, green: 0.583, blue: 1, alpha: 1).cgColor
        let parent = view
        parent.addSubview(ellipseVeryLightBlue)
        parent.insertSubview(ellipseVeryLightBlue, at: 0)
        ellipseVeryLightBlue.translatesAutoresizingMaskIntoConstraints = false
        ellipseVeryLightBlue.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        ellipseVeryLightBlue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -50).isActive = true
        ellipseVeryLightBlue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        ellipseVeryLightBlue.topAnchor.constraint(equalTo: view.topAnchor, constant: -view.frame.width / 2.2 ).isActive = true
        ellipseVeryLightBlue.layer.cornerRadius = 150
    }
}
