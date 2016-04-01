//
//  TVShow.swift
//  showz
//
//  Created by Jorge Luis Perales on 31/03/16.
//  Copyright © 2016 Jorge Luis Perales. All rights reserved.
//

import Foundation

class TVShow {
    private var _name: String!
    private var _showId: String!
    private var _imgName: String!
    
    var name: String {
        return _name
    }
    
    var showId: String {
        return _showId
    }
    
    var imgName: String {
        return _imgName
    }
    
    init(name: String, id: String, imgName: String) {
        _name = name
        _showId = id
        _imgName = imgName
    }
}