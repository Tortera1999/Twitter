//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
//import Alamofire
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favouriteCountLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user.name
            screenLabel.text = tweet.user.screenName
            dateLabel.text = tweet.createdAtString
            //replyCountLabel.text = tweet.
            retweetCountLabel.text = "\((tweet.retweetCount))"
            favouriteCountLabel.text = "\(String(describing: tweet.favoriteCount))"
            profileView.af_setImage(withURL: URL(string: tweet.profileUrl)!)
            replyCountLabel.text = "\(tweet.replyCount ?? 0)"
            
            if tweet.retweeted == true {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            } else {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }
            
            if tweet.favorited == true {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            } else {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            }
        }
    }
    @IBAction func favoriteTweet(_ sender: Any) {
        //tweet.favorited = true
        //tweet.favoriteCount += 1
        self.favoriteButton.isUserInteractionEnabled = false
        if let favorited = tweet.favorited {
            if favorited {
                APIManager.shared.unfavorite(tweet, completion: { (tweet, error) in
                    if let  error = error {
                        self.favoriteButton.isUserInteractionEnabled = true
                        print("Error unfavoriting tweet: \(error.localizedDescription)")
                        print("Printed here")
                    } else if let tweet = tweet {
                        self.favoriteButton.isUserInteractionEnabled = true
                        print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                        self.tweet = tweet
                        self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
                    }
                })
            } else {
                APIManager.shared.favorite(tweet, completion: { (tweet, error) in
                    if let  error = error {
                        self.favoriteButton.isUserInteractionEnabled = true
                        print("Error favoriting tweet: \(error.localizedDescription)")
                        print("Printed here though!")
                    } else if let tweet = tweet {
                        self.favoriteButton.isUserInteractionEnabled = true
                        print("Successfully favorited the following Tweet: \n\(tweet.text)")
                        self.tweet = tweet
                        self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                    }
                })
            }
        } else {
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    self.favoriteButton.isUserInteractionEnabled = true
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    self.favoriteButton.isUserInteractionEnabled = true
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.tweet = tweet
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                }
            }
        }
        
    }
    @IBAction func retweetTweet(_ sender: Any) {
        //tweet.retweeted = true;
        //tweet.retweetCount += 1;
        if tweet.retweeted {
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                    print("Printed here")
                } else if let tweet = tweet {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
                }
            }
        } else {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Error retweeting tweet: \(error.localizedDescription)")
                    print("Printed here")
                } else if let tweet = tweet {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
                }
            }
        }
    }
    
    @IBAction func replyTweet(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
