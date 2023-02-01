//
//  ViewController.swift
//  ExchangeApp
//
//  Created by Robert Udrea on 30.01.2023.
//

import UIKit

class HomePageVC: UIViewController {
    @IBOutlet var inputField: UITextField!
    @IBOutlet var menuTo: UIButton!
    @IBOutlet var menuFrom: UIButton!
    @IBOutlet var convertButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    

    var initial: Float          = 0
    var converted: Float        = 0
    
    var fromCurency: String     = ""
    var toCurency: String       = ""
    
    var apiClient:APIHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.delegate = self
        inputField.addTarget(self, action: #selector(onChangeInput(_:)), for: .editingChanged)
        resultLabel.text = "Result:\n\n\(converted)"
        
        menuTo.menu = UIMenu(children: [
                    UIAction(title: "First", handler: toMenuAction),
                    UIAction(title: "Second", handler: toMenuAction)
                ])
        menuFrom.menu = UIMenu(children: [
                    UIAction(title: "First", handler: toMenuAction),
                    UIAction(title: "Second", handler: toMenuAction),
                ])
        
        apiClient = APIHandler()
//        print(apiClient?.symbols ?? "no symbols from apiClient")
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(menusInit), userInfo: nil, repeats: false)
        
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
            self.view.addGestureRecognizer(tapGestureBackground)
    }
    
    @objc func menusInit() {
        print(apiClient?.symbols ?? "")
        
        menuTo.menu = UIMenu(children: symbolToChildren(symbols: apiClient?.symbols ?? [], type: "to"))
        menuFrom.menu = UIMenu(children: symbolToChildren(symbols: apiClient?.symbols ?? [], type: "from"))
        
        fromCurency = apiClient?.symbols.first ?? ""
        toCurency = apiClient?.symbols.first ?? ""
    }
    
    func symbolToChildren(symbols: [String], type: String) -> [UIAction] {
        var rez: [UIAction] = []
        
        for symbol in symbols.sorted() {
            if type == "to" {
                rez.append(UIAction(title: symbol, handler: toMenuAction))
            } else {
                rez.append(UIAction(title: symbol, handler: fromMenuAction))
            }
        }
        
        return rez
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        inputField.endEditing(true)
    }
    
    func toMenuAction(action: UIAction) {
        toCurency = action.title
    }
    
    func fromMenuAction(action: UIAction) {
        fromCurency = action.title
    }
    
    @objc func onChangeInput(_ textField: UITextField) {
        initial = Float(textField.text ?? "0") ?? 0
        print(initial)
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        //converting the value
        
        apiClient?.convert(from: fromCurency, to: toCurency, amount: initial)
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(showConvertedValue), userInfo: nil, repeats: false)
    }
    
    @objc func showConvertedValue() {
        resultLabel.text = "Result:\n\n\(apiClient?.convertedValue ?? 0)"
    }
}

extension HomePageVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
