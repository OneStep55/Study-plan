//
//  UISimpleSlidingTabController.swift
//  Study plan
//
//  Created by Самат Танкеев on 21.06.2023.
//

import UIKit


class MainViewController: UIViewController {
    
    var semesters = [Semester]()
    
    let headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lessonsLabel: UILabel = {
        let label = UILabel()
        label.text = "Аудиторные занятия в часах"
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    private let collectionHeader: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(HeaderCollectionViewCell.self,
                                forCellWithReuseIdentifier: HeaderCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let collectionPage: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceHorizontal = false
        collectionView.register(ContentCollectionViewCell.self,
                                forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        return collectionView
    }()
    
    
   

    private var colorHeaderActive = UIColor.blue
    private var colorHeaderInActive = UIColor.gray
    private var colorHeaderBackground = UIColor.white
    private var currentPosition = 0
    private var tabStyle = SlidingTabStyle.fixed
    private let heightHeader: CGFloat = 57
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Индивидуальный учебный план"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
           ]
        navigationController?.navigationBar.barTintColor = .orange
        
        let image = UIImage(systemName: "arrow.down.doc")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .done,
                                                            target: self,
                                                            action: nil)
    
        
        setHeaderActiveColor(color: .blue)
        setHeaderInActiveColor(color: .lightGray)
        build()
    }
    

    
    func setHeaderBackgroundColor(color: UIColor){
        colorHeaderBackground = color
    }
    
    func setHeaderActiveColor(color: UIColor){
        colorHeaderActive = color
    }
    
    func setHeaderInActiveColor(color: UIColor){
        colorHeaderInActive = color
    }
    
    func setCurrentPosition(position: Int){
        currentPosition = position
        let path = IndexPath(item: currentPosition, section: 0)
        
        DispatchQueue.main.async {
            if self.tabStyle == .flexible {
                self.collectionHeader.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
            }
            
            self.collectionHeader.reloadData()
        }
        
        DispatchQueue.main.async {
           self.collectionPage.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
        }
    }
    
    func setStyle(style: SlidingTabStyle){
        tabStyle = style
    }
    
    func build(){
        // view
        view.addSubview(headerView)
        view.addSubview(collectionHeader)
        view.addSubview(lessonsLabel)
        view.addSubview(collectionPage)
        
        configreConstrains()
       
        collectionHeader.delegate = self
        collectionHeader.dataSource = self
        // collectionPage
       
        collectionPage.delegate = self
        collectionPage.dataSource = self
       
        StudentPlanDataManager.fetchStudentPlan { [weak self] result in
            switch result {
            case .success(let StudentPlan):
                self?.semesters = StudentPlan.semesters
                self?.collectionHeader.reloadData()
                self?.collectionPage.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func configreConstrains() {
        
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        // collectionHeader
        collectionHeader.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        collectionHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionHeader.heightAnchor.constraint(equalToConstant: CGFloat(heightHeader)).isActive = true
        
        lessonsLabel.topAnchor.constraint(equalTo: collectionHeader.bottomAnchor, constant: 15).isActive = true
        lessonsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        collectionPage.topAnchor.constraint(equalTo: lessonsLabel.bottomAnchor, constant: 20).isActive = true
        collectionPage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionPage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionPage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}

extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setCurrentPosition(position: indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionPage{
            let currentIndex = Int(self.collectionPage.contentOffset.x / collectionPage.frame.size.width)
            setCurrentPosition(position: currentIndex)
        }
    }
}

extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return semesters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionHeader {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HeaderCollectionViewCell.identifier,
                for: indexPath) as? HeaderCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.text = "Семестр \(semesters[indexPath.row].number)"
            
            var didSelect = false
            
            if currentPosition == indexPath.row {
                didSelect = true
            }
            
            cell.select(didSelect: didSelect, activeColor: colorHeaderActive, inActiveColor: colorHeaderInActive)
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ContentCollectionViewCell.identifier,
            for: indexPath) as? ContentCollectionViewCell else {
            return UICollectionViewCell()
        }

        
        
        let disciplines = semesters[indexPath.row].disciplines
        cell.configure(with: disciplines)
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionHeader {
                    if tabStyle == .fixed {
                        let spacer = CGFloat(semesters.count)
                        let width = view.frame.width / spacer
                        let height = collectionHeader.frame.height - collectionView.contentInset.top - collectionView.contentInset.bottom
                        return CGSize(width: width, height: height)
                    }
                }

                let availableHeight = collectionView.bounds.height - collectionView.contentInset.top - collectionView.contentInset.bottom
                let width = collectionView.bounds.width
                return CGSize(width: width, height: availableHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionHeader {
            return 10
        }
        
        return 0
    }
}

enum SlidingTabStyle: String {
    case fixed
    case flexible
}
