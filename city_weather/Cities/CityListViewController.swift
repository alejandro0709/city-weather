//
//  ViewController.swift
//  city_weather
//
//  Created by Alejandro Guerra, 1/31/22.
//

import UIKit
import Swinject
import MBProgressHUD

protocol CitiesDisplayerProtocol{
    func loadCities(cityList: [CityTableViewCellViewModel])
    func networkState(state: NetworkState)
}

class CityListViewController: BaseViewController {

    private let router: NavigationControllerRouterProtocol? = Container.sharedContainer.resolve(NavigationControllerRouterProtocol.self)!
    private let interactor: CitiesInteractorProtocol = Container.sharedContainer.resolve(CitiesInteractorProtocol.self)!
    private var mainView: CitiesVCView!
    private var cityList: [CityTableViewCellViewModel] = []
    
    fileprivate func setupViews() {
        mainView = CitiesVCView.init(frame: view.frame)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        
        mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mainView.setupViews()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Cities"
        
        let presenter = Container.sharedContainer.resolve(CitiesPresenterProtocol.self)!
        presenter.setupDisplayer(viewController: self)
        
        setupViews()
        interactor.requestCities()
    }

}

extension CityListViewController: CitiesDisplayerProtocol{
    func loadCities(cityList: [CityTableViewCellViewModel]){
        self.cityList = cityList
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

extension CityListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier, for: indexPath) as! CityTableViewCell
        cell.setup(model: cityList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.navigateToCity(woeid: cityList[indexPath.row].woeid)
    }
    
}

