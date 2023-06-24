//
//  DisciplineCell.swift
//  Study plan
//
//  Created by Самат Танкеев on 22.06.2023.
//

import UIKit

class DisciplineCell: UICollectionViewCell {
    
    static let identifier = "DisciplineCell"
    private let nameLabel: UILabel = {
        let label = UILabel()
        // Configure label properties and styling
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let separatorLine: UIView = {
           let view = UIView()
           view.backgroundColor = UIColor.gray
           return view
    }()
    
    let topSeparateLine: UIView = {
           let view = UIView()
           view.backgroundColor = UIColor.gray
           return view
    }()
    

    
    let hoursLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hoursLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hoursLabel3 : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        // Add and position nameLabel and hoursLabel in the cell's contentView
        // Apply any additional styling or customization to the labels
        contentView.addSubview(nameLabel)
//        contentView.addSubview(hoursLabel)
        
        contentView.addSubview(separatorLine)
        
        contentView.addSubview(hoursLabel1)
        
        contentView.addSubview(hoursLabel2)
        
        contentView.addSubview(hoursLabel3)
        
        configureConstrains()
        
        separatorLine.frame = CGRect(x: 0,
                                     y: contentView.frame.height - 1,
                                     width: contentView.frame.width,
                                     height: 1)
        
    }
    
    
    
    private func addSeparatorLine(after label: UILabel) {
        let separatorView = UIView()
        separatorView.backgroundColor = .gray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separatorView)
        
        // Add separator view constraints
        
        
        NSLayoutConstraint.activate([
            separatorView.widthAnchor.constraint(equalToConstant: 1),
            separatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10)
        ])
    }
    
    private func configureConstrains() {
        
        let nameLabelConstrains = [
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 180)
        ]
        
        let hoursLabel1Constrains = [
            hoursLabel1.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 25),
            hoursLabel1.centerYAnchor.constraint(equalTo: centerYAnchor),
            hoursLabel1.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let hoursLabel2Constrains = [
            hoursLabel2.leadingAnchor.constraint(equalTo: hoursLabel1.trailingAnchor, constant: 20),
            hoursLabel2.centerYAnchor.constraint(equalTo: centerYAnchor),
            hoursLabel2.widthAnchor.constraint(equalToConstant:80)
        ]
        
        let hoursLabel3Constrains = [
            hoursLabel3.leadingAnchor.constraint(equalTo: hoursLabel2.trailingAnchor, constant: 20),
            hoursLabel3.centerYAnchor.constraint(equalTo: centerYAnchor),
            hoursLabel3.widthAnchor.constraint(equalToConstant:80)
        ]
        
        

        
        NSLayoutConstraint.activate(nameLabelConstrains)
        NSLayoutConstraint.activate(hoursLabel1Constrains)
        NSLayoutConstraint.activate(hoursLabel2Constrains)
        NSLayoutConstraint.activate(hoursLabel3Constrains)
        
        addSeparatorLine(after: nameLabel)
        addSeparatorLine(after: hoursLabel1)
        addSeparatorLine(after: hoursLabel2)
        addSeparatorLine(after: hoursLabel3)
    }

    func configure(with discipline: Discipline) {
    
        nameLabel.text = discipline.disciplineName.nameRu
        
        var num1 = Int(discipline.lesson[0].realHours)!
        var num2 = Int(discipline.lesson[0].hours)!
        hoursLabel1.attributedText = createAttributedText(number1: num1, number2: num2)
        
         num1 = Int(discipline.lesson[1].realHours)!
        num2 = Int(discipline.lesson[1].hours)!
        hoursLabel2.attributedText = createAttributedText(number1: num1, number2: num2)
        
        if discipline.lesson.count > 2 {
            num1 = Int(discipline.lesson[2].realHours)!
            num2 = Int(discipline.lesson[2].hours)!
            hoursLabel3.attributedText = createAttributedText(number1: num1, number2: num2)
        }
    
        
        
    }
    
    func configure(){
        nameLabel.text = "Наименнование дисциплины"
        hoursLabel1.text = "Лекция"
        hoursLabel2.text = "Семинар"
        hoursLabel3.text = "Лаборат."
        addSubview(topSeparateLine)
        topSeparateLine.frame = CGRect(x: 0,
                                       y: 0,
                                       width: contentView.frame.width,
                                       height: 1)
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
}
