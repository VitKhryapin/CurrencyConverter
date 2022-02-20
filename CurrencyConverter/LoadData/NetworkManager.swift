//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 28.01.2022.
//

import Foundation
enum ObtainResult {
    case success(currency: [Currency])
    case failer(error: Error)
}

class NetworkManager {
    let session = URLSession.shared
    let decoder = JSONDecoder()
    //var dataSource = [Currency]()
    func currency (completion: @escaping (ObtainResult) -> Void) {
        guard let url = URL(string: "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5") else { return }
        session.dataTask(with: url) { [weak self] data, response, error in
            if let response = response {
                print(response)
            }
            var result: ObtainResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            guard let strongSelf = self else {
                result = .success(currency: [])
                return
            }
            if error == nil, let parsData = data  {
                guard let posts = try? strongSelf.decoder.decode([Currency].self, from: parsData) else {
                    result = .success(currency: [])
                    return
                }
                result = .success(currency: posts)
            } else {
                result = .failer(error: error!)
            }
        } .resume()
    }
}
