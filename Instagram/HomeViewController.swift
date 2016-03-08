//
//  HomeViewController.swift
//  Instagram
//
//  Created by Thomas Clifford on 3/6/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var query = PFQuery(className: "Post")
    var dictionary: [PFObject]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
//        tableView.estimatedRowHeight = 100;
        tableView.rowHeight = 350;
        
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                self.dictionary = posts
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dictionary = dictionary {
            return dictionary.count
        }
        else {
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath) as! HomeTableViewCell
        cell.captionView.text = dictionary![indexPath.row]["caption"] as? String
//        cell.pictureView.image = dictionary![indexPath.row]["media"] as? UIImage
        cell.pictureView.file = dictionary![indexPath.row]["media"] as? PFFile
        cell.pictureView.loadInBackground()
        return cell
    }
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//    
//        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
//            if let posts = posts {
//                self.dictionary = posts
//                self.tableView.reloadData()
//            } else {
//                print(error?.localizedDescription)
//            }
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
