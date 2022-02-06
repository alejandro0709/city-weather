//
//  SearchLocationVCView.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 2/6/22.
//

import Foundation
import UIKit

class SearchLocationVCView: UIView{
    
    let tableView: UITableView = {
        let table = UITableView()
        table.separatorColor = .clear
        table.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        table.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        table.backgroundColor = .white
        return table
    }()
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search Location"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(searchBar)
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
