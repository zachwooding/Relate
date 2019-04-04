//
//  SearchViewController.swift
//  RPM-AR-UI
//
//  Created by Zachary Wooding on 4/4/19.
//  Copyright © 2019 Zachary Wooding. All rights reserved.
//

import UIKit
import SceneKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    var objs = [Objs]()
    var filteredObjs = [Objs]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchFooter: SearchFooter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        objs = [
            Objs(category:"Chocolate", name:"Chocolate Bar", sceneName:"ship.scn"),
            Objs(category:"Chocolate", name:"Chocolate Chip", sceneName:"ship.scn"),
            Objs(category:"Other", name:"Gummi Bear", sceneName:"ship.scn"),
            Objs(category:"Other", name:"Candy Floss", sceneName:"ship.scn"),
            Objs(category:"Chocolate", name:"Chocolate Coin", sceneName:"ship.scn"),
            Objs(category:"Chocolate", name:"Chocolate Egg", sceneName:"ship.scn"),
            Objs(category:"Other", name:"Jelly Beans", sceneName:"ship.scn"),
            Objs(category:"Other", name:"Liquorice", sceneName:"ship.scn"),
            Objs(category:"Hard", name:"Toffee Apple", sceneName:"ship.scn")
        ]
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Objects"
        navigationItem.searchController = searchController
        definesPresentationContext = true


        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredObjs = objs.filter({( objs : Objs) -> Bool in
            return objs.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }


    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredObjs.count
        }
        
        return objs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let obj: Objs
        if isFiltering() {
            obj = filteredObjs[indexPath.row]
        } else {
            obj = objs[indexPath.row]
        }
        cell.textLabel!.text = obj.name
        cell.detailTextLabel!.text = obj.category
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let obj: Objs
                if isFiltering() {
                    obj = filteredObjs[indexPath.row]
                } else {
                    obj = objs[indexPath.row]
                }

                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailObjs = obj
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)

    }
}

