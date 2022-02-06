//
//  LocationDetailsVCView.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/2/22.
//

import Foundation
import UIKit

class ForecastListView: UIView{
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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
