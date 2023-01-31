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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.delegate = self
        
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
            self.view.addGestureRecognizer(tapGestureBackground)
        
        //separate function to initialize the menus
        menuTo.menu = UIMenu(children: [
            UIAction(title: "First", handler: menuAction),
            UIAction(title: "Second", handler: menuAction)
        ])
        menuFrom.menu = UIMenu(children: [
            UIAction(title: "First", handler: menuAction),
            UIAction(title: "Second", handler: menuAction),
        ])
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        inputField.endEditing(true)
    }
    
    func menuAction(action: UIAction) {
        //setting 'from' and 'to' curencies according to action's title
        print(action.title)
    }

    @IBAction func inputFieldAction(_ sender: UITextField, forEvent event: UIEvent) {
        //set the 'from' value that needs to be converted
        print(sender.text!)
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        //converting the value
    }
}

extension HomePageVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
