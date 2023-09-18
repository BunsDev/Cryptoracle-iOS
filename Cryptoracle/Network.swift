//
//  Network.swift
//  Cryptoracle
//
//  Created by Daniel on 17/09/23.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import SwiftUI

class Network: ObservableObject {
    
    @Published var cryptocurrencies: [Cryptocurrency] = []
    
    func getCryptocurrencies() {
        self.cryptocurrencies = []
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd")!,timeoutInterval: Double.infinity)
        request.addValue("__cf_bm=A9FqoO7CieQ.QrbpMnA8VEtq6JiCm5835bGl7Hv9yOI-1695011911-0-AZueNHTc/mJG2V2lSF54RSJBFEwoDCJT+OKDZr00vVEgh1iyd4hj9NXsZk1lS+1AGhRwcoun89D6G81XaoDxwfE=", forHTTPHeaderField: "Cookie")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            DispatchQueue.main.async {
                do {
                    let decodedCryptocurrencies = try JSONDecoder().decode([Cryptocurrency].self, from: data)
                    self.cryptocurrencies = decodedCryptocurrencies
                } catch let error {
                    print("Error decoding: \(error)")
                }
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
    }
    
}
