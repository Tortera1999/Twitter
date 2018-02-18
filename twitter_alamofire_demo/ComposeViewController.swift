//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Nikhil Iyer on 2/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: class{
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: ComposeViewControllerDelegate?

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var charRemaining: UILabel!
    @IBOutlet weak var newTweet: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newTweet.translatesAutoresizingMaskIntoConstraints = true
        newTweet.sizeToFit()
        newTweet.isScrollEnabled = false
        
        APIManager.shared.getCurrentAccount(completion: { (user, error) in
            if let error = error {
                print("HUH? ERROR ----------------")
                print (error)
            } else if let user = user {
                //print("Welcome \(user.name)")
                self.profilePhoto.af_setImage(withURL: user.profilePic!)
                self.userName.text = user.name;
                self.userId.text = user.screenName;
                
                
            }
        })
        
        newTweet.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: newTweet.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                TimelineViewController.tvPoint.reloadData();
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func textView(_ newTweet: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (newTweet.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count
        charRemaining.text = "\(140 - Int(numberOfChars))"
        return numberOfChars < 140
    }
    @IBAction func back(_ sender: Any) {
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
