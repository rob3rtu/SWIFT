//
//  ViewController.swift
//  ToDoList
//
//  Created by Robert Udrea on 13.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    public var taskList: [String] = ["Demonstration task"]

    @IBOutlet var addTaskButton: UIButton!
    @IBOutlet var taskTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! AddTaskVC
        
        dest.home = self
    }
    
    @IBAction func addTaskButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "addTask", sender: nil)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.textLabel?.text = taskList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
