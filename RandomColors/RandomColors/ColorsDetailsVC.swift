//
//  ColorsDetailsVC.swift
//  RandomColors
//
//  Created by Robert Udrea on 24.01.2023.
//

import UIKit

class ColorsDetailsVC: UIViewController {
    var color: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = color ?? .white
    }
}
