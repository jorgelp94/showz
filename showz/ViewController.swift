//
//  ViewController.swift
//  showz
//
//  Created by Jorge Luis Perales on 31/03/16.
//  Copyright © 2016 Jorge Luis Perales. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import iAd

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var inSearchMode = false
    var filteredTvshow = [TVShow]()
    
    var jsonTopShowList = [TVShow]()
    
    var show: TVShow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        getDiscoverTvShows{ () -> () in
            self.collection.reloadData()
            print("YEAHHHH")
        }
        
        // Display iAd
        self.canDisplayBannerAds = true
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 29.0/255.0, green: 74.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.topItem?.title = "Discover"
        
        let icon = UIBarButtonItem(image: UIImage(named: "menunew"), style: .Plain, target: navigationController, action: #selector(NavigationController.showMenu))
        icon.imageInsets = UIEdgeInsetsMake(-10, 0, 0, 0)
        icon.tintColor = UIColor.blackColor()
        navigationItem.leftBarButtonItem = icon
        

        // Custom iAd
//        let banner = ADBannerView(adType: ADAdType.Banner)
//        banner.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, banner.frame.size.height)
//        self.navigationController?.navigationBar.addSubview(banner)
        
    }
    
    func getDiscoverTvShows(completed: DownloadComplete) {
        let urlString = "http://api.themoviedb.org/3/discover/tv?api_key=4fac1b17cdad8598c05f708d371e2c45"
        
        Alamofire.request(.GET, urlString).responseJSON { response in
            let result = response.result
            print(result.value.debugDescription)
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                    print(results)
                    print(results.count)
                    
                    for result in results {
                        if let name = result["name"] as? String, let id = result["id"] as? Int, let path = result["poster_path"] as? String {
                            let newShow = TVShow(name: name.lowercaseString, id: "\(id)", imgUrl: path);
                            self.jsonTopShowList.append(newShow)
                        }
                    }
                    
                    print(self.jsonTopShowList)
                }
                
            }
            completed()
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TVCell", forIndexPath: indexPath) as? TVCell {
            
            var show: TVShow!
            
            if inSearchMode {
                show = filteredTvshow[indexPath.row]
            } else {
                show = jsonTopShowList[indexPath.row]
            }
            
            cell.configureCell(show)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var show: TVShow!
        
        if inSearchMode {
            show = filteredTvshow[indexPath.row]
        } else {
            show = jsonTopShowList[indexPath.row]
        }
        
        performSegueWithIdentifier("TVShowDetailVC", sender: show)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredTvshow.count
        } else {
            return jsonTopShowList.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(88 , 168)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" || searchBar.text == nil {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredTvshow = jsonTopShowList.filter({$0.name.rangeOfString(lower) != nil}) // closure element
            collection.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TVShowDetailVC" {
            if let detailsVC = segue.destinationViewController as? TVShowDetailVC {
                if let show = sender as? TVShow {
                    detailsVC.show = show
                }
            }
        }
    }

}

