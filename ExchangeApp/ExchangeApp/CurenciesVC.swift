//
//  CurenciesVC.swift
//  ExchangeApp
//
//  Created by Robert Udrea on 09.02.2023.
//

import UIKit

class CurenciesVC: UIViewController {
    
    var apiClient: APIHandler?
    var home:HomePageVC?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! HomePageVC
        
        if apiClient?.turn == "from" {
            home?.setFromCurency(value: sender as? String ?? "")
            apiClient?.fromCurency = sender as? String ?? ""
        } else {
            home?.setToCurency(value: sender as? String ?? "")
            apiClient?.toCurency = sender as? String ?? ""
        }
    }

}

extension CurenciesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiClient?.curencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "curencyCell") as? CustomCell else {
            return UITableViewCell()
        }
        
        cell.symbol?.text = apiClient?.curencies[indexPath.row].code ?? "?"
        cell.name?.text = apiClient?.curencies[indexPath.row].description ?? "??"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goBack", sender: apiClient?.curencies[indexPath.row].code)
    }
}
