//
//  TenantDashboard.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 03/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class TenantDashboard: ViewController
{
    @IBOutlet var btnBookService: UIButton!
    @IBOutlet var btnServiceStatus: UIButton!
    @IBOutlet var btnComplaintStatus: UIButton!
    @IBOutlet var btnSOS: UIButton!
    //
    @IBOutlet var imgvBannerBG: UIImageView!
    @IBOutlet var btnSlide: UIButton!
    
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
        self.setupborder()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Notification Method
    @IBAction func btnNotification(_ sender: Any)
    {
        let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let hh = self.navigationController?.navigationBar.frame.maxY
        var obj = MessageList()
        if hh == -20.0 || navigationBarHeight == 64.0{
            obj = MessageList(nibName: "MessageList", bundle: nil)
        }
        else{
            //X
            obj = MessageList(nibName: "MessageListX", bundle: nil)
        }
      self.navigationController?.pushViewController(obj, animated: true)
    }
    
    
   // MARK: - pressSlide Method
    @IBAction func pressSlide(_ sender: Any)
    {
        let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let hh = self.navigationController?.navigationBar.frame.maxY
        var obj = Slidemenu()
        if hh == -20.0 || navigationBarHeight == 64.0{
            obj = Slidemenu(nibName: "Slidemenu", bundle: nil)
        }
        else{
            //X
            obj = Slidemenu(nibName: "SlidemenuX", bundle: nil)
        }
        
        obj.view.frame=CGRect(x: 0, y: 0, width: -UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.addChildViewController(obj)
        self.view.addSubview(obj.view)
        obj.didMove(toParentViewController: self)
        
        UIView.animate(withDuration: 0.5, animations: {
            obj.view.frame=CGRect(x:0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }, completion: nil)
    }
    
    //MARK: - Setup Border stye
    func setupborder() -> Void
    {
        let att1 = NSMutableAttributedString(string: "\("Book ")\("Service")");
        att1.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: ("Book ").characters.count))
        att1.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red: 211/255, green: 182/255, blue: 42/255, alpha: 1.0), range: NSRange(location: ("Book ").characters.count, length: ("Service").characters.count))
        btnBookService.setAttributedTitle(att1, for: .normal)
        
        btnBookService.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).cgColor
        btnBookService.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnBookService.layer.shadowOpacity = 1.0
        btnBookService.layer.shadowRadius = 0.0
        btnBookService.layer.masksToBounds = false
        btnBookService.layer.cornerRadius = 4.0
        
        let att2 = NSMutableAttributedString(string: "\("Service ")\("Status")");
        att2.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: ("Service ").characters.count))
        att2.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red: 211/255, green: 182/255, blue: 42/255, alpha: 1.0), range: NSRange(location: ("Service ").characters.count, length: ("Status").characters.count))
        btnServiceStatus.setAttributedTitle(att2, for: .normal)
        
        btnServiceStatus.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).cgColor
        btnServiceStatus.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnServiceStatus.layer.shadowOpacity = 1.0
        btnServiceStatus.layer.shadowRadius = 0.0
        btnServiceStatus.layer.masksToBounds = false
        btnServiceStatus.layer.cornerRadius = 4.0
        
        
        let att4 = NSMutableAttributedString(string: "\("Complaint/")\("Suggestion")");
        att4.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: ("Complaint/").characters.count))
        att4.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red: 211/255, green: 182/255, blue: 42/255, alpha: 1.0), range: NSRange(location: ("Complaint/").characters.count, length: ("Suggestion").characters.count))
        btnComplaintStatus.setAttributedTitle(att4, for: .normal)
        
        btnComplaintStatus.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).cgColor
        btnComplaintStatus.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnComplaintStatus.layer.shadowOpacity = 1.0
        btnComplaintStatus.layer.shadowRadius = 0.0
        btnComplaintStatus.layer.masksToBounds = false 
        btnComplaintStatus.layer.cornerRadius = 4.0
        
        btnSOS.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).cgColor
        btnSOS.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnSOS.layer.shadowOpacity = 1.0
        btnSOS.layer.shadowRadius = 0.0
        btnSOS.layer.masksToBounds = false
        btnSOS.layer.cornerRadius = 4.0
    }
   
    
    //MARK: - press Button Method
    @IBAction func pressBookService(_ sender: Any) {
       let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let hh = self.navigationController?.navigationBar.frame.maxY
         var obj = JobTypeMaster()
        if hh == -20.0 || navigationBarHeight == 64.0{
            obj = JobTypeMaster(nibName: "JobTypeMaster", bundle: nil)
         }
        else{
            //X
           obj = JobTypeMaster(nibName: "JobTypeMasterX", bundle: nil)
         }
          self.navigationController?.pushViewController(obj, animated: true)
 }
    @IBAction func pressServiceStatus(_ sender: Any) {
        let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let hh = self.navigationController?.navigationBar.frame.maxY
         if hh == -20.0 || navigationBarHeight == 64.0{
            var obj = Servicestatus()
            obj = Servicestatus(nibName: "Servicestatus", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else{
            //X
            var obj = Servicestatus()
            obj = Servicestatus(nibName: "ServicestatusX", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
        }
    }
    @IBAction func pressComplaintStatus(_ sender: Any)
    {
        let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let hh = self.navigationController?.navigationBar.frame.maxY
       if hh == -20.0 || navigationBarHeight == 64.0{
            var obj = ComplainList()
            obj = ComplainList(nibName: "ComplainList", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else{
            //X
            var obj = ComplainList()
            obj = ComplainList(nibName: "ComplainListX", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
        }
     }
    @IBAction func pressSOS(_ sender: Any)
    {
         let date = Date()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "EEEE"
         let currentDay = dateFormatter.string(from: date).capitalized
         print("currentDay : ",currentDay)
         dateFormatter.dateFormat = "HH:mm"
         let currentTime = dateFormatter.string(from: date).capitalized
         print("currentTime : ",currentTime)
     
         let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
         
         let arrmH :NSArray =  dictemp.value(forKey: "working_hours") as! NSArray
         let arrHours:NSMutableArray = NSMutableArray(array: arrmH)
         
         
         for d in 0 ..<  arrHours.count
         {
         let Dic : NSMutableDictionary = arrHours.object(at: d) as! NSMutableDictionary
         let dailytime_status = String(format: "%@", Dic.value(forKey: "dailytime_status") as! CVarArg)
         //  Dic.value(forKey: "dailytime_status") as! Int
         // if (dailytime_status == 1){
         if dailytime_status.isEqual("1") {
            let strClosing = String(format: "%@", Dic.value(forKey: "dailytime_closing") as! CVarArg)
            let strOpening = String(format: "%@", Dic.value(forKey: "dailytime_opening") as! CVarArg)
            
            let strClosing2 = String(format: "%@", Dic.value(forKey: "dailytime_closing_2") as! CVarArg)
            let strOpening2 = String(format: "%@", Dic.value(forKey: "dailytime_opening_2") as! CVarArg)
            let strDay = String(format: "%@", Dic.value(forKey: "dailytime_day") as! CVarArg)
             if currentDay.isEqual(strDay) {
                if(strOpening < currentTime  && strClosing > currentTime){
                    
                 self.OfficeSOSCall()
                }
                else  if(strOpening2 < currentTime  && strClosing2 > currentTime){
                    self.OfficeSOSCall()
                }
                else{
                 self.PrivateSOSCall()
                }
             }
         }
         else if dailytime_status.isEqual("0") {
           
            let strDay = String(format: "%@", Dic.value(forKey: "dailytime_day") as! CVarArg)
            if currentDay.isEqual(strDay) {
                 self.PrivateSOSCall()

            }
            }
        }
    }
    func OfficeSOSCall()
    {
         let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strOffice_SOS = String(format: "%@", dictemp.value(forKey: "Office_SOS") as! CVarArg)
        let strtemp:String = String(format: "Do you want to call? %@", strOffice_SOS)
    
        let uiAlert = UIAlertController(title: "Confirmation", message: strtemp, preferredStyle: UIAlertControllerStyle.alert)
        self.present(uiAlert, animated: true, completion: nil)
        uiAlert.addAction(UIAlertAction(title: "Call", style: .default, handler: { action in
            print("Click of default button")
            if let url = URL(string: "tel://\(strOffice_SOS)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                }else{
                    UIApplication.shared.openURL(url)
                }
            }
        }))
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
            print("Click of cancel button")
        }))
    }
    func PrivateSOSCall()
    {
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strPrivate_SOS = String(format: "%@", dictemp.value(forKey: "Private_SOS") as! CVarArg)
        let strtemp:String = String(format: "Do you want to call? %@", strPrivate_SOS)
        
        let uiAlert = UIAlertController(title: "Confirmation", message: strtemp, preferredStyle: UIAlertControllerStyle.alert)
        self.present(uiAlert, animated: true, completion: nil)
        uiAlert.addAction(UIAlertAction(title: "Call", style: .default, handler: { action in
            print("Click of default button")
            if let url = URL(string: "tel://\(strPrivate_SOS)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                }else{
                    UIApplication.shared.openURL(url)
                }
            }
        }))
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
            print("Click of cancel button")
        }))
    }
}
