//
//  TVShow.swift
//  showz
//
//  Created by Jorge Luis Perales on 31/03/16.
//  Copyright © 2016 Jorge Luis Perales. All rights reserved.
//

import Foundation
import Alamofire

class TVShow {
    private var _name: String!
    private var _showId: String!
    private var _imgUrl: String!
    private var _description: String!
    private var _rating: String!
    private var _genres: String!
    private var _airdate: String!
    private var _status: String!
    private var _createdBy: String!
    private var _networks: String!
    private var _showURL: String!
    
    var name: String {
        return _name
    }
    
    var showId: String {
        return _showId
    }
    
    var imgUrl: String {
        return _imgUrl
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var rating: String {
        if _rating == nil {
            _rating = ""
        }
        return _rating
    }
    
    var genres: String {
        if _genres == nil {
            _genres = ""
        }
        return _genres
    }
    
    var airdate: String{
        if _airdate == nil {
            _airdate = ""
        }
        return _airdate
    }
    
    var status: String {
        if _status == nil {
            _status = ""
        }
        return _status
    }
    
    var createdBy: String {
        if _createdBy == nil {
            _createdBy = ""
        }
        return _createdBy
    }
    
    var networks: String {
        
        if _networks == nil {
            _networks = ""
        }
        return _networks
    }
    
    
    init(name: String, id: String, imgUrl: String) {
        _name = name
        _showId = id
        _imgUrl = "\(URL_IMG)\(imgUrl)"
        
        _showURL = "\(URL_BASE)\(URL_TVSHOW)\(_showId)\(API_KEY)"
    }
    
    func downloadTvShowDetails(completed: DownloadComplete) {
        let url = NSURL(string: _showURL)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
        
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                print(dict)
                
                if let rating = dict["vote_average"] as? Double{
                    self._rating =  "\(rating)"
                }
                
                if let status = dict["status"] as? String {
                    self._status = status
                }
                
                if let overview = dict["overview"] as? String {
                    self._description = overview
                }
                
                if let airDate = dict["first_air_date"] as? String {
                    self._airdate = airDate
                }
                
                print(self._airdate)
                print(self._description)
                print(self._rating)
                print(self._status)
                
                if let genres = dict["genres"] as? [Dictionary<String, AnyObject>] where genres.count > 0{
                    var fullGenres: String =  ""
                    for element in genres {
                        if let genero = element["name"] as? String {
                            fullGenres.appendContentsOf("\(genero),")
                        }
                    }
                    if fullGenres != "" {
                        self._genres = fullGenres
                    }
                } else {
                    self._genres = ""
                }
                print(self._genres)
                
                if let networks = dict["networks"] as? [Dictionary<String, AnyObject>] where networks.count > 0{
                    var fullNetworks: String =  ""
                    for element in networks {
                        if let network = element["name"] as? String {
                            fullNetworks.appendContentsOf("\(network),")
                        }
                    }
                    if fullNetworks != "" {
                        self._networks = fullNetworks
                    }
                }
                print(self._networks)
                
                if let creators = dict["created_by"] as? [Dictionary<String, AnyObject>] where creators.count > 0{
                    var fullCreators: String =  ""
                    for element in creators {
                        if let creator = element["name"] as? String {
                            fullCreators.appendContentsOf("\(creator),")
                        }
                    }
                    if fullCreators != "" {
                        self._createdBy = fullCreators
                    }
                }
                print(self._createdBy)
                
                if let poster = dict["poster_path"] as? String {
                    let fullPath = "\(URL_IMG)\(poster)"
                    print(fullPath)
                    self._imgUrl = fullPath
                }
                
            }
            completed()
        }
    }
}