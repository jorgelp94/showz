//
//  NavigationController.swift
//  showz
//
//  Created by Jorge Luis Perales on 31/03/16.
//  Copyright © 2016 Jorge Luis Perales. All rights reserved.
//

import UIKit
import MediumMenu

class NavigationController: UINavigationController {
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var menu: MediumMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewControllerWithIdentifier("Home") as! ViewController
        setViewControllers([homeViewController], animated: false)

        let item1 = MediumMenuItem(title: "Home") {
            let homeViewController = storyboard.instantiateViewControllerWithIdentifier("Home") as! ViewController
            self.setViewControllers([homeViewController], animated: false)
        }
        
        let item2 = MediumMenuItem(title: "Airing Today") {
            let airingTodayVC = storyboard.instantiateViewControllerWithIdentifier("Today") as! TodayViewController
            self.setViewControllers([airingTodayVC], animated: false)
        }
        
//        let item3 = MediumMenuItem(title: "Bookmarks") {
//            let bookMarksViewController = storyboard.instantiateViewControllerWithIdentifier("Bookmarks") as! BookmarksViewController
//            self.setViewControllers([bookMarksViewController], animated: false)
//        }
//
//        let item4 = MediumMenuItem(title: "Help") {
//            let helpViewController = storyboard.instantiateViewControllerWithIdentifier("Help") as! HelpViewController
//            self.setViewControllers([helpViewController], animated: false)
//        }
//        
//        let item5 = MediumMenuItem(title: "Sign out") {
//            let signoutViewController = storyboard.instantiateViewControllerWithIdentifier("Signout") as! SignoutViewController
//            self.setViewControllers([signoutViewController], animated: false)
//        }

        menu = MediumMenu(items: [item1, item2], forViewController: self)
        menu?.velocityTreshold = 700
        menu?.backgroundColor = UIColor.init(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1)
        menu?.titleAlignment = .Center
        menu?.panGestureEnable = false
    }
    
    func showMenu() {
        menu?.show()
    }
}

extension UINavigationBar {
    public override func sizeThatFits(size: CGSize) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 60)
    }
}
