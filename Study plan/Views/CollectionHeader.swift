//
//  CollectionHeader.swift
//  Study plan
//
//  Created by Самат Танкеев on 24.06.2023.
//

import UIKit

class CollectionHeader: UIView {

    let  nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Наименование дисциплины"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let lectureLabel: UILabel = {
        let label = UILabel()
        label.text = "Лекция"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seminarLabel : UILabel = {
        let label = UILabel()
        label.text = "Семинар"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labartoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Лабораторная"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorLine: UIView = {
           let view = UIView()
           view.backgroundColor = UIColor.gray
           return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(lectureLabel)
        addSubview(seminarLabel)
        addSubview(labartoryLabel)
        configureConstrains()
        
        separatorLine.frame = CGRect(x: 0,
                                     y: frame.height - 1,
                                     width: frame.width,
                                     height: 1)
    }
    
    func configureConstrains() {
        
        let nameLabelConstrains = [
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 180)
        ]
        
        let lectureLabelConstrains = [
            lectureLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 25),
            lectureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            lectureLabel.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let seminarLabelConstrains = [
            seminarLabel.leadingAnchor.constraint(equalTo: lectureLabel.trailingAnchor, constant: 20),
            seminarLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            seminarLabel.widthAnchor.constraint(equalToConstant:80)
        ]
        
        let labartoryLabelConstrains = [
            labartoryLabel.leadingAnchor.constraint(equalTo: seminarLabel.trailingAnchor, constant: 20),
            labartoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            labartoryLabel.widthAnchor.constraint(equalToConstant:80)
        ]
        
        NSLayoutConstraint.activate(nameLabelConstrains)
        NSLayoutConstraint.activate(lectureLabelConstrains)
        NSLayoutConstraint.activate(seminarLabelConstrains)
        NSLayoutConstraint.activate(seminarLabelConstrains)
        NSLayoutConstraint.activate(labartoryLabelConstrains)
        
        addSeparatorLine(after: nameLabel)
        addSeparatorLine(after: lectureLabel)
        addSeparatorLine(after: seminarLabel)
        addSeparatorLine(after: labartoryLabel)
    }
    
    private func addSeparatorLine(after label: UILabel) {
        let separatorView = UIView()
        separatorView.backgroundColor = .gray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorView)
        
        // Add separator view constraints
        
        
        NSLayoutConstraint.activate([
            separatorView.widthAnchor.constraint(equalToConstant: 1),
            separatorView.topAnchor.constraint(equalTo:topAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10)
        ])
    }

}
