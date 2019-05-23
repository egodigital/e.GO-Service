//
//  MapCell.swift
//  e.GO Service
//
//  Created by Jonas Schlabertz on 23.05.19.
//  Copyright © 2019 Jonas Schlabertz. All rights reserved.
//

import UIKit
import SnapKit

class MapCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let image = UIImageView(image: UIImage(named: "ego"))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.text = "Explore our e.GO Service Points"
        title.textColor = .white
        
        self.contentView.addSubview(image)
        self.contentView.addSubview(title)
        
        title.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(10)
        }
        
        image.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(180)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
