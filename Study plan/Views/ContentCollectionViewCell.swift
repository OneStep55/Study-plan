//
//  ContentCollectionViewCell.swift
//  Study plan
//
//  Created by Самат Танкеев on 21.06.2023.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    
    
    static let identifier = "ContentCollectionViewCell"
    
    private var rowHeights: [CGFloat] = []
    
    private var collectionView: UICollectionView = {
        let layout = StickyGridCollectionViewLayout()
     
        layout.stickyColumnsCount = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        collectionView.contentInset = .zero
        
      
        collectionView.bounces = false
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        
        collectionView.showsHorizontalScrollIndicator = true
        
        return collectionView
        
    }()

    
    
    private var disciplines: [Discipline] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
         
        collectionView.frame = bounds
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        
      }

    
    func configure(with disciplines: [Discipline]) {
         self.disciplines = disciplines
         collectionView.reloadData()
        
      
     }
    
    
    
}

extension ContentCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return disciplines.count + 1
    
    
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.identifier,
            for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.section == 0 {
            cell.configure(section: indexPath.row)
        } else {
            let discipline = disciplines[indexPath.section - 1]
            cell.configure(section: indexPath.row, with: discipline)
            
        }
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.backgroundColor =  .white
        return cell
    }
    
    
    
}

extension ContentCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            let labelWidth = 150 - 10 // Adjust for content inset
            let labelFont = UIFont.systemFont(ofSize: 17) // Use your label's font
            let label = UILabel()
            label.text = "Наименнование дисциплины"
            if indexPath.section > 0 {
                label.text = disciplines[indexPath.section - 1].disciplineName.nameRu// Use your content
            }
            label.numberOfLines = 0
            
            let labelSize = label.sizeThatFits(CGSize(width: labelWidth, height: 2000))
            let height = max(labelSize.height + 10, 100)
            rowHeights.append(height)
            return CGSize(width: 150, height: height) // Adjust for content inset
            
           
           
        }
        return CGSize(width: 100, height: rowHeights[indexPath.section])
    }
}
