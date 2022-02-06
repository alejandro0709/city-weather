//
//  BaseDayForecastViewController.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation
import UIKit
import Swinject

protocol LocationForecastDisplayer{
    func networkState(state: NetworkState)
    func errorDetected(error: Error, retryAction: (() -> ())?)
    func loadForecast(itemList: [ForecastDayCollectionViewCellViewModel])
}

class BaseDayForecastViewController: BaseViewController{
    private var mainView: ForecastListView!
    var foreCastModelList: [ForecastDayCollectionViewCellViewModel] = []
    let router: NavigationControllerRouterProtocol = Container.sharedContainer.resolve(NavigationControllerRouterProtocol.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(navigateBack))
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotationDetected), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        mainView = ForecastListView.init(frame: view.frame)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        
        mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        self.mainView.collectionView.refreshControl = refreshControl
        self.mainView.collectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData(){}
    
    @objc func navigateBack(){
        router.navigateBack()
    }
    
    @objc func rotationDetected(){
        if foreCastModelList.isEmpty { return }
        DispatchQueue.main.async {[weak self] in
            self?.mainView.collectionView.reloadData()
        }
    }
}

extension BaseDayForecastViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
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

extension BaseDayForecastViewController: LocationForecastDisplayer{
    func networkState(state: NetworkState){
        DispatchQueue.main.async {[weak self] in
            if state == .loading{
                self?.mainView.collectionView.refreshControl?.beginRefreshing()
                return
            }
            self?.mainView.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    func errorDetected(error: Error, retryAction: (() -> ())?){
        var errorMessage = "Unable to gather requested information."
        var displayRetry = false
        if let tempError = error as? NetworkErrorResponse{
            
            errorMessage = tempError.rawValue
            
            if retryAction != nil {
                switch tempError {
                case .authenticationError: displayRetry = true
                case .failed: displayRetry = true
                default: displayRetry = false
                }
            }
        }
        
        DispatchQueue.main.async {[weak self] in
            self?.showErrorAlert(errorMessage: errorMessage, displayRetry: displayRetry, retryAction: retryAction)
        }
    }
    
    func showErrorAlert(errorMessage: String, displayRetry: Bool ,retryAction: (() -> ())?){
        let alert = UIAlertController.init(title: "An error ocurred", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Dismiss", style: .destructive))
        if let retryAction = retryAction, displayRetry {
            alert.addAction(UIAlertAction.init(title: "Try again", style: .default, handler: { _ in
                retryAction()
            }))
        }
        present(alert, animated: true)
    }
    
    func loadForecast(itemList: [ForecastDayCollectionViewCellViewModel]){
        foreCastModelList = itemList
        DispatchQueue.main.async {[weak self] in
            self?.mainView.collectionView.reloadData()
        }
    }
    
}
