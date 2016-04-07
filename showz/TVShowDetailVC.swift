//
//  TVShowDetailVC.swift
//  showz
//
//  Created by Jorge Luis Perales on 06/04/16.
//  Copyright © 2016 Jorge Luis Perales. All rights reserved.
//

import UIKit

class TVShowDetailVC: UIViewController {
    
    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet var mainImg: UIImageView!
    
    @IBOutlet var descriptionLbl: UILabel!
    
    @IBOutlet var ratingLbl: UILabel!
    
    @IBOutlet var genreLbl: UILabel!
    
    @IBOutlet var airDateLbl: UILabel!
    
    @IBOutlet var statusLbl: UILabel!
    
    @IBOutlet var createdLbl: UILabel!
    
    @IBOutlet var networksLbl: UILabel!
    
    var show: TVShow!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = show.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
