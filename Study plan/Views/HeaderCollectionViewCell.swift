//
//  HeaderCollectionViewCell.swift
//  Study plan
//
//  Created by Самат Танкеев on 21.06.2023.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HeaderCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var text: String! {
        didSet {
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(label)
        self.addSubview(indicator)
        configureConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select(didSelect: Bool, activeColor: UIColor, inActiveColor: UIColor){
        indicator.backgroundColor = activeColor
        
        if didSelect {
            label.textColor = activeColor
            indicator.isHidden = false
        }else{
            label.textColor = inActiveColor
            indicator.isHidden = true
        }
    }
    
    private func configureConstrains(){
  
        
        // label
       
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        // indicator
      
        indicator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        indicator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        indicator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
}
