//
//  ImageService.swift
//  FlickrMe
//
//  Created by Sierra on 7/23/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit

class ImageService{
    
    // getting the data from API & putting it in an array
    
    static func getData(begin:Bool=false,searchTerm:String,user_id:String = "",completionHandler: @escaping (_ array:[Cell]) -> ()){
        var endpoint = ""
        if begin != false {
            endpoint = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(apiKey)&format=json&nojsoncallback=1"
        }else {
        if user_id != "" {
            endpoint = "https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=\(apiKey)&user_id=\(user_id)&format=json&nojsoncallback=1"
        }else{
             endpoint = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(searchTerm)&per_page=40&format=json&nojsoncallback=1"
        }
        }
                DispatchQueue.main.async {
                    do{
                        currentArray.removeAll()
                        let url = URL(string: endpoint)
                        guard url != nil else{return}
                            let data = try Data(contentsOf: url!)
                            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                            let photos = json["photos"] as! [String:Any]
                            let photo = photos["photo"] as! [[String:Any]]
                            for one in photo {
                                let title = one["title"] as! String
                                let ImageID = one["id"] as! String
                                let FarmID = one["farm"] as! Int
                                let ServerID = one["server"] as! String
                                let SecretID = one["secret"] as! String
                                let UserID = one["owner"] as! String
                                let Image = "https://farm\(FarmID).staticflickr.com/\(ServerID)/\(ImageID)_\(SecretID).jpg"
                                let obj = Cell(title: title, image: Image , owner:UserID)
                                currentArray.append(obj)
                            }
                            completionHandler(currentArray)
                        }catch{
                            print(error.localizedDescription)
                        }
                }
    }
}
