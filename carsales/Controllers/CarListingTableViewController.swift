//
//  CarListingTableViewController.swift
//  carsales
//
//  Created by Charisse Co on 7/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import UIKit

class CarListingTableViewController: UITableViewController {
    
    private enum Constants {
        static let identifier = "carListing"
    }
    
    private var viewModel: CarListingTableViewModel
    
    init(style: UITableView.Style = .plain, viewModel: CarListingTableViewModel) {
        self.viewModel = viewModel
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CarListingTableViewController"
        setupTableView()
        viewModel.retrieveListing { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "CarListingTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorInset = .zero
        
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath) as? CarListingTableViewCell else { return UITableViewCell() }
        if let textContents = viewModel.textContent(for: indexPath) {
            cell.setTextContent(title: textContents.title, price: textContents.price, location: textContents.location)
        }
        let id = viewModel.id(for: indexPath)
        cell.id = id
        cell.previewImage = nil
        viewModel.retrieveImage(for: indexPath) { [weak self] image in
            self?.updateImage(in: tableView, for: indexPath, currentId: id, image: image)
        }
        return cell
    }
    
    private func updateImage(in tableView: UITableView, for indexPath: IndexPath, currentId: String?, image: UIImage?) {
        DispatchQueue.main.async {
            guard
                let cell = tableView.cellForRow(at: indexPath) as? CarListingTableViewCell,
                cell.id == currentId // Possible that cell may have already been reused before image finished downloading.
            else { return }
            cell.previewImage = image
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(indexPath: indexPath)
    }
}
