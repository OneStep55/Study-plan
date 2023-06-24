//
//  TestVIewController2.swift
//  Study plan
//
//  Created by Самат Танкеев on 21.06.2023.
//

import UIKit

class TestViewControllerTwo: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Second controller"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        configure()
    }
    

    func configure() {
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
