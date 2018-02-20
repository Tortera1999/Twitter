//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate, TweetCellDelegate {
    
    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    static var tvPoint: UITableView = UITableView()
    
    func did(post: Tweet) {
        print ("YES!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        TimelineViewController.tvPoint = tableView
        
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            } else if let error = error {
                self.tableView.refreshControl?.endRefreshing()
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    @objc func loadTweets() {
        print("wow")
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            } else if let error = error {
                self.tableView.refreshControl?.endRefreshing()
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tweetCell(_ tweetCell: TweetCell, didTap user: User) {
        // TODO: Perform segue to profile view controller
        
        performSegue(withIdentifier: "profileSegue", sender: tweetCell)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "profileSegue") {
            if let cell = sender as? TweetCell {
                let vc = segue.destination as! ProfileViewController
                let indexPath = tableView.indexPath(for: cell)!
                // Pass the selected object to the new view controller.
                let tweet = tweets[indexPath.row].user
                vc.user = tweet;
                
            }
        } else if let cell = sender as? TweetCell {
            let vc = segue.destination as! TweetDetailViewController
            let indexPath = tableView.indexPath(for: cell)!
            // Pass the selected object to the new view controller.
            let tweet = tweets[indexPath.row]
            vc.tweet = tweet
            
        }
    }
    
 
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
