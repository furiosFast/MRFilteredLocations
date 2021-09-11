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


import UIKit
import SwifterSwift
import SQLite

@objc public protocol MRFilteredLocationsDelegate: NSObjectProtocol {
    func didSelectRowAt(tableView: UITableView, indexPath: IndexPath, filteredLocation: [Location])
    @objc optional func swipeDownDismiss()
}

class MRFilteredLocations: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    open weak var delegate : MRFilteredLocationsDelegate?

    private var filteredLocation: [Location] = []
    private var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = loc("searchPage_PLACEHOLDER")
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.cornerRadius = 15
        searchController.searchBar.barTintColor = .link
        searchController.searchBar.backgroundColor = .systemGray6
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.borderColor = .white
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.keyboardType = .alphabet
        searchController.searchBar.autocorrectionType = .yes
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        searchController.searchBar.barTintColor = .link
        tableView.backgroundColor = .systemGray6
    }
    
    
    //MARK:- TableView
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id_table_cell_location", for: indexPath)
        if filteredLocation[indexPath.row].country.count > 0 {
            let text = filteredLocation[indexPath.row].name + ", " + filteredLocation[indexPath.row].country
            let amountText = NSMutableAttributedString.init(string: text)
            amountText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray],
                                     range: NSMakeRange(filteredLocation[indexPath.row].name.count + 2, filteredLocation[indexPath.row].country.count))
            cell.textLabel?.attributedText = amountText
        } else {
            cell.textLabel?.text = filteredLocation[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRowAt(tableView: tableView, indexPath: indexPath, filteredLocation: filteredLocation)
    }
    
    
    //MARK:- SearchView
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        swipeDownDismiss()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            filteredLocation = [Location]()
            tableView.reloadData()
            return
        }
        if searchText.isEmpty {
            filteredLocation = [Location]()
            tableView.reloadData()
            return
        }
        DispatchQueue.global().async {
            do {
                self.filteredLocation = try LocationDao.findFirstTwentyLikeByName(name: searchText)
            } catch {
                debugPrint("ERROR: in fase di riperimento dei dati dal dao")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    //MARK:- Private functions
    
    private func swipeDownDismiss(completion: (() -> Void)? = nil){
        delegate?.swipeDownDismiss?()
    }

}