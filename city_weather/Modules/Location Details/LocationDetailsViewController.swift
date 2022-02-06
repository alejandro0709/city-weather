//
//  LocationDetailsViewController.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/2/22.
//

import Foundation
import Swinject
import MBProgressHUD

class LocationDetailsViewController: BaseDayForecastViewController{
    private let interactor: LocationDetailsInteractorProtocol = Container.sharedContainer.resolve(LocationDetailsInteractorProtocol.self)!
    private var arg: LocationDetailsArg!
    
    convenience init(arg: LocationDetailsArg) {
        self.init()
        self.arg = arg
        let presenter = Container.sharedContainer.resolve(LocationDetailsPresenterProtocol.self)!
        presenter.setupDisplayer(viewcontroller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = arg.cityName
        interactor.requestLocationData(woeid: arg.woeid)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.navigateToDay(aplicableDate: foreCastModelList[indexPath.row].applicableDate, locationName: arg.cityName, woeid: arg.woeid, cwId: foreCastModelList[indexPath.row].id)
    }
    
    override func refreshData() {
        interactor.requestLocationData(woeid: arg.woeid)
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
