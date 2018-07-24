//
//  ViewController.swift
//  FlickrMe
//
//  Created by Sierra on 7/22/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//


import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    
    // setting the title for navigation controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "FlickrMe"
        #if FlickrMe
            // Old Target
            navigationController?.navigationBar.barTintColor = UIColor.darkGray
        #else
            // New Target
            navigationController?.navigationBar.barTintColor = UIColor.black
        #endif
    }
    
    // reload tableview and changing colors of it depending on the target
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.reloadData()
        ImageService.getData(begin: true, searchTerm: "", user_id: "") { (returnedArray) in
            currentArray=returnedArray
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
        }
        #if FlickrMe
            // Old Target
            TableView.backgroundColor = UIColor.darkGray
        #else
            // New Target
             TableView.backgroundColor = UIColor.black
        #endif
    }
}


// setting up our first table view
extension ViewController:UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.Title.text = currentArray[indexPath.row].title
        let url = URL(string: (currentArray[indexPath.row].image))!
        cell.ImageView.kf.indicatorType = .activity
        cell.ImageView.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user_id = currentArray[indexPath.row].owner
        performSegue(withIdentifier: "next", sender: user_id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"
        {
            let nextViewController = segue.destination as! SecondViewController
            nextViewController.user_ID = sender as! String
        }
    }
    // search delegate method ,, 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        currentArray.removeAll()
        ImageService.getData(searchTerm: searchBar.text!) { (returnedArray) in
            currentArray = returnedArray 
                        DispatchQueue.main.async {
                            self.TableView.reloadData()
                        }
                    }
                }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            ImageService.getData(begin: true, searchTerm: searchText, completionHandler: { (returnedArray) in
                currentArray = returnedArray
            })
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }

        }
    }
}
