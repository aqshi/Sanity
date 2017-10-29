//
//  ViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/12/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import UserNotifications

class ViewController: UIViewController, GIDSignInUIDelegate{
    
    @IBAction func testButtonPressed(_ sender: Any) {
        //User.purchaseOverLimitNotification
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        //signInButton.addTarget(self, action: selector(handleSignin), for: .touchUpInside)
        //setupGoogleButtons()
       // signInButton.frame = CGRect(x:87, y:116+66, width:200, height: 50)
        //if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
         //   print("signed in")
            // Forward the user here straight away...
        //}
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            print("reach here")
            
            //reloadMain
            let notificationNme = NSNotification.Name("reloadMain")
            NotificationCenter.default.post(name: notificationNme, object: nil)
            
            self.performSegue(withIdentifier: "LoggedIn" , sender: self)
        } else {
            let alertController = UIAlertController(title: "Sign in Failed", message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
            
            let DestructiveAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive) {
                (result : UIAlertAction) -> Void in
                print("")
            }
            alertController.addAction(DestructiveAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func handleSignin() {
        GIDSignIn.sharedInstance().signIn()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//Global Local//Global Local//Global Local//Global Local//Global Local
//Global Local//Global Local//Global Local//Global Local//Global Local
//Global Local//Global Local//Global Local//Global Local//Global Local
//var globalUser = User( userID: "lol" , name: "myName" , email: "me@gmail", budgetList: [Budget]())
