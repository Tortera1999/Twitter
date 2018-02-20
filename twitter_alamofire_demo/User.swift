//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var screenName: String
    var profilePic: URL?
    var backgroundUrl: URL?
    var tweetsTotal: Int
    var followingTotal: Int
    var followersTotal: Int
    var descriptionOfUser: String
    
    static var current: User?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        profilePic = URL(string: ((dictionary["profile_image_url_https"] as? String))!)
        if let url = dictionary["profile_banner_url"] as? String{
            backgroundUrl = URL(string: url)
            print("My B Url")
            print(backgroundUrl!);
        }
        
        followingTotal = (dictionary["friends_count"] as? Int)!
        followersTotal = (dictionary["followers_count"] as? Int)!
        tweetsTotal = (dictionary["statuses_count"] as? Int)!
        
        descriptionOfUser = dictionary["description"] as! String
    }
}
