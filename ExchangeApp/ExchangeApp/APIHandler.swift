//
//  APIHandler.swift
//  ExchangeApp
//
//  Created by Robert Udrea on 31.01.2023.
//

import UIKit

class APIHandler {
    public var symbols: [String] = []
    public var convertedValue: Float = 0
    private let topCurencies: [String] = ["RON", "USD", "EUR", "JPY", "GBT", "CHF", "AUD", "CAD"]
    
    init() {
        //make the request
        let url = URL(string: "https://api.exchangerate.host/symbols")
        URLSession.shared.dataTask(with: url!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong!")
                return
            }
            
            var result:Response?
            
            do{
                result = try JSONDecoder().decode(Response.self, from: data)
            }catch {
                print("Error converting the result")
            }
            
            guard let result = result else {
                print("no result")
                return
            }
            
            print(result.symbols.keys)
            
            for key in result.symbols.keys {
                if self.topCurencies.contains(key) {
                    self.symbols.append(key)
                }
            }
            
        }).resume()
    }
    
    public func convert(from: String, to: String, amount: Float) {
        let url = URL(string: "https://api.exchangerate.host/convert?from=\(from)&to=\(to)&amount=\(amount)&source=bnro&places=1")
        
        URLSession.shared.dataTask(with: url!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Error on conversion")
                return
            }
            
            var result: Conversion?
            
            do{
                result = try JSONDecoder().decode(Conversion.self, from: data)
            }catch {
                print("Error converting the result")
            }
            
            guard let result = result else {
                print("no result")
                return
            }
            
            print("Converted value")
            print(result.result)
            
            self.convertedValue = result.result
            
        }).resume()
    }
    
}

struct Conversion: Codable {
    let success: Bool
    let result: Float
}

struct Response: Codable {
    let success: Bool
    let symbols: [String:symbol]
}

struct symbol: Codable {
    let description: String
    let code: String
}
