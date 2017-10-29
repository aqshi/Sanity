//
//  AppDelegate.swift
//  Sanity
//
//  Created by Max Wong on 10/12/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate{
    
    var window: UIWindow?
    var ref: DatabaseReference!
    
  
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        ref = Database.database().reference()
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if error != nil {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print("Failed login", error)
                return
            }
            print("success login", user!)
//            print(user?.uid as Any)
//            print(user?.email! as Any)
//            print(user?.displayName! as Any)
          
            self.ref.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild((user?.uid)!){
                    print("The user exist")
                    
                }else{
                    print("The user doesn't exist")
                    let userData = ["Email": user?.email!, "Name": user?.displayName!]
                    self.ref.child("Users").child((user?.uid)!).setValue(userData)
                }
            })
            let templist = [String : Budget]()
            Dummy.user = User(userID: (user?.uid)!, name: (user?.displayName!)!, email: (user?.email!)!, budgetList: templist)
            Dummy.dc.getUserObject(userID: Dummy.user.userID)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                print("DIS")
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "initialTabBarViewController") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            })
            

            //dummy data; for testing purposes
            //let budget = ["School" as String,
              //            "Hookers" as String]

//            self.ref.child("Users").child(userID).setValue(["Email":user?.email!])
//
//            let trans1 = [ 12.00,13.99,14.55,15.01 ]
//
//            let trans2 = [ 1.99,299,50]
//
//            self.ref.child("Users").child(userID).child("Budgets/School/Categories/Food/Transactions").setValue(["amt":trans1])
//            self.ref.child("Users").child(userID).child("Budgets/School/Categories/Supplies/Transactions").setValue(["amt":trans2])
//            self.ref.child("Users").child(userID).child("Budgets/Entertainment/Categories/Food/Transactions").setValue(["amt":trans1])
//            self.ref.child("Users").child(userID).child("Budgets/Entertainment/Categories/Travel/Transactions").setValue(["amt":trans2])
//
//
        }
    
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    }

    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

