//
//  AppDelegate.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 03/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

struct Constants {
    struct conn {
     
   // static let ConnUrl = "http://10.10.0.154/almutlaq/api/v1/"
        //static let ConnUrl = "http://almutlaqrealestate.com/servicemanager/api/v1/" /// Live1
        static let ConnUrl = "http://almutlaq.info/api/v1/" /// Live2
        
        //COLOR CODES
        //RGB(78,129,237) HEX #4e81ed
    }
}

import UIKit
import CoreData
import QuartzCore;
import CoreGraphics;

import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

let gcmMessageIDKey = "gcm.message_id"
 var ActiveData = NSString()


//,UNUserNotificationCenterDelegate, MessagingDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self as MessagingDelegate
        //UIApplication.shared.registerForRemoteNotifications()
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        //Solicit permission from user to receive notifications
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (_, error) in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
        }
        
        //get application instance ID
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
               
                #if targetEnvironment(simulator)
                // Simulator!
                  UserDefaults.standard.set(result.token, forKey: "FCM_Token")
                #endif
                
            }
        }
        application.registerForRemoteNotifications()
        
       
        /*UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            print(familyName, fontNames)
        })*/
        
        //"Roboto-Regular", "Roboto-Black", "Roboto-Light", "Roboto-Thin", "Roboto-Medium", "Roboto-Bold" "RobotoCondensed-Regular", "RobotoCondensed-Light", "RobotoCondensed-Bold"
       
        navController = UINavigationController()
        var obj = login()
        obj = login(nibName: "login", bundle: nil)
        self.navController?.pushViewController(obj, animated: false)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = navController
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        return true
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
        // Saves changes in the application's managed object context before the application terminates.
        
        //UserDefaults.standard.set(0, forKey: "tutoriallaunch")
        //UserDefaults.standard.synchronize()
        //UIApplicationExitsOnSuspend =YES
       
        self.saveContext()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "AlMutlaqRealEstate")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
// MARK: -Firebase Delegates

    func application(application: UIApplication,  didReceiveRemoteNotification userInfo: [NSObject : AnyObject],  fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
       print("Recived 1: \(userInfo)")
        completionHandler(.newData)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID 1: \(messageID)")
        }
         // Print full message.
        print("userInfo 3: \(userInfo)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        debugPrint("Received 2 : \(userInfo)")
        completionHandler(.newData)
        // Print full message.
        print("userInfo 2 : \(userInfo)")
      
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        // Messaging.messaging().isAutoInitEnabled = true
        Messaging.messaging().apnsToken = deviceToken as Data
        print("APNs token retrieved 1: \(deviceToken)")
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved 2: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
        
        print("Token is here  1  \(String(describing: Messaging.messaging().fcmToken))")
        print("Token is here  2  \(String(describing: Messaging.messaging().apnsToken))")
        
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print(token)
        
        
        if UserDefaults.standard.object(forKey: "FCM_Token") == nil
        {
            UserDefaults.standard.set(Messaging.messaging().fcmToken, forKey: "FCM_Token")
        }
        else
        {
            let fcmSavedToken = UserDefaults.standard.value(forKey: "FCM_Token") as! String
            if fcmSavedToken == Messaging.messaging().fcmToken
            {
                
            }
            else
            {
                UserDefaults.standard.set(Messaging.messaging().fcmToken, forKey: "FCM_Token")
            }
        }
        
        
      //  print("sabnam 1  \(UserDefaults.standard.object(forKey: "FCM_Token"))")
    }
  
    func GCMMessageReceived(_ notification: Notification){
        
        if let userInfo = notification.userInfo as? Dictionary<String,AnyObject> {
            print("userInfo sabnam 1: \(userInfo)")
           // let gcmID = userInfo["gcm.message_id"] as? NSString
            
           
            UserDefaults.standard.setValue(userInfo.description, forKey: "s0")
           
            let title =  String(format:"%@",(userInfo["title"] as? CVarArg)!)
            let message = String(format:"%@",(userInfo["message"] as? CVarArg)!)
            let page =   String(format:"%@",(userInfo["page"] as? CVarArg)!)
             let service_booking_id =  String(format:"%@",(userInfo["service_booking_id"] as? CVarArg)!)
        
            
              print("title sabnam 1: \(title)")
              print("message sabnam 1: \(message)")
              print("page sabnam 1: \(page)")
              print("service_booking_id sabnam 1: \(service_booking_id)")
            
            if ActiveData == "active"{
                var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                topWindow?.rootViewController = UIViewController()
                topWindow?.windowLevel = UIWindowLevelAlert + 1
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
                    topWindow?.isHidden = true // if you want to hide the topwindow then use this
                    topWindow = nil // if you want to hide the topwindow then use this
                }))
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                    // continue your work
                    
                    
                    
                    if let aps = userInfo["aps"] as? NSDictionary {
                        if (aps["alert"] as? NSDictionary) != nil {
                            
                            let dicUserDetails = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
                            let strusertype = String(format: "%@", dicUserDetails.value(forKey: "user_type") as! CVarArg)
                            print("strusertype -> \(strusertype)")
                            if(strusertype .isEqual("T"))
                            {
                                // tenant
                                if page == "tenant service details" {
                                    
                                    var obj = JobDetail()
                                    let screenSize = UIScreen.main.bounds
                                    if (screenSize.height == 568.0){
                                        //5S
                                        obj = JobDetail(nibName: "JobDetail5S", bundle: nil)
                                    }
                                        
                                    else if (screenSize.height == 480.0){
                                        //5S
                                        obj = JobDetail(nibName: "JobDetail4S", bundle: nil)
                                    }
                                    else if(screenSize.height == 667.0){
                                        //6
                                        obj = JobDetail(nibName: "JobDetail", bundle: nil)
                                    }
                                    else if(screenSize.height == 736.0){
                                        // 6Plus
                                        obj = JobDetail(nibName: "JobDetail6Plus", bundle: nil)
                                    }
                                    else if(screenSize.height == 812.0){
                                        //x
                                        obj = JobDetail(nibName: "JobDetailX", bundle: nil)
                                    }
                                    else{
                                        obj = JobDetail(nibName: "JobDetailXSMAX", bundle: nil)
                                    }
                                    
                                    obj.strIdentifier = service_booking_id as NSString
                                    print("dictemp strbookingID -> \(service_booking_id)")
                                    
                                    self.navController?.pushViewController(obj, animated: true)
                                    
                                }
                                    
                                else   if page == "notification" {
                                    let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                                        (  self.navController?.navigationBar.frame.height ?? 0.0)
                                    let hh =   self.navController?.navigationBar.frame.maxY
                                    var obj = MessageList()
                                    if hh == -20.0 || navigationBarHeight == 64.0{
                                        obj = MessageList(nibName: "MessageList", bundle: nil)
                                    }
                                    else{
                                        //X
                                        obj = MessageList(nibName: "MessageListX", bundle: nil)
                                    }
                                    self.navController?.pushViewController(obj, animated: true)
                                }
                                else   if page == "complaint listing" {
                                    let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                                        (  self.navController?.navigationBar.frame.height ?? 0.0)
                                    let hh =   self.navController?.navigationBar.frame.maxY
                                    var obj = ComplainList()
                                    if hh == -20.0 || navigationBarHeight == 64.0{
                                        obj = ComplainList(nibName: "ComplainList", bundle: nil)
                                    }
                                    else{
                                        //X
                                        obj = ComplainList(nibName: "ComplainListX", bundle: nil)
                                    }
                                    obj.strIdentSugCompain = "C"
                                    self.navController?.pushViewController(obj, animated: true)
                                }
                                else   if page == "suggestion listing" {
                                    let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                                        (  self.navController?.navigationBar.frame.height ?? 0.0)
                                    let hh =   self.navController?.navigationBar.frame.maxY
                                    var obj = ComplainList()
                                    if hh == -20.0 || navigationBarHeight == 64.0{
                                        obj = ComplainList(nibName: "ComplainList", bundle: nil)
                                    }
                                    else{
                                        //X
                                        obj = ComplainList(nibName: "ComplainListX", bundle: nil)
                                    }
                                    obj.strIdentSugCompain = "S"
                                    self.navController?.pushViewController(obj, animated: true)
                                }
                            }
                            else if(strusertype .isEqual("S"))
                            {
                                //customer
                                if page == "customer service details" {
                                    
                                    var obj = CSTaskdetails()
                                    
                                    
                                    let screenSize = UIScreen.main.bounds
                                    if (screenSize.height == 568.0){
                                        //5S
                                        obj = CSTaskdetails(nibName: "CSTaskdetails5S", bundle: nil)
                                    }
                                    else   if (screenSize.height == 480.0){
                                        //5S
                                        obj = CSTaskdetails(nibName: "CSTaskdetails4S", bundle: nil)
                                    }
                                    else if(screenSize.height == 667.0){
                                        //6
                                        obj = CSTaskdetails(nibName: "CSTaskdetails", bundle: nil)
                                    }
                                    else if(screenSize.height == 736.0){
                                        // 6Plus
                                        obj = CSTaskdetails(nibName: "CSTaskdetails6Plus", bundle: nil)
                                    }
                                    else if(screenSize.height == 812.0){
                                        //x
                                        obj = CSTaskdetails(nibName: "CSTaskdetailsX", bundle: nil)
                                    }
                                    else
                                    {
                                        obj = CSTaskdetails(nibName: "CSTaskdetailsXSMAX", bundle: nil)
                                        
                                    }
                                    
                                    obj.strIdentifier = service_booking_id as NSString
                                    self.navController?.pushViewController(obj, animated: true)
                                }
                                else   if page == "customer service details" {
                                    
                                    var obj = CSTaskdetails()
                                    
                                    
                                    let screenSize = UIScreen.main.bounds
                                    if (screenSize.height == 568.0){
                                        //5S
                                        obj = CSTaskdetails(nibName: "CSTaskdetails5S", bundle: nil)
                                    }
                                    else   if (screenSize.height == 480.0){
                                        //5S
                                        obj = CSTaskdetails(nibName: "CSTaskdetails4S", bundle: nil)
                                    }
                                    else if(screenSize.height == 667.0){
                                        //6
                                        obj = CSTaskdetails(nibName: "CSTaskdetails", bundle: nil)
                                    }
                                    else if(screenSize.height == 736.0){
                                        // 6Plus
                                        obj = CSTaskdetails(nibName: "CSTaskdetails6Plus", bundle: nil)
                                    }
                                    else if(screenSize.height == 812.0){
                                        //x
                                        obj = CSTaskdetails(nibName: "CSTaskdetailsX", bundle: nil)
                                    }
                                    else
                                    {
                                        obj = CSTaskdetails(nibName: "CSTaskdetailsXSMAX", bundle: nil)
                                        
                                    }
                                    
                                    obj.strIdentifier = service_booking_id as NSString
                                    self.navController?.pushViewController(obj, animated: true)
                                }
                                else   if page == "notification" {
                                    let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                                        (  self.navController?.navigationBar.frame.height ?? 0.0)
                                    let hh =   self.navController?.navigationBar.frame.maxY
                                    var obj = MessageList()
                                    if hh == -20.0 || navigationBarHeight == 64.0{
                                        obj = MessageList(nibName: "MessageList", bundle: nil)
                                    }
                                    else{
                                        //X
                                        obj = MessageList(nibName: "MessageListX", bundle: nil)
                                    }
                                    self.navController?.pushViewController(obj, animated: true)
                                }
                            }
                            else{
                                //login
                                var obj = login()
                                obj = login(nibName: "login", bundle: nil)
                                self.navController?.pushViewController(obj, animated: true)
                            }
                            
                            
                            
                        }
                    }
                    
                    topWindow?.isHidden = true // if you want to hide the topwindow then use this
                    topWindow = nil // if you want to hide the topwindow then use this
                }))
                
                topWindow?.makeKeyAndVisible()
                topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            else  if ActiveData == "Inactive"{
                
                
                
                if let aps = userInfo["aps"] as? NSDictionary {
                    if (aps["alert"] as? NSDictionary) != nil {
                        
                        let dicUserDetails = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
                        let strusertype = String(format: "%@", dicUserDetails.value(forKey: "user_type") as! CVarArg)
                        print("strusertype -> \(strusertype)")
                        if(strusertype .isEqual("T"))
                        {
                            // tenant
                            if page == "tenant service details" {
                                
                                var obj = JobDetail()
                                let screenSize = UIScreen.main.bounds
                                if (screenSize.height == 568.0){
                                    //5S
                                    obj = JobDetail(nibName: "JobDetail5S", bundle: nil)
                                }
                                    
                                else if (screenSize.height == 480.0){
                                    //5S
                                    obj = JobDetail(nibName: "JobDetail4S", bundle: nil)
                                }
                                else if(screenSize.height == 667.0){
                                    //6
                                    obj = JobDetail(nibName: "JobDetail", bundle: nil)
                                }
                                else if(screenSize.height == 736.0){
                                    // 6Plus
                                    obj = JobDetail(nibName: "JobDetail6Plus", bundle: nil)
                                }
                                else if(screenSize.height == 812.0){
                                    //x
                                    obj = JobDetail(nibName: "JobDetailX", bundle: nil)
                                }
                                else{
                                    obj = JobDetail(nibName: "JobDetailXSMAX", bundle: nil)
                                }
                                
                                obj.strIdentifier = service_booking_id as NSString
                                print("dictemp strbookingID -> \(service_booking_id)")
                                
                                self.navController?.pushViewController(obj, animated: true)
                                
                            }
                                
                            else   if page == "notification" {
                                let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                                    (  self.navController?.navigationBar.frame.height ?? 0.0)
                                let hh =   self.navController?.navigationBar.frame.maxY
                                var obj = MessageList()
                                if hh == -20.0 || navigationBarHeight == 64.0{
                                    obj = MessageList(nibName: "MessageList", bundle: nil)
                                }
                                else{
                                    //X
                                    obj = MessageList(nibName: "MessageListX", bundle: nil)
                                }
                                self.navController?.pushViewController(obj, animated: true)
                            }
                            else   if page == "complaint listing" {
                                let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                                    (  self.navController?.navigationBar.frame.height ?? 0.0)
                                let hh =   self.navController?.navigationBar.frame.maxY
                                var obj = ComplainList()
                                if hh == -20.0 || navigationBarHeight == 64.0{
                                    obj = ComplainList(nibName: "ComplainList", bundle: nil)
                                }
                                else{
                                    //X
                                    obj = ComplainList(nibName: "ComplainListX", bundle: nil)
                                }
                                obj.strIdentSugCompain = "C"
                                self.navController?.pushViewController(obj, animated: true)
                            }
                            else   if page == "suggestion listing" {
                                let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                                    (  self.navController?.navigationBar.frame.height ?? 0.0)
                                let hh =   self.navController?.navigationBar.frame.maxY
                                var obj = ComplainList()
                                if hh == -20.0 || navigationBarHeight == 64.0{
                                    obj = ComplainList(nibName: "ComplainList", bundle: nil)
                                }
                                else{
                                    //X
                                    obj = ComplainList(nibName: "ComplainListX", bundle: nil)
                                }
                                obj.strIdentSugCompain = "S"
                                self.navController?.pushViewController(obj, animated: true)
                            }
                        }
                        else if(strusertype .isEqual("S"))
                        {
                            //customer
                            if page == "customer service details" {
                                
                                var obj = CSTaskdetails()
                                
                                
                                let screenSize = UIScreen.main.bounds
                                if (screenSize.height == 568.0){
                                    //5S
                                    obj = CSTaskdetails(nibName: "CSTaskdetails5S", bundle: nil)
                                }
                                else   if (screenSize.height == 480.0){
                                    //5S
                                    obj = CSTaskdetails(nibName: "CSTaskdetails4S", bundle: nil)
                                }
                                else if(screenSize.height == 667.0){
                                    //6
                                    obj = CSTaskdetails(nibName: "CSTaskdetails", bundle: nil)
                                }
                                else if(screenSize.height == 736.0){
                                    // 6Plus
                                    obj = CSTaskdetails(nibName: "CSTaskdetails6Plus", bundle: nil)
                                }
                                else if(screenSize.height == 812.0){
                                    //x
                                    obj = CSTaskdetails(nibName: "CSTaskdetailsX", bundle: nil)
                                }
                                else
                                {
                                    obj = CSTaskdetails(nibName: "CSTaskdetailsXSMAX", bundle: nil)
                                    
                                }
                                
                                obj.strIdentifier = service_booking_id as NSString
                                self.navController?.pushViewController(obj, animated: true)
                            }
                            else   if page == "customer service details" {
                                
                                var obj = CSTaskdetails()
                                
                                
                                let screenSize = UIScreen.main.bounds
                                if (screenSize.height == 568.0){
                                    //5S
                                    obj = CSTaskdetails(nibName: "CSTaskdetails5S", bundle: nil)
                                }
                                else   if (screenSize.height == 480.0){
                                    //5S
                                    obj = CSTaskdetails(nibName: "CSTaskdetails4S", bundle: nil)
                                }
                                else if(screenSize.height == 667.0){
                                    //6
                                    obj = CSTaskdetails(nibName: "CSTaskdetails", bundle: nil)
                                }
                                else if(screenSize.height == 736.0){
                                    // 6Plus
                                    obj = CSTaskdetails(nibName: "CSTaskdetails6Plus", bundle: nil)
                                }
                                else if(screenSize.height == 812.0){
                                    //x
                                    obj = CSTaskdetails(nibName: "CSTaskdetailsX", bundle: nil)
                                }
                                else
                                {
                                    obj = CSTaskdetails(nibName: "CSTaskdetailsXSMAX", bundle: nil)
                                    
                                }
                                
                                obj.strIdentifier = service_booking_id as NSString
                                self.navController?.pushViewController(obj, animated: true)
                            }
                            else   if page == "notification" {
                                let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                                    (  self.navController?.navigationBar.frame.height ?? 0.0)
                                let hh =   self.navController?.navigationBar.frame.maxY
                                var obj = MessageList()
                                if hh == -20.0 || navigationBarHeight == 64.0{
                                    obj = MessageList(nibName: "MessageList", bundle: nil)
                                }
                                else{
                                    //X
                                    obj = MessageList(nibName: "MessageListX", bundle: nil)
                                }
                                self.navController?.pushViewController(obj, animated: true)
                            }
                        }
                        else{
                            //login
                            var obj = login()
                            obj = login(nibName: "login", bundle: nil)
                            self.navController?.pushViewController(obj, animated: true)
                        }
                        
                        
                        
                    }
                }
                
            }
            
         
        }
       
    }
   
}

    

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    
    /// for  push data details
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          let userInfo = notification.request.content.userInfo
       //    let userInfo1 = notification
         print("sabnam: \(userInfo)")
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID 2: \(messageID)")
        }
        
        // Print full message.
     
        print("userInfo 1: \(userInfo)")
        
    //    var dict : Dictionary = Dictionary<AnyHashable,Any>()
     
        ActiveData = "active"
          self.GCMMessageReceived(Notification(name: Notification.Name(rawValue: gcmMessageIDKey), object: nil, userInfo: userInfo) )
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: gcmMessageIDKey), object: userInfo)
        
        completionHandler([])
    }
 

    
    //// background to Active
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
       let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID 3: \(messageID)")
        }
     
        // Print full message.
     // print("userInfo 2: %@",userInfo)
      ActiveData = "Inactive"
        let state = UIApplication.shared.applicationState
        if state == .background  {
            // background kill
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                print("sabnam 2: %@","nasrin")
                self.GCMMessageReceived(Notification(name: Notification.Name(rawValue: gcmMessageIDKey), object: nil, userInfo: userInfo) )
            })
        }
        else  if state == .inactive  {
            // background kill
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                print("sabnam 2: %@","dalim")
                self.GCMMessageReceived(Notification(name: Notification.Name(rawValue: gcmMessageIDKey), object: nil, userInfo: userInfo) )
            })
        }
        else  {
            self.GCMMessageReceived(Notification(name: Notification.Name(rawValue: gcmMessageIDKey), object: nil, userInfo: userInfo) )
          
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: gcmMessageIDKey), object: userInfo)
        completionHandler()
        
        
     
    }
    
}



extension AppDelegate: MessagingDelegate{
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        print("Firebase registration token: \(fcmToken)")
        print("Received Remote Message: 1\nCheck Out:\n")
        //  [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"deviceToken"];
        
        if UserDefaults.standard.object(forKey: "FCM_Token") == nil
        {
            UserDefaults.standard.set(fcmToken, forKey: "FCM_Token")
        }
        else
        {
            let fcmSavedToken = UserDefaults.standard.value(forKey: "FCM_Token") as! String
            if fcmSavedToken == fcmToken
            {
                
            }
            else
            {
                UserDefaults.standard.set(fcmToken, forKey: "FCM_Token")
            }
        }
        
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
        
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        print("Received Remote Message: 2\nCheck Out:\n")
     }
    
    
    // Receive data message on iOS 10 devices while app is in the foreground.
    func application(received remoteMessage: MessagingRemoteMessage) {
        print("Received Remote Message: 3\nCheck In:\n")
        debugPrint(remoteMessage.appData)
        print("Received Remote Message: 3\nCheck Out:\n")
    }
    // [END ios_10_data_message]
}
