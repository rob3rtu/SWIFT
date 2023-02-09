//
//  ViewController.swift
//  ExchangeApp
//
//  Created by Robert Udrea on 30.01.2023.
//

import UIKit

class HomePageVC: UIViewController {
    @IBOutlet var inputField: UITextField!
    @IBOutlet var convertButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var fromButton: UIButton!
    @IBOutlet var toButton: UIButton!
    
    var initial: Float          = 0
    var converted: Float        = 0
    
    var apiClient:APIHandler    = APIHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.addTarget(self, action: #selector(onChangeInput(_:)), for: .editingChanged)
        inputField.delegate     = self
        resultLabel.text        = "Result:\n\n\(converted)"
        
        Task {
            await apiClient.getCurencies()
//            print(apiClient.curencies)
            fromButton.setTitle(apiClient.fromCurency, for: .normal)
            toButton.setTitle(apiClient.toCurency, for: .normal)
        }
                
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
            self.view.addGestureRecognizer(tapGestureBackground)
    }
    
    func setFromCurency(value: String) {
        fromButton.setTitle(value, for: .normal)
    }
    
    func setToCurency(value: String) {
        toButton.setTitle(value, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! CurenciesVC
        
        destVC.apiClient = sender as? APIHandler
        destVC.home = self
    }
    
    
    @objc func onChangeInput(_ textField: UITextField) {
        initial = Float(textField.text ?? "0") ?? 0
        print(initial)
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        Task {
            await apiClient.convert(amount: initial)
            resultLabel.text = "Result:\n\n\(apiClient.convertedValue)"
        }
    }
    
    @IBAction func fromButtonTapped(_ sender: UIButton) {
        apiClient.turn = "from"
        performSegue(withIdentifier: "toCurencies", sender: apiClient)
    }
    
    @IBAction func toButtonTapped(_ sender: UIButton) {
        apiClient.turn = "to"
        performSegue(withIdentifier: "toCurencies", sender: apiClient)
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        inputField.endEditing(true)
    }
}

extension HomePageVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
