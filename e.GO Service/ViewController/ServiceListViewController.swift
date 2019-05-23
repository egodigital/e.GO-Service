//
//  ServiceListViewController.swift
//  e.GO Service
//
//  Created by Jonas Schlabertz on 23.05.19.
//  Copyright © 2019 Jonas Schlabertz. All rights reserved.
//

import UIKit

class ServiceListViewController: UITableViewController {
    
    private let refreshController = UIRefreshControl()
    
    var api: API!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshController.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        self.update()
    }
    
    @objc func refresh(_ sender: Any) {
        self.update()
    }
    
    func update() {
        
    }
    
    func presentData(data: VehicleSignalList) {
        
    }
    
}
