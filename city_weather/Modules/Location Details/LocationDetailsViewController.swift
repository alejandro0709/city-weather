//
//  LocationDetailsViewController.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/2/22.
//

import Foundation
import Swinject
import MBProgressHUD

protocol LocationDetailsDisplayer{
    func networkState(state: NetworkState)
    func errorDetected(error: Error, retryAction: (() -> ())?)
    func loadForecast(itemList: [ForecastDayCollectionViewCellViewModel])
}

class LocationDetailsViewController: BaseViewController{
    private let router: NavigationControllerRouterProtocol = Container.sharedContainer.resolve(NavigationControllerRouterProtocol.self)!
    private let interactor: LocationDetailsInteractorProtocol = Container.sharedContainer.resolve(LocationDetailsInteractorProtocol.self)!
    private var arg: LocationDetailsArg!
    private var mainView: LocationDetailsVCView!
    private var foreCastModelList: [ForecastDayCollectionViewCellViewModel] = []
    
    convenience init(arg: LocationDetailsArg) {
        self.init()
        self.arg = arg
        let presenter = Container.sharedContainer.resolve(LocationDetailsPresenterProtocol.self)!
        presenter.setupDisplayer(viewcontroller: self)
    }
    
    fileprivate func setupViews() {
        mainView = LocationDetailsVCView.init(frame: view.frame)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        
        mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = arg.cityName
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(navigateBack))
        
        setupViews()
        interactor.requestLocationData(woeid: arg.woeid)
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

}

extension LocationDetailsViewController: LocationDetailsDisplayer{
    func networkState(state: NetworkState){
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            
            if state == .loading{
                MBProgressHUD.showAdded(to: self.view, animated: true)
                return
            }
            
            MBProgressHUD.hide(for: self.view, animated: true)
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
                case .badRequest: displayRetry = false
                case .failed: displayRetry = true
                case .outdated: displayRetry = false
                }
            }
        }
        
        showErrorAlert(errorMessage: errorMessage, displayRetry: displayRetry, retryAction: retryAction)
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

struct LocationDetailsArg{
    let cityName: String
    let woeid: Int
    
    init(model: LocationTableViewCellViewModel){
        cityName = model.name
        woeid = model.woeid
    }
}

extension LocationDetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.navigateToDay(aplicableDate: foreCastModelList[indexPath.row].applicableDate, locationName: arg.cityName, woeid: arg.woeid)
    }
    
}
