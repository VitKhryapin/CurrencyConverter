//
//  Data.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 28.01.2022.
//

import Foundation


    

struct Currency: Codable {
    var currency: String
    var baseCurrency: String
    var buy: String
    var sale: String
    
    enum CodingKeys: String, CodingKey {
        case currency = "ccy"
        case baseCurrency = "base_ccy"
        case buy
        case sale
    }

    
    
    
    
}
struct Rate: Codable {
    var baseCurrency: String
    var currency: String
    var saleRateNB: Double
    var purchaseRateNB: Double
}

struct CurrencyArchiev: Codable {
    var date: String = ""
    var exchangeRate: [Rate] = []
}





