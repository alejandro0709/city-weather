//
//  LocationDayViewController.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation
import UIKit
import Swinject

class LocationDayViewController: BaseViewController{
    private var mainView: LocationDayVCView!
    private let router: NavigationControllerRouterProtocol = Container.sharedContainer.resolve(NavigationControllerRouterProtocol.self)!
    
    private var arg: LocationDayVCArg!
    private var foreCastModelList: [ForecastDayCollectionViewCellViewModel] = []
    
    convenience init(arg: LocationDayVCArg) {
        self.init()
        self.arg = arg
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(arg.locationName) - \(arg.applicableDate.prettyDate())"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(navigateBack))
        
        setupViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotationDetected), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func navigateBack(){
        router.navigateBack()
    }
    
    @objc func rotationDetected(){
        if foreCastModelList.isEmpty { return }
        DispatchQueue.main.async {[weak self] in
            self?.mainView.collectionView.reloadData()
        }
    }
    
    fileprivate func setupViews() {
        mainView = LocationDayVCView.init(frame: view.frame)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        
        mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}

struct LocationDayVCArg{
    let locationName: String
    let applicableDate: Date
    let woeid: Int
}

extension LocationDayViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foreCastModelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastDayCollectionViewCell.reuseIdentifier, for: indexPath) as! ForecastDayCollectionViewCell
        cell.setup(model: foreCastModelList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 4, height: CGFloat(188))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
    }
    
}
