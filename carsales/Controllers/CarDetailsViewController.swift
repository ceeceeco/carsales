//
//  CarDetailsViewController.swift
//  carsales
//
//  Created by Charisse Co on 7/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import UIKit

class CarDetailsViewController: UIViewController {
    
    @IBOutlet private var previewImageView: UIImageView!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var saleStatusLabel: UILabel!
    @IBOutlet private var commentsLabel: UILabel!
    
    private var viewModel: CarDetailsViewModel
    
    init(viewModel: CarDetailsViewModel, nibName nibNameOrNil: String? = "CarDetailsViewController", bundle nibBundleOrNil: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
    }
    
    private func setupContent() {
        viewModel.retrieveDetails { [weak self] in
            guard let this = self else { return }
            this.updateContent()
        }
    }
    
    private func updateContent() {
        DispatchQueue.main.async {
            self.locationLabel.text = self.viewModel.locationText
            self.priceLabel.text = self.viewModel.priceText
            self.saleStatusLabel.text = self.viewModel.saleStatusText
            self.commentsLabel.text = self.viewModel.commentsText
            self.setImage()
        }
    }
    
    private func setImage() {
        viewModel.retrieveImage { [weak self] image in
            DispatchQueue.main.async {
                self?.previewImageView.image = image
            }
        }
    }
}
