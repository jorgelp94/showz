//
//  Constants.swift
//  showz
//
//  Created by Jorge Luis Perales on 07/04/16.
//  Copyright © 2016 Jorge Luis Perales. All rights reserved.
//

import Foundation

// HTTP
let URL_BASE = "http://api.themoviedb.org/3"
let URL_TVSHOW = "/tv/" // requires an id after the second / then API_KEY
let URL_AIRTODAY = "/tv/airing_today" // + API_KEY
let URL_POPULAR = "/tv/popular" // + API_KEY
let URL_SEASON = "/season/" // needs URL_TVSHOW + showId + seasonNumber + API_KEY
let URL_DISCOVER = "/discover/tv"
let API_KEY = "?api_key=4fac1b17cdad8598c05f708d371e2c45"
let URL_IMG = "http://image.tmdb.org/t/p/original"


typealias DownloadComplete = () -> ()