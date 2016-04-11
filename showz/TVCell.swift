//
//  TVCell.swift
//  showz
//
//  Created by Jorge Luis Perales on 31/03/16.
//  Copyright © 2016 Jorge Luis Perales. All rights reserved.
//

import UIKit
import AlamofireImage

class TVCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var tvshow : TVShow!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 2.0
    }
    
    func configureCell(show: TVShow) {
        tvshow = show
        
        nameLbl.text = tvshow.name.capitalizedString
        print("TVCELL URL: \(show.imgUrl)")
        let URL = NSURL(string: show.imgUrl)!
        thumbImg.af_setImageWithURL(URL)
    }
}
