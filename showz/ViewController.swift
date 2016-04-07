//
//  ViewController.swift
//  showz
//
//  Created by Jorge Luis Perales on 31/03/16.
//  Copyright © 2016 Jorge Luis Perales. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var programas = [TVShow]()
    var inSearchMode = false
    var filteredTvshow = [TVShow]()
    
    var jsonTopShowList = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let show1 = TVShow(name: "arrow", id: "0", imgName: "arrow.jpg")
        let show2 = TVShow(name: "breaking bad", id: "0", imgName: "bb.jpg")
        let show4 = TVShow(name: "greys anatomy", id: "0", imgName: "greys.jpg")
        let show6 = TVShow(name: "arrow", id: "0", imgName: "arrow.jpg")
        let show7 = TVShow(name: "arrow", id: "0", imgName: "arrow.jpg")
        let show8 = TVShow(name: "arrow", id: "0", imgName: "arrow.jpg")
        let show9 = TVShow(name: "arrow", id: "0", imgName: "arrow.jpg")
        let show10 = TVShow(name: "arrow", id: "0", imgName: "arrow.jpg")
        let show11 = TVShow(name: "flash", id: "0", imgName: "flash.jpg")
        programas.append(show1)
        
        programas.append(show11)
        programas.append(show2)
        programas.append(show4)
        programas.append(show6)
        programas.append(show7)
        programas.append(show8)
        programas.append(show9)
        programas.append(show10)
        
        programas.append(show11)
        programas.append(show2)
        programas.append(show4)
        programas.append(show6)
        programas.append(show7)
        programas.append(show8)
        programas.append(show9)
        programas.append(show10)
        
        collection.delegate = self
        collection.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        let urlString = "http://api.themoviedb.org/3/discover/tv?api_key=4fac1b17cdad8598c05f708d371e2c45"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if let responseData = data {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let dict = json as? Dictionary<String, AnyObject> {
                        print("Did we get here: \(dict.debugDescription)")
                        
                        print("Resultados: \(dict["results"])")
                        print("Count: \(dict["results"]?.count)")
                        
                        if let name = dict["results"]?.valueForKey("name") as? String, let id = dict["results"]?.valueForKey("id"), let imagePath = dict["results"]?.valueForKey("poster_path") as? String {
                            
                            let show = TVShow(name: name, id: "\(id)", imgName: imagePath)
                            
                            print(show.name)
                            print(show.showId)
                            print(show.imgName)
                            
                        }
                    }
                    
                    //print(json)
                } catch {
                    print("could not seralize")
                }
                
            }
            }.resume()
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TVCell", forIndexPath: indexPath) as? TVCell {
            
            var show: TVShow!
            
            if inSearchMode {
                show = filteredTvshow[indexPath.row]
            } else {
                show = programas[indexPath.row]
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
            show = programas[indexPath.row]
        }
        
        performSegueWithIdentifier("TVShowDetailVC", sender: show)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredTvshow.count
        } else {
            return programas.count
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
            filteredTvshow = programas.filter({$0.name.rangeOfString(lower) != nil}) // closure element
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

