//
//  TestViewController1.swift
//  Study plan
//
//  Created by Самат Танкеев on 21.06.2023.
//

import UIKit

class TestViewControllerOne: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "First controller"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        configure()
        // Do any additional setup after loading the view.
    }
    

    func configure() {
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
