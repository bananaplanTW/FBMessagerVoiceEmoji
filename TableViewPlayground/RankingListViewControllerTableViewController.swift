//
//  RankingListViewControllerTableViewController.swift
//  TableViewPlayground
//
//  Created by Hanyang Ou on 4/16/15.
//  Copyright (c) 2015 Paul Ou. All rights reserved.
//

import UIKit

class RankingListViewControllerTableViewController: UITableViewController {

    var emoji = ["yo", "whats up"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("fetchRanking"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
    }

    func fetchRanking() {
        
        
        let url = NSURL(string: "http://fb-emoji-bananaplan.meteor.com/emojiiiii")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data: NSData!, response:NSURLResponse!,
            error: NSError!) -> Void in
            //do something
            var index = 0
            let httpResponse = NSString(data: data, encoding: NSUTF8StringEncoding)!
            println(httpResponse)
            var data: NSData = httpResponse.dataUsingEncoding(NSUTF8StringEncoding)!
            var error: NSError?
            let anyObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0),
                error: &error)
            if let jsonObj = anyObj as? NSDictionary {
                if let jsonData = jsonObj["data"] as? NSArray {
                    for jsonItem in jsonData as [AnyObject]{
                        if let rankData = jsonItem as? NSDictionary {
                            if let rankTitle = rankData["editor"] as? NSString {
                                println("title : \(rankTitle)")
                                self.emoji[index] = rankTitle
                                index++
                            }
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
            
            
            
        })
        task.resume()
        

        refreshControl?.endRefreshing()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return emoji.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EmojiCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        
        let emojiCell = emoji[indexPath.row] as String
        cell.textLabel?.text = emojiCell
        cell.detailTextLabel?.text = emojiCell
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
