//
//  CityDetailsViewControler.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 2/2/22.
//

import Foundation
import Swinject
import MBProgressHUD

protocol LocationDetailsDisplayer{
    func networkState(state: NetworkState)
    func errorDetected(error: Error, retryAction: (() -> ())?)
    
}

class LocationDetailsViewController: BaseViewController{
    private let router: NavigationControllerRouterProtocol = Container.sharedContainer.resolve(NavigationControllerRouterProtocol.self)!
    private let interactor: LocationDetailsInteractorProtocol = Container.sharedContainer.resolve(LocationDetailsInteractorProtocol.self)!
    private var arg: LocationDetailsArg!
    private var mainView: LocationDetailsVCView!
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = arg.cityName
        setupViews()
        interactor.requestLocationData(woeid: arg.woeid)
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
    
}

struct LocationDetailsArg{
    let cityName: String
    let woeid: Int
    
    init(model: LocationTableViewCellViewModel){
        cityName = model.name
        woeid = model.woeid
    }
}
