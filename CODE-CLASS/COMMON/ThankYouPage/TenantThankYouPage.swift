//
//  TenantThankYouPage.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 09/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class TenantThankYouPage: ViewController {
var strMessage = NSString()
    @IBOutlet var viewUpper: UIView!
    @IBOutlet var imgvThumbsup: UIImageView!
    @IBOutlet var lblThankyou: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var btnHome: UIButton!
    
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        lblMessage.text = NSString(format:"%@", strMessage) as String
        viewUpper.layer.shadowColor = UIColor.lightGray.cgColor
        viewUpper.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewUpper.layer.shadowRadius = 0.0
        viewUpper.layer.shadowOpacity = 2.0
        viewUpper.layer.masksToBounds = false
        
        //btnHome.layer.borderWidth=1.0
        //btnHome.layer.borderColor=UIColor(red: 56.0/255, green: 82.0/255, blue: 169.0/255, alpha: 1.0).cgColor
        btnHome.layer.cornerRadius = 4.0
        btnHome.layer.masksToBounds = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - pressHome Method
    @IBAction func pressHome(_ sender: Any)
    {
           let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strusertype = String(format: "%@", dictemp.value(forKey: "user_type") as! CVarArg)
        print("strusertype -> \(strusertype)")
        if(strusertype .isEqual("T"))
        {
            OperationQueue.main.addOperation {
                
                for controller in self.navigationController!.viewControllers as Array
                {
                    if controller.isKind(of: TenantDashboard.self)
                    {
                        var obj = TenantDashboard()
                        
                        let screenSize = UIScreen.main.bounds
                        if (screenSize.height == 568.0){
                            //5S
                            obj = TenantDashboard(nibName: "TenantDashboard5S", bundle: nil)
                        }
                        else if (screenSize.height == 480.0){
                            //5S
                            obj = TenantDashboard(nibName: "TenantDashboard4S", bundle: nil)
                        }
                        else if(screenSize.height == 667.0){
                            //6
                            obj = TenantDashboard(nibName: "TenantDashboard", bundle: nil)
                        }
                        else if(screenSize.height == 736.0){
                            // 6Plus
                            obj = TenantDashboard(nibName: "TenantDashboard6Plus", bundle: nil)
                        }
                        else if(screenSize.height == 812.0){
                            //x
                            obj = TenantDashboard(nibName: "TenantDashboardX", bundle: nil)
                        }
                        else
                        {
                            obj = TenantDashboard(nibName: "TenantDashboardXSMAX", bundle: nil)
                            
                        }
                        
                        _ =  self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
             }
        }
        else if(strusertype .isEqual("S"))
        {
            OperationQueue.main.addOperation {
               //
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: CSDashboard.self) {
                        let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                            (self.navigationController?.navigationBar.frame.height ?? 0.0)
                        let hh = self.navigationController?.navigationBar.frame.maxY
                        print("nav bar  : %@",hh ?? (Any).self)
                        var obj = CSDashboard()
                        if hh == -20.0 || navigationBarHeight == 64.0{
                            obj = CSDashboard(nibName: "CSDashboard", bundle: nil)
                        }
                        else{
                            obj = CSDashboard(nibName: "CSDashboardX", bundle: nil)
                        }
                      
                        
                        _ =  self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
        }
        }
       
 
    }

}
