//
//  CWButton.swift
//  CardWorkout-Programmatic
//
//  Created by Robert Udrea on 28.01.2023.
//

import UIKit

class CWButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    //for initialization via storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String, systemImageName: String) {
        super.init(frame: .zero)
        
        //ios 15 buttons style
        configuration = .tinted()
        configuration?.title = title
        configuration?.baseBackgroundColor = backgroundColor
        configuration?.baseForegroundColor = backgroundColor
        configuration?.cornerStyle = .medium
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 5
        
        
//        self.backgroundColor = backgroundColor
//        setTitle(title, for: .normal)
        configure()
    }
    
    func configure() {
//        layer.cornerRadius = 8
//        titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
//        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false   //aka use auto layout
    }
}
