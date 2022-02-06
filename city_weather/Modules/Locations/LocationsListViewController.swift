//
//  LocationsListViewController.swift
//  city_weather
//
//  Created by Alejandro Guerra, 1/31/22.
//

import UIKit
import Swinject
import CoreData

protocol LocationsDisplayerProtocol{
    func loadLocations(locationList: [LocationTableViewCellViewModel])
    func networkState(state: NetworkState)
    func errorDetected(error: Error, retryAction: (() -> ())?)
}

class LocationsListViewController: BaseViewController {

    private let router: NavigationControllerRouterProtocol? = Container.sharedContainer.resolve(NavigationControllerRouterProtocol.self)!
    private let interactor: LocationsInteractorProtocol = Container.sharedContainer.resolve(LocationsInteractorProtocol.self)!
    private var mainView: LocationsVCView!
    private var cityList: [LocationTableViewCellViewModel] = []
    
    fileprivate func setupViews() {
        mainView = LocationsVCView.init(frame: view.frame)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        
        mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Locations"
        
        let presenter = Container.sharedContainer.resolve(LocationsPresenterProtocol.self)!
        presenter.setupDisplayer(viewController: self)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add", style: .plain, target: self, action: #selector(navigatetToSearchUser))
        
        setupViews()
        interactor.requestCities()
    }
    
    @objc func navigatetToSearchUser(){
        router?.navigateToSearchLocation(locationAddedClosure: {[weak self] in
            self?.interactor.requestCities()
        })
    }

}

extension LocationsListViewController: LocationsDisplayerProtocol{
    func loadLocations(locationList: [LocationTableViewCellViewModel]){
        self.cityList = locationList
        mainView.tableView.reloadData()
    }
    
    func networkState(state: NetworkState){
        DispatchQueue.main.async {[weak self] in
            if state == .loading{
                self?.mainView.tableView.refreshControl?.beginRefreshing()
                return
            }
            
            self?.mainView.tableView.refreshControl?.endRefreshing()
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
    
}

extension LocationsListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as! LocationTableViewCell
        cell.setup(model: cityList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.navigateToLocation(arg: LocationDetailsArg.init(model: cityList[indexPath.row]))
    }
    
}

