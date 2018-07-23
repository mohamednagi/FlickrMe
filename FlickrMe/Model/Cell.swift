//
//  Cell.swift
//  FlickrMe
//
//  Created by Sierra on 7/23/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import Foundation

class Cell{
    
    let title:String
    let image:String
    let owner:String
    
    init(title:String,image:String,owner:String) {
        self.title=title
        self.image=image
        self.owner=owner
    }
}
