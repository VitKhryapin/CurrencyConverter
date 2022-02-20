//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 16.02.2022.
//

import UIKit

protocol CurrencyCellDelegate {
    func editTextField(sender: CurrencyCell, countCurrency: Double)
}


class CurrencyCell: UITableViewCell {
   
    var delegate: CurrencyCellDelegate?
    
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var nameCurrency: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
        
        // Configure the view for the selected state
    }

    
    func setupValueBuyCell(value: Currency, indexPath: IndexPath, baseValue: Double) {
        if value.buy != "" {
        self.nameCurrency.text = "\(value.currency) >"
        self.tfValue.text = "\(NSString(format: "%.2f",  baseValue / Double(value.buy)!))"
        }
        if indexPath.row != 0 {
            self.tfValue.isUserInteractionEnabled = false
        }
//        if indexPath.row == 0 {
//            self.nameCurrency.text = "UAH >"
//        } else {
//            self.nameCurrency.text = "\(value.currency) >"
//            self.tfValue.text = "\(NSString(format: "%.2f",  baseValue / Double(value.buy)!))"
//            self.tfValue.isUserInteractionEnabled = false
//        }
    }
    
    func setupValueSaleCell(value: Currency, indexPath: IndexPath, baseValue: Double) {
        if value.sale != "" {
            self.nameCurrency.text = "\(value.currency) >"
            self.tfValue.text = "\(NSString(format: "%.2f", baseValue / Double(value.sale)!))"
        }
        if indexPath.row != 0 {
            self.tfValue.isUserInteractionEnabled = false
        }
        
//        if indexPath.row == 0 {
//            self.nameCurrency.text = "UAH >"
//        } else {
//            self.nameCurrency.text = "\(value.currency) >"
//            self.tfValue.text = "\(NSString(format: "%.2f", baseValue / Double(value.sale)!))"
//            self.tfValue.isUserInteractionEnabled = false
//        }
    }
    
    @IBAction func changedTF(_ sender: UITextField) {
        if let lastSymbol = sender.text?.last {
            if !lastSymbol.isNumber {
                sender.text?.removeLast()
            }
        }
        if let text = sender.text {
            sender.text = text.filter{$0.isNumber}
        }
    }
    
    @IBAction func boundsTF(_ sender: UITextField) {
        self.tfValue.layer.borderWidth = 1
        self.tfValue.layer.cornerRadius = 5
        self.tfValue.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @IBAction func didEnd(_ sender: UITextField) {
        self.tfValue.layer.borderWidth = 0
        if delegate != nil && Double(sender.text!) != nil  {
            delegate?.editTextField(sender: self, countCurrency: Double(sender.text!)!)
        }
    }
}
