//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Nikhil Iyer on 2/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var totalTweets: UILabel!
    @IBOutlet weak var totalFollowing: UILabel!
    @IBOutlet weak var totalFollowers: UILabel!
    @IBOutlet weak var descriptionOftheUser: UILabel!
    
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.layer.borderWidth = 1.0
        profilePic.layer.masksToBounds = false
        profilePic.layer.borderColor = UIColor.white.cgColor
        profilePic.layer.cornerRadius = profilePic.frame.height/2
        profilePic.clipsToBounds = true
        if let user = user {
            print("The user")
            self.profilePic.af_setImage(withURL: user.profilePic!)
            self.backdrop.af_setImage(withURL: (user.backgroundUrl)!)
            self.userName.text = user.name;
            self.userId.text = "@\(user.screenName)";
            self.totalTweets.text = "\(user.tweetsTotal)"
            self.totalFollowing.text = "\(user.followingTotal)"
            self.totalFollowers.text = "\(user.followersTotal)"
            self.descriptionOftheUser.text = user.descriptionOfUser;
            
        } else {
            APIManager.shared.getCurrentAccount(completion: { (user, error) in
                if let error = error {
                    print("HUH? ERROR ----------------")
                    print (error)
                } else if let user = user {
                    //print("Welcome \(user.name)")
                    
                    self.backdrop.af_setImage(withURL: (user.backgroundUrl)!)
                    self.profilePic.af_setImage(withURL: user.profilePic!)
                    self.userName.text = user.name;
                    self.userId.text = "@\(user.screenName)";
                    self.totalTweets.text = "\(user.tweetsTotal)"
                    self.totalFollowing.text = "\(user.followingTotal)"
                    self.totalFollowers.text = "\(user.followersTotal)"
                    self.descriptionOftheUser.text = user.descriptionOfUser;
                    
                }
            })

        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(_ sender: Any) {
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
