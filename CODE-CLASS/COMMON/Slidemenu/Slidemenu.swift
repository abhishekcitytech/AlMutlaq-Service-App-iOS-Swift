//
//  Slidemenu.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 11/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class Slidemenu: UIViewController, UITableViewDataSource, UITableViewDelegate
{
 var loadingCircle = UIView()
    @IBOutlet var viewOverall: UIView!
    @IBOutlet var viewTable: UIView!
    @IBOutlet var viewUser: UIView!
    
    @IBOutlet var imgvUser: UIImageView!
    @IBOutlet var lblUser: UILabel!
    @IBOutlet var lbladdress: UILabel!
    @IBOutlet var lblmobileno: UILabel!
    
    @IBOutlet var btnSlide: UIButton!
    
    let cellReuseIdentifier = "cell"
    @IBOutlet var tabvMenu: UITableView!
    
    var arrMSlidemenu = NSMutableArray()
    var arrMSlidemenuImage = NSMutableArray()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
      
        //----------- Single Tap and Swipe Gesture ---------------//
        let gestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(hideSlide(recognizer:)))
        viewOverall.addGestureRecognizer(gestureRecognizer)
        viewOverall.isUserInteractionEnabled = true
        gestureRecognizer.cancelsTouchesInView = false
        
        let gestureRecognizer1 = UISwipeGestureRecognizer(target: self, action: #selector(hideSlide(recognizer:)))
        gestureRecognizer1.direction = .left
        viewOverall.addGestureRecognizer(gestureRecognizer1)
        viewOverall.isUserInteractionEnabled = true
        gestureRecognizer1.cancelsTouchesInView = false
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        //print("dictemp :%@",dictemp)
        
        let strusertype = String(format: "%@", dictemp.value(forKey: "user_type") as! CVarArg)
        if(strusertype .isEqual("T"))
        {
            let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
            
            lblUser.text=dictemp.value(forKey: "customer_name") as? String
            lbladdress.text = String(format: "%@,%@,%@", (dictemp.value(forKey: "customer_street_address") as? String)!,(dictemp.value(forKey: "customer_building_no") as? String)!,(dictemp.value(forKey: "customer_flat_no") as? String)!)
            lblmobileno.text=dictemp.value(forKey: "customer_phone") as? String
            
            let strUrl = String(format: "%@", dictemp.value(forKey: "customer_profilePic") as! CVarArg)
            if(strUrl .isEqual("")){
                imgvUser.image=UIImage(named: "userprof")
            }
            else{
                self.imgvUser.backgroundColor = UIColor.white
                let imageUrl = dictemp.value(forKey: "customer_profilePic") as! String
                self.imgvUser.imageFromURL(urlString: imageUrl)
            /*    DispatchQueue.global(qos: .background).async {
                    // Background Thread
                    let imageUrl = dictemp.value(forKey: "customer_profilePic") as! String
                    let url = URL(string: imageUrl)
                    let imageData:NSData = NSData(contentsOf: url!)!
                    DispatchQueue.main.async {
                        // Run UI Updates or call completion block
                        self.imgvUser.backgroundColor = UIColor.white
                        let image = UIImage(data: imageData as Data)
                        self.imgvUser.image = image
                    }
                }*/
            }
            
            imgvUser.layer.cornerRadius=32.0
            imgvUser.layer.masksToBounds=true
            
            arrMSlidemenu = ["Home", "Book Service", "Service Status", "Register Complaint", "My Account", "SOS","About us",]
            arrMSlidemenuImage = ["home", "book_service", "service_status", "register_complaint", "my_account", "sos","sos",]
        }
        else
        {
            let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
            
            lblUser.text=dictemp.value(forKey: "customer_name") as? String
            lbladdress.text=dictemp.value(forKey: "customer_email") as? String
            lblmobileno.text=dictemp.value(forKey: "customer_phone") as? String
            
            let strUrl = String(format: "%@", dictemp.value(forKey: "customer_profilePic") as! CVarArg)
            if(strUrl .isEqual("")){
                imgvUser.image=UIImage(named: "userprof")
            }
            else{
              
                self.imgvUser.backgroundColor = UIColor.white
                let imageUrl = dictemp.value(forKey: "customer_profilePic") as! String
                 self.imgvUser.imageFromURL(urlString: imageUrl)
                
            //   self.resizeImage(image:   self.imgvUser.imageFromURL(urlString: imageUrl), targetSize: CGSize(width: 200, height: 200))
              
                
             /*   DispatchQueue.global(qos: .background).async {
                    // Background Thread
                    let imageUrl = dictemp.value(forKey: "customer_profilePic") as! String
                    let url = URL(string: imageUrl)
                    let imageData:NSData = NSData(contentsOf: url!)!
                    DispatchQueue.main.async {
                        // Run UI Updates or call completion block
                        self.imgvUser.backgroundColor = UIColor.white
                        let image = UIImage(data: imageData as Data)
                        self.imgvUser.image = image
                    }
                }*/
            }
            imgvUser.layer.cornerRadius=32.0
            imgvUser.layer.masksToBounds=true
            
            arrMSlidemenu = ["Home", "Booked Services", "Rescheduled Services", "Closed Services", "My Account","About us",]
            arrMSlidemenuImage = ["home","booked_service","rescheduled_service","closed_service","my_account","sos",]
        }
        
        tabvMenu.backgroundView=nil
        tabvMenu.backgroundColor=UIColor.clear
        tabvMenu.separatorColor=UIColor.clear
        tabvMenu.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientat ion is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
          
            newSize =  CGSize(width:size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize =   CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height:  newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
         return newImage!
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - gestureSlide method
    @objc func hideSlide(recognizer: UITapGestureRecognizer)
    {
        viewOverall.backgroundColor=UIColor.clear
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseOut], animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: -UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }, completion: { finished in
            self.view .removeFromSuperview()
            self.didMove(toParentViewController: nil)
        })
    }

    // MARK: - pressSlide method
    @IBAction func pressSlide(_ sender: Any)
    {
        viewOverall.backgroundColor=UIColor.clear
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseOut], animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: -UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }, completion: { finished in
            self.view .removeFromSuperview()
            self.didMove(toParentViewController: nil)
        })
    }
    
   
    
    // MARK: - tableView delegate & datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMSlidemenu.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
        headerView.backgroundColor=UIColor.white
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
        footerView.backgroundColor=UIColor.white
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier:cellReuseIdentifier)
        
        cell.selectionStyle=UITableViewCellSelectionStyle.gray
        cell.accessoryType = UITableViewCellAccessoryType.none
        cell.backgroundColor=UIColor.white
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let imgvicon = UIImageView(frame: CGRect(x: 15, y: 13, width: 24, height: 24))
        imgvicon.backgroundColor = UIColor.clear
        let rowimagename = "\(arrMSlidemenuImage[indexPath.row])"
        imgvicon.image = UIImage(named:rowimagename)
        cell.contentView.addSubview(imgvicon)
        
        let label = UILabel(frame: CGRect(x: imgvicon.frame.maxX+24, y: 0, width: tableView.frame.size.width/1.5, height: 50))
        label.textAlignment = .left
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.text = arrMSlidemenu[indexPath.row] as? String
        let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
            //5S
            label.font = UIFont(name: "Roboto-Regular", size: 15.0)!
        }
        else if (screenSize.height == 480.0){
            //4S
            label.font = UIFont(name: "Roboto-Regular", size: 15.0)!
        }else{
            label.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        }
        
        cell.contentView.addSubview(label)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.view.frame = CGRect(x: 0, y: 0, width: -UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.view .removeFromSuperview()
        self.didMove(toParentViewController: nil)
        
        let rowname = "\(arrMSlidemenu[indexPath.row])"
        print("rowname %@",rowname)
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        //print("dictemp :%@",dictemp)
        
        let strusertype = String(format: "%@", dictemp.value(forKey: "user_type") as! CVarArg)
        if(strusertype .isEqual("T"))
        {
            if (rowname .isEqual("Home")){
                
                OperationQueue.main.addOperation {
                    
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
                    self.navigationController?.pushViewController(obj, animated: true)
                  
                }
            }
            else if (rowname .isEqual("Book Service")){
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
            else if (rowname .isEqual("Service Status")){
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
            else if (rowname .isEqual("Register Complaint")){
                var obj = AddComplain()
                let screenSize = UIScreen.main.bounds
                if (screenSize.height == 568.0){
                    //5S
                    obj = AddComplain(nibName: "AddComplain5S", bundle: nil)
                }
                else if (screenSize.height == 480.0){
                    //5S
                    obj = AddComplain(nibName: "AddComplain4S", bundle: nil)
                }
                else if(screenSize.height == 667.0){
                    //6
                    obj = AddComplain(nibName: "AddComplain", bundle: nil)
                }
                else if(screenSize.height == 736.0){
                    // 6Plus
                    obj = AddComplain(nibName: "AddComplain6Plus", bundle: nil)
                }
                else if(screenSize.height == 812.0){
                    //x
                    obj = AddComplain(nibName: "AddComplainX", bundle: nil)
                }
                else
                {
                    obj = AddComplain(nibName: "AddComplainXSMAX", bundle: nil)
                    
                }
                self.navigationController?.pushViewController(obj, animated: true)
                
            }
            else if (rowname .isEqual("My Account"))
            {
                var obj = MyAccount()
                let screenSize = UIScreen.main.bounds
                if (screenSize.height == 568.0){
                    //5S
                    obj = MyAccount(nibName: "MyAccount5S", bundle: nil)
                }
                else if (screenSize.height == 480.0){
                    //5S
                    obj = MyAccount(nibName: "MyAccount4S", bundle: nil)
                }
                else if(screenSize.height == 667.0){
                    //6
                    obj = MyAccount(nibName: "MyAccount", bundle: nil)
                }
                else if(screenSize.height == 736.0){
                    // 6Plus
                    obj = MyAccount(nibName: "MyAccount6Plus", bundle: nil)
                }
                else if(screenSize.height == 812.0){
                    //x
                    obj = MyAccount(nibName: "MyAccountX", bundle: nil)
                }
                else
                {
                    obj = MyAccount(nibName: "MyAccountXSMAX", bundle: nil)
                    
                }
                self.navigationController?.pushViewController(obj, animated: true)
              }
            else if (rowname .isEqual("SOS"))
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
            else if (rowname .isEqual("About us"))
            {
               
                let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                    (self.navigationController?.navigationBar.frame.height ?? 0.0)
                let hh = self.navigationController?.navigationBar.frame.maxY
                if hh == -20.0 || navigationBarHeight == 64.0{
                    var obj = AboutUs()
                    obj = AboutUs(nibName: "AboutUs", bundle: nil)
                    self.navigationController?.pushViewController(obj, animated: true)
                }
                else{
                    //X
                    var obj = AboutUs()
                    obj = AboutUs(nibName: "AboutUsX", bundle: nil)
                    self.navigationController?.pushViewController(obj, animated: true)
                }
            }
        }
                
        else
        {
            if (rowname .isEqual("Home")){
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
                self.navigationController?.pushViewController(obj, animated: true)
            }
            else if (rowname .isEqual("Booked Services")){
                let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                    (self.navigationController?.navigationBar.frame.height ?? 0.0)
                let hh = self.navigationController?.navigationBar.frame.maxY
                var obj = CSTasklist()
                if hh == -20.0 || navigationBarHeight == 64.0{
               
                    obj = CSTasklist(nibName: "CSTasklist", bundle: nil)
                }
                else{
                    //X
                    obj = CSTasklist(nibName: "CSTasklistX", bundle: nil)
                }
                obj.stridentifer="Booked Services"
                obj.strvalue="0"
                self.navigationController?.pushViewController(obj, animated: true)
             
            }
            else if (rowname .isEqual("Rescheduled Services")){
                let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                    (self.navigationController?.navigationBar.frame.height ?? 0.0)
                let hh = self.navigationController?.navigationBar.frame.maxY
                var obj = CSTasklist()
                if hh == -20.0 || navigationBarHeight == 64.0{
                   obj = CSTasklist(nibName: "CSTasklist", bundle: nil)
                }
                else{
                    //X
                    obj = CSTasklist(nibName: "CSTasklistX", bundle: nil)
                }
                obj.stridentifer="Rescheduled Services"
                obj.strvalue="1"
                 self.navigationController?.pushViewController(obj, animated: true)
             
            }
            else if (rowname .isEqual("Closed Services")){
                let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                    (self.navigationController?.navigationBar.frame.height ?? 0.0)
                let hh = self.navigationController?.navigationBar.frame.maxY
                var obj = CSTasklist()
                if hh == -20.0 || navigationBarHeight == 64.0{
                    obj = CSTasklist(nibName: "CSTasklist", bundle: nil)
                }
                else{
                    //X
                    obj = CSTasklist(nibName: "CSTasklistX", bundle: nil)
                }
                obj.stridentifer="Closed Services"
                obj.strvalue="3"
                self.navigationController?.pushViewController(obj, animated: true)
            
            }
            else if (rowname .isEqual("My Account")){
           
                var obj = CSMyAccount()
                let screenSize = UIScreen.main.bounds
                if (screenSize.height == 568.0){
                    //5S
                    obj = CSMyAccount(nibName: "CSMyAccount5S", bundle: nil)
                }
                else if (screenSize.height == 480.0){
                    //5S
                    obj = CSMyAccount(nibName: "CSMyAccount4S", bundle: nil)
                }
                else if(screenSize.height == 667.0){
                    //6
                    obj = CSMyAccount(nibName: "CSMyAccount", bundle: nil)
                }
                else if(screenSize.height == 736.0){
                    // 6Plus
                    obj = CSMyAccount(nibName: "CSMyAccount6Plus", bundle: nil)
                }
                else if(screenSize.height == 812.0){
                    //x
                    obj = CSMyAccount(nibName: "CSMyAccountX", bundle: nil)
                }
                else
                {
                    obj = CSMyAccount(nibName: "CSMyAccountXSMAX", bundle: nil)
                    
                }
              
                self.navigationController?.pushViewController(obj, animated: true)
            }
            else if (rowname .isEqual("About us"))
            {
                let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                    (self.navigationController?.navigationBar.frame.height ?? 0.0)
                let hh = self.navigationController?.navigationBar.frame.maxY
                print("nav bar  : %@",hh ?? (Any).self)
                var obj = AboutUs()
                if hh == -20.0 || navigationBarHeight == 64.0{
                    obj = AboutUs(nibName: "AboutUs", bundle: nil)
                }
                else{
                    //X
                  obj = AboutUs(nibName: "AboutUsX", bundle: nil)
                }
                  self.navigationController?.pushViewController(obj, animated: true)
            }
        }
    }
    
    func OfficeSOSCall() {
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
    // MARK: - pressLogout method
    @IBAction func pressLogout(_ sender: Any)
    {
        let fcmSavedToken = UserDefaults.standard.value(forKey: "FCM_Token") as! CVarArg
        print("fcmSavedToken >>>",fcmSavedToken)
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.LogoutMethod(strauthkey: strauthkey, deviceid: fcmSavedToken as! String)
        
    }
    // MARK: -  logout Method
    func LogoutMethod(strauthkey:String, deviceid:String)
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "logout")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        let postString = "device_id=\(deviceid)"
        //print(postString)
        request.setValue(strauthkey, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                // check for fundamental networking error
                self.hideLoadingMode()
                OperationQueue.main.addOperation {
                    // self.btnLogin.isUserInteractionEnabled = true
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    self.hideLoadingMode()
                    
                    let dictemp1 = NSMutableDictionary(dictionary: json)
                    print("dictemp -> \(dictemp1)")
                    
                    let message_code =  String(format: "%@", dictemp1.value(forKey: "message_code")as! CVarArg)
                    if (message_code == "1")
                    {
                        //success
                        OperationQueue.main.addOperation {
                            print("Logout Press")
                            UserDefaults.standard.set(0, forKey: "dataNotSave")
                            UserDefaults.standard.synchronize
                            UserDefaults.standard.removeObject(forKey: "dicLogin")
                            UserDefaults.standard.synchronize
                            
                            let datanotSave = UserDefaults.standard.integer(forKey: "dataNotSave")
                            print("datanotSave",datanotSave)
                            self.navigationController?.popToRootViewController(animated: true)
                           
                        }
                    }
                    else
                    {
                         OperationQueue.main.addOperation {
                        let uiAlert = UIAlertController(title: "", message: "Something wrong.", preferredStyle: UIAlertControllerStyle.alert)
                        self.present(uiAlert, animated: true, completion: nil)
                        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            print("Click of default button")
                        }))
                        }
                    }
                }
            }
            catch {
                self.hideLoadingMode()
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    //MARK: -   Custom Spinner Method
    func showLoadingMode()
    {
        loadingCircle.removeFromSuperview()
        loadingCircle = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        loadingCircle.backgroundColor = UIColor.clear
        loadingCircle.alpha = 1.0
        
        let circle = UIView ()
        circle.backgroundColor = UIColor.white
        circle.alpha = 1.0
        
        let size = 80
        let size1 = 80
        var frame = circle.frame
        frame.size.width = CGFloat(size)
        frame.size.height = CGFloat(size1)
        
        frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
        frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
        circle.frame = frame
        
        circle.layer.cornerRadius = 40.0
        circle.layer.borderWidth = 1.0
        circle.layer.borderColor=UIColor.clear.cgColor
        circle.layer.masksToBounds = true
        
        let imgvLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        imgvLogo.backgroundColor = UIColor.clear
        imgvLogo.image = UIImage(named:"roundlogo-y")
        circle.addSubview(imgvLogo)
        
        let  animatedImageView =  UIImageView(frame: circle.bounds)
        animatedImageView.animationImages = NSArray(objects:UIImage(named: "Rolling1.png")!,
                                                    UIImage(named: "Rolling2.png")!,
                                                    UIImage(named: "Rolling3.png")!,
                                                    UIImage(named: "Rolling4.png")!,
                                                    UIImage(named: "Rolling5.png")!,
                                                    UIImage(named: "Rolling6.png")!,
                                                    UIImage(named: "Rolling7.png")!,
                                                    UIImage(named: "Rolling8.png")!,
                                                    UIImage(named: "Rolling9.png")!,
                                                    UIImage(named: "Rolling10.png")!,
                                                    UIImage(named: "Rolling11.png")!,
                                                    UIImage(named: "Rolling12.png")!,
                                                    UIImage(named: "Rolling13.png")!,
                                                    UIImage(named: "Rolling14.png")!,
                                                    UIImage(named: "Rolling15.png")!,
                                                    UIImage(named: "Rolling16.png")!,
                                                    UIImage(named: "Rolling17.png")!,
                                                    UIImage(named: "Rolling18.png")!,
                                                    UIImage(named: "Rolling19.png")!,
                                                    UIImage(named: "Rolling20.png")!,
                                                    UIImage(named: "Rolling21.png")!,
                                                    UIImage(named: "Rolling22.png")!,
                                                    UIImage(named: "Rolling23.png")!,
                                                    UIImage(named: "Rolling24.png")!,
                                                    UIImage(named: "Rolling25.png")!,
                                                    UIImage(named: "Rolling26.png")!,
                                                    UIImage(named: "Rolling27.png")!,
                                                    UIImage(named: "Rolling28.png")!,
                                                    UIImage(named: "Rolling29.png")!,
                                                    UIImage(named: "Rolling30.png")!) as? [UIImage]
        
        animatedImageView.animationDuration = 9
        animatedImageView.animationRepeatCount = 0
        animatedImageView.startAnimating()
        circle.addSubview(animatedImageView)
        circle.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        self.loadingCircle.addSubview(circle)
        self.view.addSubview(loadingCircle)
        
        
    }
    func hideLoadingMode()
    {
        OperationQueue.main.addOperation {
            self.loadingCircle.removeFromSuperview()
        }
    }
}
/* // create an actionSheet
 let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
 
 // create an action
 let firstAction: UIAlertAction = UIAlertAction(title: "Office SOS", style: .default) { action -> Void in
 self.OfficeSOSCall()
 print("First Action pressed")
 }
 
 let secondAction: UIAlertAction = UIAlertAction(title: "Private SOS", style: .default) { action -> Void in
 self.PrivateSOSCall()
 print("Second Action pressed")
 }
 
 let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
 
 // add actions
 actionSheetController.addAction(firstAction)
 actionSheetController.addAction(secondAction)
 actionSheetController.addAction(cancelAction)
 
 // present an actionSheet...
 present(actionSheetController, animated: true, completion: nil)
 */

/* let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
 let strSosnumber = String(format: "%@", dictemp.value(forKey: "SOS_number") as! CVarArg)
 
 let strtemp:String = String(format: "Do you want to call? %@", strSosnumber)
 
 let uiAlert = UIAlertController(title: "Confirmation", message: strtemp, preferredStyle: UIAlertControllerStyle.alert)
 self.present(uiAlert, animated: true, completion: nil)
 uiAlert.addAction(UIAlertAction(title: "Call", style: .default, handler: { action in
 print("Click of default button")
 if let url = URL(string: "tel://\(strSosnumber)"), UIApplication.shared.canOpenURL(url) {
 if #available(iOS 10, *) {
 UIApplication.shared.open(url)
 }else{
 UIApplication.shared.openURL(url)
 }
 }
 }))
 uiAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
 print("Click of cancel button")
 }))*/
