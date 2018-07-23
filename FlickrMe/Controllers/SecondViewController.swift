//
//  SecondViewController.swift
//  FlickrMe
//
//  Created by Sierra on 7/22/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit
import Kingfisher

class SecondViewController: UIViewController {

    var user_ID:String!
    @IBOutlet weak var TableView: UITableView!   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        GettinData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Related Images"
    }
    
    // getting a specified data from API for a specified user
    func GettinData(){
        ImageService.getData(searchTerm: "", user_id: user_ID!) { (returnedArray) in
            currentArray = returnedArray
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
        }
    }
}

// setting up second tableView for the related user id
extension SecondViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondcell", for: indexPath) as! SecondTableViewCell
        cell.Title.text = currentArray[indexPath.row].title
        let url = URL(string: (currentArray[indexPath.row].image))!
        cell.ImageView.kf.indicatorType = .activity
        cell.ImageView.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
