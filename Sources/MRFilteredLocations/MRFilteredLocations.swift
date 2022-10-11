//
//  MRFilteredLocations.swift
//  MRFilteredLocations
//
//  Created by Marco Ricca on 11/09/2021
//
//  Created for MRFilteredLocations in 11/09/2021
//  Using Swift 5.4
//  Running on macOS 11.5.2
//
//  Copyright © 2021 Fast-Devs Project. All rights reserved.
//

import SQLite
import UIKit

@objc public protocol MRFilteredLocationsDelegate: NSObjectProtocol {
    func didSelect(filteredLocation: Location)
    @objc optional func swipeDownDismiss(controller: MRFilteredLocations)
}

open class MRFilteredLocations: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    open weak var delegate: MRFilteredLocationsDelegate?

    private var filteredLocations: [Location] = []
    private var searchController: UISearchController!

    override open func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id_table_cell_location")
        tableView.backgroundColor = UIColor(named: "Table View Backgound Custom Color")

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = loc("searchPage_PLACEHOLDER")
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.layer.cornerRadius = 15
        searchController.searchBar.barTintColor = .link
        searchController.searchBar.backgroundColor = .systemGray6
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.layer.borderColor = UIColor.white.cgColor
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.keyboardType = .alphabet
        searchController.searchBar.autocorrectionType = .yes

        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }

    override open func traitCollectionDidChange(_: UITraitCollection?) {
        searchController.searchBar.barTintColor = .link
        tableView.backgroundColor = .systemGray6
    }

    // MARK: - TableView

    override open func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    override open func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override open func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return filteredLocations.count
    }

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id_table_cell_location", for: indexPath)
        cell.backgroundColor = colorFromBundle(named: "Table View Cell Backgound Custom Color")
        if filteredLocations[indexPath.row].country.count > 0 {
            let text = filteredLocations[indexPath.row].name + ", " + filteredLocations[indexPath.row].country
            let amountText = NSMutableAttributedString(string: text)
            amountText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray],
                                     range: NSMakeRange(filteredLocations[indexPath.row].name.count + 2, filteredLocations[indexPath.row].country.count))
            cell.textLabel?.attributedText = amountText
        } else {
            cell.textLabel?.text = filteredLocations[indexPath.row].name
        }
        return cell
    }

    override open func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(filteredLocation: filteredLocations[indexPath.row])
        // searchController.isActive = false;
        searchController.searchBar.resignFirstResponder()
        delegate?.swipeDownDismiss?(controller: self)
    }

    // MARK: - SearchView

    open func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        swipeDownDismiss()
    }

    open func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            filteredLocations = [Location]()
            tableView.reloadData()
            return
        }
        if searchText.isEmpty {
            filteredLocations = [Location]()
            tableView.reloadData()
            return
        }
        DispatchQueue.global().async {
            do {
                self.filteredLocations = try LocationDao.findFirstTwentyLikeByName(name: searchText)
            } catch {
                debugPrint("ERROR: in fetch data from dao")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Private functions

    private func swipeDownDismiss(completion _: (() -> Void)? = nil) {
        delegate?.swipeDownDismiss?(controller: self)
    }
}
