//
//  ServiceListViewController.swift
//  e.GO Service
//
//  Created by Jonas Schlabertz on 23.05.19.
//  Copyright © 2019 Jonas Schlabertz. All rights reserved.
//

import UIKit
import STIErrorHandling

class ServiceListViewController: UITableViewController {
    
    
    var api: API!
    
    var statusList: VehicleSignalList? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = true
        
        tableView.register(UINib(nibName: "ServiceTypeCell", bundle: nil), forCellReuseIdentifier: "serviceCell")
        
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
                
        tableView.separatorStyle = .none
        
        DispatchQueue.main.async {
            self.refreshControl!.beginRefreshing()
            self.update()
            let offsetPoint = CGPoint(x: 0, y: -176)
            self.tableView.setContentOffset(offsetPoint, animated: true)
        }
        
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
            self.presentError(error, completionHandler: nil)
        }).finally {
            DispatchQueue.main.async {
                self.refreshControl!.endRefreshing()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList == nil ? 1 : ServiceTypeCell.CellType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return MapCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell") as? ServiceTypeCell else { return UITableViewCell() }
        cell.vehicleSignalList = statusList
        
        switch indexPath.row {
        case 1:
            cell.type = .batteryCharge
        case 2:
            cell.type = .tire
        case 3:
            cell.type = .brake
        case 4:
            cell.type = .wipingWater
        case 5:
            cell.type = .motorControlLamp
        case 6:
            cell.type = .batteryHealth
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let map = MapViewController()
            self.navigationController?.pushViewController(map, animated: true)
            return
        }
        
        let type = (self.tableView(tableView, cellForRowAt: indexPath) as! ServiceTypeCell).type!
        switch type {
        case .tire:
            let vc = UIStoryboard(name: "TireServiceViewController", bundle: nil).instantiateInitialViewController() as! TireServiceViewController
            vc.vehicleSignalList = statusList
            self.navigationController?.pushViewController(vc, animated: true)
        case .batteryCharge:
            let vc = UIStoryboard(name: "BatteryChargeViewController", bundle: nil).instantiateInitialViewController() as! BatteryChargeViewController
            vc.vehicleSignalList = statusList
            self.navigationController?.pushViewController(vc, animated: true)

        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 180 : 130
    }
}
