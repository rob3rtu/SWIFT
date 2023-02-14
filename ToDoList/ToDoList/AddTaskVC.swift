//
//  AddTaskVC.swift
//  ToDoList
//
//  Created by Robert Udrea on 13.02.2023.
//

import UIKit

class AddTaskVC: UIViewController {
    
    @IBOutlet var taskInput: UITextField!
    
    public var home: ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        taskInput.becomeFirstResponder()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
           view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let task = taskInput.text {
            if task != "" {
                home?.taskList.append(task)
                home?.taskTable.reloadData()
                home?.storage.set(home?.taskList, forKey: "list")
                dismiss(animated: true)
            }
        }
    }
    
    @IBAction func taskInputChange(_ sender: UITextField) {
    }
    

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        //go back without adding the task
        dismiss(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        //add the task and go back
        
        if let task = taskInput.text {
            if task != "" {
                home?.taskList.append(task)
                home?.taskTable.reloadData()
                home?.storage.set(home?.taskList, forKey: "list")
                dismiss(animated: true)
            }
        }
    }
    
    
}
