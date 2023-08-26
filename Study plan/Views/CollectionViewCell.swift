//
//  CollectionViewCell.swift
//  Study plan
//
//  Created by Самат Танкеев on 26.08.2023.
//

import Foundation

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    private let label: UILabel = {
        let label = UILabel()
        // Configure label properties and styling
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        contentMode = .center
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    

    func configure(section: Int) {
        switch section {
        case 0:
            label.text = "Наименнование дисциплины"
        case 1:
            label.text = "Лекция"
        case 2:
            label.text = "Семинар"
        case 3 :
            label.text = "Лаборат."
        default :
            label.text = ""
        }
    }
    
    func configure(section: Int, with discipline: Discipline) {
        if section == 0 {
            label.text = discipline.disciplineName.nameRu
        } else {
            label.text = ""
            if section < 3 || discipline.lesson.count > 2 {
                let num1 = Int(discipline.lesson[section - 1].realHours)!
                let num2 = Int(discipline.lesson[section - 1].hours)!
                label.attributedText = createAttributedText(number1: num1, number2: num2)
            }
            
        }
  
        
    }
    
    func createAttributedText(number1: Int, number2: Int) -> NSAttributedString {
        let fullText = "\(number1) / \(number2)"
    
        // Create an attributed string
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Set color attributes for different segments
        let greenColor = UIColor.systemGreen
        let grayColor = UIColor.gray
        let redColor = UIColor.systemRed
        
        let separatorRange = (fullText as NSString).range(of: " / ")
        let number1Range = NSRange(location: 0, length: separatorRange.location)
        let number2Range = NSRange(location: separatorRange.location + separatorRange.length, length: fullText.count - (separatorRange.location + separatorRange.length))
        
        attributedString.addAttributes([.foregroundColor: greenColor], range: number1Range)
        attributedString.addAttributes([.foregroundColor: grayColor], range: separatorRange)
        if number1 == number2 {
           
            attributedString.addAttributes([.foregroundColor: greenColor], range: number2Range)
        } else {
            
            attributedString.addAttributes([.foregroundColor: redColor], range: number2Range)
        }
        
        return attributedString
    }
    
    func setupViews() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    
    
    
}
