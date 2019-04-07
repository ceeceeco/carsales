//
//  CarDetailsViewController.swift
//  carsales
//
//  Created by Charisse Co on 7/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import UIKit

class CarDetailsViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet private var mainImageView: UIImageView!
    @IBOutlet private var photosStackView: UIStackView!
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
            
            self.setupPhotosStackView()
        }
    }
    
    private func setupPhotosStackView() {
        for _ in 1..<self.viewModel.numberOfImages {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            self.photosStackView.addArrangedSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalTo: self.mainImageView.heightAnchor),
                imageView.widthAnchor.constraint(equalTo: self.mainImageView.widthAnchor)])
            self.updateImage(index: 0)
        }
    }
    
    private func updateImage(index: Int) {
        viewModel.retrieveImage(index: index) { [weak self] image in
            DispatchQueue.main.async {
                guard let imageView = self?.photosStackView?.arrangedSubviews[index] as? UIImageView else { return }
                imageView.image = image
            }
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        guard let imageView = photosStackView.arrangedSubviews[pageIndex] as? UIImageView else { return }
        if imageView.image == nil {
            updateImage(index: pageIndex)
        }
    }
}
