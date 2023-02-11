//
//  CurenciesVC.swift
//  ExchangeApp
//
//  Created by Robert Udrea on 09.02.2023.
//

import UIKit

class CurenciesVC: UIViewController {
    
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var curenciesTable: UITableView!
    
    var apiClient: APIHandler?
    var home:HomePageVC?
    
    var filterCurencies: [symbol] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        filterCurencies = apiClient?.curencies ?? []
        curenciesTable.dataSource = self
    }
    
    @IBAction func searchOnChange(_ sender: UITextField) {
        print(sender.text ?? "?")
        filterCurencies = sender.text == "" ? apiClient?.curencies ?? [] :  apiClient?.curencies.filter {
            $0.code.lowercased().contains(sender.text?.lowercased() ?? "") || $0.description.lowercased().contains(sender.text?.lowercased() ?? "")
        } ?? []
        
        curenciesTable.reloadData()
    }
}

extension CurenciesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCurencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "curencyCell") as? CustomCell else {
            return UITableViewCell()
        }
        
        cell.symbol?.text = filterCurencies[indexPath.row].code
        cell.name?.text = filterCurencies[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if apiClient?.turn == "from" {
                    home?.setFromCurency(value: filterCurencies[indexPath.row].code)
                    apiClient?.fromCurency = filterCurencies[indexPath.row].code
                } else {
                    home?.setToCurency(value: filterCurencies[indexPath.row].code)
                    apiClient?.toCurency = filterCurencies[indexPath.row].code
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
}
