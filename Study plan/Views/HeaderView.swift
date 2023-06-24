//
//  HeaderView.swift
//  Study plan
//
//  Created by Самат Танкеев on 24.06.2023.
//

import UIKit

class HeaderView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Индивидуальный учебный план на 2020 - 2021 учебный год"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        confiugreConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confiugreConstrains() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        ])
    }
    
    func setTitle(_ title: String) {
        label.text = title
    }
    
}
