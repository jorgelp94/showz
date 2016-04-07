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
    var show: TVShow!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = show.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
