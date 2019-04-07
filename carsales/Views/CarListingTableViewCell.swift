//
//  CarListingTableViewCell.swift
//  carsales
//
//  Created by Charisse Co on 7/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import UIKit

class CarListingTableViewCell: UITableViewCell {
    
    @IBOutlet private var previewImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    
    var id: String?
    
    var previewImage: UIImage? {
        didSet {
            previewImageView?.image = previewImage
        }
    }
    
    var title: String? {
        didSet {
            titleLabel?.text = title
        }
    }
    
    var price: String? {
        didSet {
            priceLabel?.text = price
        }
    }
    
    var location: String? {
        didSet {
            locationLabel?.text = location
        }
    }
    
    func setTextContent(title: String, price: String, location: String) {
        self.title = title
        self.price = price
        self.location = location
    }
}
