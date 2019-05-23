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
    
    var statusList: VehicleSignalList? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ServiceTypeCell", bundle: nil), forCellReuseIdentifier: "serviceCell")
        
        refreshController.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        self.tableView.refreshControl = refreshController
        
        self.tableView.rowHeight = 130
        
        tableView.separatorStyle = .none
        
        DispatchQueue.main.async {
            self.refreshController.beginRefreshing()
        }
        
        self.update()
    }
    
    @objc func refresh(_ sender: Any) {
        self.update()
    }
    
    func update() {
        api.vehicleSignalList().done { (list) in
            self.statusList = list
            self.tableView.separatorStyle = .singleLine
        }.catch({ (error) in
            print(error)
        }).finally {
            DispatchQueue.main.async {
                self.refreshController.endRefreshing()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList == nil ? 0 : 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell") as? ServiceTypeCell else { return UITableViewCell() }
        cell.vehicleSignalList = statusList
        
        switch indexPath.row {
        case 0:
            cell.type = .tire
        case 1:
            cell.type = .brake
        case 2:
            cell.type = .wipingWater
        case 3:
            cell.type = .motorControlLamp
        case 4:
            cell.type = .batteryHealth
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = UIStoryboard(name: "TireServiceViewController", bundle: nil).instantiateInitialViewController() as! TireServiceViewController
            vc.vehicleSignalList = statusList
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
