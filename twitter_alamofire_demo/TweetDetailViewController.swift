//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Nikhil Iyer on 2/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var tweetDetail: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var tweet: Tweet!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePic.af_setImage(withURL: URL(string: tweet.profileUrl)!)
        userNameLabel.text = tweet.user.name
        userIdLabel.text = tweet.user.screenName
        tweetDetail.text = tweet.text
        dateLabel.text = tweet.createdAtString
        
        if tweet.retweeted == true {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        } else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        
        if tweet.favorited == true {
            favButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        } else {
            favButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        
        retweetCountLabel.text = "\(String(describing: tweet.retweetCount))"
        favCountLabel.text = "\(String(describing: tweet.favoriteCount))"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapToFavorite(_ sender: Any) {
        tweet.favorited = !(tweet.favorited)
        
        if (tweet.favorited == true) {
            
            tweet.favoriteCount = tweet.favoriteCount + 1
            self.favButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            favCountLabel.text = "\(String(describing: tweet.favoriteCount))"
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
            
        else {
            tweet.favoriteCount = tweet.favoriteCount - 1
            self.favButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
            favCountLabel.text = "\(String(describing: tweet.favoriteCount))"
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        TimelineViewController.tvPoint.reloadData();
    }
    
    @IBAction func tapToRetweet(_ sender: Any) {
        tweet.retweeted = !(tweet.retweeted)
        
        if (tweet.retweeted == true) {
            
            tweet.retweetCount = tweet.retweetCount + 1
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            retweetCountLabel.text = "\(String(describing: tweet.retweetCount))"
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
            
        else {
            tweet.retweetCount = tweet.retweetCount - 1
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            retweetCountLabel.text = "\(String(describing: tweet.retweetCount))"
            
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        TimelineViewController.tvPoint.reloadData();
    }

    @IBAction func doneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
