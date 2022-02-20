//
//  RefreshManager.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 01.02.2022.
//

import Foundation

class RefreshManager: NSObject {
    
    static let shared = RefreshManager()
    private let defaults = UserDefaults.standard
    private let defaultsKeyData = "lastRefresh"
    let networkManager = NetworkManager()
    var saleUsd: Float?
    var saleEuro: Float?
    var saleRub: Float?
    var buyUsd: Float?
    var buyEuro: Float?
    var buyRub: Float?
    var resultCurrency = [Currency]()
    private let calender = Calendar.current
    func loadDataIfNeeded(completion: (Bool) -> Void) {
        if isRefreshRequired() {
            defaults.set(Date(), forKey: defaultsKeyData)
            completion(true)
        } else {
            completion(false)
        }
    }
    
    private func isRefreshRequired() -> Bool {
        guard let lastRefreshDate = defaults.object(forKey: defaultsKeyData) as? Date else {
            return true
        }
        if let diff = calender.dateComponents([.minute], from: lastRefreshDate, to: Date()).minute, diff >= 60 {
            return true
        } else {
            return false
        }
    }
}
