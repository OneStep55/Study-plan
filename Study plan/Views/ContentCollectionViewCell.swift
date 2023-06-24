//
//  ContentCollectionViewCell.swift
//  Study plan
//
//  Created by Самат Танкеев on 21.06.2023.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ContentCollectionViewCell"
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        collectionView.contentInset = .zero
    
    
       
        collectionView.register(DisciplineCell.self,
                                forCellWithReuseIdentifier: DisciplineCell.identifier)
        
      
        
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

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DisciplineCell.identifier,
            for: indexPath) as? DisciplineCell else {
            return UICollectionViewCell()
        }
        if (indexPath.row == 0) {
            cell.configure()
            return cell
        }
        let discipline = disciplines[indexPath.row - 1]
        cell.configure(with: discipline)
        return cell
    }
    
    
}

extension ContentCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: bounds.width + 110 , height: 98)
    }
    
  
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        return CGSize(width: bounds.width + 110, height: 91)
//    }
    
}
