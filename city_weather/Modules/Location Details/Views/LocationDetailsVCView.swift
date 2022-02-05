//
//  LocationDetailsVCView.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/2/22.
//

import Foundation
import UIKit

class LocationDetailsVCView: UIView{
    
//    let tableView: UITableView = {
//        let table = UITableView()
//        table.separatorColor = .clear
//        table.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
//        table.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
//        table.backgroundColor = .white
//        return table
//    }()
//
    let collectionView: UICollectionView
    
    override init(frame: CGRect){
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView.init(frame: frame, collectionViewLayout: flowLayout)
        super.init(frame: frame)
        backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        collectionView.register(ForecastDayCollectionViewCell.self, forCellWithReuseIdentifier: ForecastDayCollectionViewCell.reuseIdentifier)
//        setupViews()
    }
    
//    func setupViews(){
//        mainViewcollectionView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(tableView)
//        
//        
//        mainView.collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        mainView.collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        mainView.collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        
//        mainView.collectionView.register(ForecastDayCollectionViewCell.self, forCellReuseIdentifier: ForecastDayCollectionViewCell.reuseIdentifier)
//        
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
