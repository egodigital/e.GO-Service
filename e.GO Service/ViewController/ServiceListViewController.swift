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
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        let button = UIButton()
        button.setTitle("Wanna see some cool stuff?", for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pressedButton(_:)), for: .touchUpInside)
        view.layoutIfNeeded()
        self.tableView.tableHeaderView = view
        
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
            self.presentError(error, completionHandler: nil)
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
        return statusList == nil ? 0 : ServiceTypeCell.CellType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell") as? ServiceTypeCell else { return UITableViewCell() }
        cell.vehicleSignalList = statusList
        
        switch indexPath.row {
        case 0:
            cell.type = .batteryCharge
        case 1:
            cell.type = .tire
        case 2:
            cell.type = .brake
        case 3:
            cell.type = .wipingWater
        case 4:
            cell.type = .motorControlLamp
        case 5:
            cell.type = .batteryHealth
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    @objc func pressedButton(_ button: UIButton) {
        let map = MapViewController()
        self.navigationController?.pushViewController(map, animated: true)
    }
}
