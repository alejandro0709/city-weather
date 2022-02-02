//
//  LocationsListViewController.swift
//  city_weather
//
//  Created by Alejandro Guerra, 1/31/22.
//

import UIKit
import Swinject
import MBProgressHUD

protocol LocationsDisplayerProtocol{
    func loadLocations(locationList: [LocationTableViewCellViewModel])
    func networkState(state: NetworkState)
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
        
        setupViews()
        interactor.requestCities()
    }

}

extension LocationsListViewController: LocationsDisplayerProtocol{
    func loadLocations(locationList: [LocationTableViewCellViewModel]){
        self.cityList = locationList
        mainView.tableView.reloadData()
    }
    
    func networkState(state: NetworkState){
        if state == .loading{
            MBProgressHUD.showAdded(to: view, animated: true)
            return
        }
        
        MBProgressHUD.hide(for: view, animated: true)
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

