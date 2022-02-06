//
//  SearchLocationViewController.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 2/6/22.
//

import Foundation
import Swinject

protocol SearchLocationDisplayerProtocol: LocationsDisplayerProtocol{
    func locationSaved()
}

class SearchLocationViewController: BaseViewController{
    private let router: NavigationControllerRouterProtocol? = Container.sharedContainer.resolve(NavigationControllerRouterProtocol.self)!
    private let interactor: SearchLocationInteractorProtocol = Container.sharedContainer.resolve(SearchLocationInteractorProtocol.self)!
    private var mainView: SearchLocationVCView!
    private var cityList: [LocationTableViewCellViewModel] = []
    private var locationAddedClosure: (() -> ())?
    private var timer: Timer?
    
    convenience init(locationAddedClosure: (() -> ())?) {
        self.init()
        self.locationAddedClosure = locationAddedClosure
        
        let presenter = Container.sharedContainer.resolve(SearchLocationPresenterProtocol.self)!
        presenter.setupDisplayer(viewController: self)
    }
    
    fileprivate func setupViews() {
        mainView = SearchLocationVCView.init(frame: view.frame)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        
        mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add location"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(navigateBack))
        
        setupViews()
        mainView.searchBar.becomeFirstResponder()
    }
    
    @objc func navigateBack(){
        router?.navigateBack()
    }
}

extension SearchLocationViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(onTimerFires(timer:)), userInfo: ["searchQuery": searchText], repeats: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        timer?.invalidate()
        timer = nil
        searchBar.endEditing(true)
        if searchBar.text?.isEmpty ?? true {
            return
        }
        searchBar.text = ""
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(300) ){[weak self] in
            self?.interactor.searchLocation(query: "")
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.mainView.searchBar.setShowsCancelButton(true, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.mainView.searchBar.setShowsCancelButton(false, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.mainView.searchBar.resignFirstResponder()
    }
    
    @objc func onTimerFires(timer: Timer){
        guard let userInfo = timer.userInfo as? [String: String] else { return }
        guard let query = userInfo["searchQuery"], !query.isEmpty else { return }
        interactor.searchLocation(query: query.lowercased())
    }
    
}

extension SearchLocationViewController: UITableViewDelegate, UITableViewDataSource{
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
        interactor.addLocation(woeid: cityList[indexPath.row].woeid, title: cityList[indexPath.row].name)
    }
    
}

extension SearchLocationViewController: SearchLocationDisplayerProtocol{
    func loadLocations(locationList: [LocationTableViewCellViewModel]){
        self.cityList = locationList
        DispatchQueue.main.async {[weak self] in
            self?.mainView.tableView.reloadData()
        }
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
    
    func locationSaved() {
        mainView.searchBar.endEditing(true)
        locationAddedClosure?()
        router?.navigateBack()
    }
    
}
