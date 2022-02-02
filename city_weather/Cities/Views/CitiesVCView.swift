//
//  CitiesVCView.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 2/1/22.
//

import Foundation
import UIKit

class CitiesVCView: UIView{
    
    let tableView: UITableView = {
        let table = UITableView()
        table.separatorColor = .clear
        table.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        table.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        return table
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .systemPurple
    }
    
    func setupViews(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
