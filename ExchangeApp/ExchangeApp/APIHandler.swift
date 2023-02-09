//
//  APIHandler.swift
//  ExchangeApp
//
//  Created by Robert Udrea on 31.01.2023.
//

import UIKit

class APIHandler {
    public var fromCurency: String          = ""
    public var toCurency: String            = ""
    public var turn: String                 = ""
    public var curencies: [symbol]          = []
    public var convertedValue: Float        = 0
    private let topCurencies: [String]      = ["RON", "USD", "EUR", "JPY", "GBT", "CHF", "AUD", "CAD"]
    
    
    public func getCurencies() async {
        guard let url = URL(string: "https://api.exchangerate.host/symbols") else {
            print("Error on URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            var result:Response?
            result = try JSONDecoder().decode(Response.self, from: data)
            
            guard let result = result else {
                print("no result")
                return
            }
            
            for symbol in result.symbols {
                self.curencies.append(symbol.value)
            }
            
            curencies.sort(by: compareSymbols(a:b:))
            fromCurency = curencies.first?.code ?? ""
            toCurency = curencies.first?.code ?? ""
            
        }
        catch {
            print("Some error occurs in api getCurencies")
        }
    }
    
    func compareSymbols(a: symbol, b: symbol) -> Bool {
        return a.description < b.description
    }
    
    public func convert(amount: Float) async {
        guard let url = URL(string: "https://api.exchangerate.host/convert?from=\(fromCurency)&to=\(toCurency)&amount=\(amount)&source=bnro&places=1") else {
            print("Error on url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            var result: Conversion?
            result = try JSONDecoder().decode(Conversion.self, from: data)
            
            guard let result = result else {
                print("no result")
                return
            }
            
            self.convertedValue = result.result
            
        }
        catch {
            print("Error on convert request")
        }
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
