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
            Objs(category:"Vehicle", name:"Ship", sceneName:"ship.scn", id:"ship", icon:"\u{1F6F3}"),
            Objs(category:"Vehicle", name:"Car", sceneName:"car.scn", id:"car", icon:"\u{1F698}"),
            Objs(category:"Other", name:"MusicNote", sceneName:"ship.scn", id:"musicnote", icon:"\u{1F3B6}"),
            Objs(category:"Other", name:"Mountain", sceneName:"ship.scn", id:"mountain", icon:"\u{26F0}"),
            Objs(category:"Chocolate", name:"Laptop", sceneName:"ship.scn", id:"laptop", icon:"\u{1F4BB}"),
            Objs(category:"Chocolate", name:"MovieCamera", sceneName:"ship.scn", id:"moviecamera", icon:"\u{1F3A5}"),
            Objs(category:"Other", name:"Rabbit", sceneName:"ship.scn", id:"rabbit", icon:"\u{1F407}"),
            Objs(category:"Other", name:"Rocket", sceneName:"ship.scn", id:"rocket", icon:"\u{1F680}"),
            Objs(category:"Hard", name:"Toffee Apple", sceneName:"ship.scn", id:"ship", icon:"\u{1F6F3}")
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

