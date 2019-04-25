//
//  MyAccount.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 12/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class MyAccount: UIViewController,UITextFieldDelegate
{
    var loadingCircle = UIView()
     @IBOutlet var btnHeader: UIButton!
     @IBOutlet var viewtop: UIView!
    @IBOutlet var scrollOverAll: UIScrollView!
     @IBOutlet var viewProfile: UIView!
    @IBOutlet var imgvProfile: UIImageView!
   
   
    
    @IBOutlet var txtFullname: UITextField!
    @IBOutlet var txtEmailaddress: UITextField!
    @IBOutlet var txtMobileno: UITextField!
    @IBOutlet var txtBuildingno: UITextField!
    @IBOutlet var txtAddress: UITextField!
    
    @IBOutlet var viewAccountstatus: UIView!
    @IBOutlet var lblAcountstatusHeader: UILabel!
    
    @IBOutlet var lblStatus: UILabel!
   // @IBOutlet var imgStatus: UIImageView!
    
    @IBOutlet var viewAgreementstatus: UIView!
    @IBOutlet var lblAgreementstatusHeader: UILabel!
    @IBOutlet var lblDate: UILabel!
    
    @IBOutlet var viewChangepassword: UIView!
    @IBOutlet var btnChangepassword: UIButton!
    @IBOutlet var imgChangepasswordarrow: UIImageView!
    
    
    var mainBg = UIView()
    var bgVwBox = UIView()
    var btnSubmit = UIButton()
    var btnCross = UIButton()
    var txtNewPassword =  UITextField()
    var txtConfirmPassword =  UITextField()
    
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
       // navigationController?.navigationBar.barTintColor = UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0)
        self.setupBorder()
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
       
        let strusertype = String(format: "%@", dictemp.value(forKey: "user_type") as! CVarArg)
        if(strusertype .isEqual("T"))
        {
            txtFullname.text=String(format: "%@", dictemp.value(forKey: "customer_name") as! CVarArg)
            txtEmailaddress.text=String(format: "%@", dictemp.value(forKey: "customer_email") as! CVarArg)
            txtMobileno.text=String(format: "%@", dictemp.value(forKey: "customer_phone") as! CVarArg)
            txtBuildingno.text=String(format: "Building - %@, Flat- %@", dictemp.value(forKey: "customer_building_no")as! CVarArg,dictemp.value(forKey: "customer_flat_no") as! CVarArg)
            txtAddress.text=String(format: "%@", dictemp.value(forKey: "customer_street_address") as! CVarArg)
            
            let strusertype = String(format: "%@", dictemp.value(forKey: "customer_account_status") as! CVarArg)
            if(strusertype .isEqual("Y")){
                lblAcountstatusHeader.text="  Account status"
                lblStatus.text = "Active"
                lblStatus.textColor=UIColor.white
                lblStatus.backgroundColor=UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0)
                //imgStatus.image = UIImage(named:"greenmark.png")
            }else{
                lblAcountstatusHeader.text="  Account status"
                lblStatus.textColor=UIColor.white
                lblStatus.text = "Inactive"
                lblStatus.backgroundColor=UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0)
                //imgStatus.image = UIImage(named:"rednmark.png")
            }
           
            
            lblAgreementstatusHeader.text="  Agreement expired on"
            lblDate.text=String(format: "%@", dictemp.value(forKey: "customer_Expiry_Date") as! CVarArg)
            
            btnChangepassword.setTitle("  Change Password", for: .normal)
            btnChangepassword.contentHorizontalAlignment = .left
        
            imgChangepasswordarrow.image = UIImage(named:"next")
            
            let strUrl = String(format: "%@", dictemp.value(forKey: "customer_profilePic") as! CVarArg)
            if(strUrl .isEqual("")){
                imgvProfile.image=UIImage(named: "userprof")
            }
            else{
                DispatchQueue.global(qos: .background).async {
                    // Background Thread
                    let imageUrl = dictemp.value(forKey: "customer_profilePic") as! String
                    let url = URL(string: imageUrl)
                    let imageData:NSData = NSData(contentsOf: url!)!
                    DispatchQueue.main.async {
                        // Run UI Updates or call completion block
                        self.imgvProfile.backgroundColor = UIColor.white
                        let image = UIImage(data: imageData as Data)
                        self.imgvProfile.image = image
                    }
                }
            }
            imgvProfile.layer.borderWidth = 1.0
            imgvProfile.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
            imgvProfile.layer.cornerRadius = 32.0
            imgvProfile.layer.masksToBounds = true
        }
        else{
        }
         scrollOverAll.contentSize = CGSize(width: scrollOverAll.frame.size.width, height: viewChangepassword.frame.maxY+100)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Textfield Border Setup Method
    func setupBorder() -> Void
    {
        
   /*     viewtop.layer.shadowColor = UIColor.lightGray.cgColor
        viewtop.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewtop.layer.shadowRadius = 0.0
        viewtop.layer.shadowOpacity = 2.0
        viewtop.layer.masksToBounds = false*/
        
        viewProfile.layer.borderWidth = 1.0
        viewProfile.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        viewProfile.layer.cornerRadius = 4.0
        viewProfile.layer.masksToBounds = true
        
        
        viewAccountstatus.layer.borderWidth = 1.0
        viewAccountstatus.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        viewAccountstatus.layer.cornerRadius = 4.0
        viewAccountstatus.layer.masksToBounds = true
        
        viewAgreementstatus.layer.borderWidth = 1.0
        viewAgreementstatus.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        viewAgreementstatus.layer.cornerRadius = 4.0
        viewAgreementstatus.layer.masksToBounds = true
        
        viewChangepassword.layer.borderWidth = 1.0
        viewChangepassword.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        viewChangepassword.layer.cornerRadius = 4.0
        viewChangepassword.layer.masksToBounds = true
        
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
    
    // MARK: - pressChangepassword Method
    @IBAction func pressChangepassword(_ sender: Any) {
        DispatchQueue.main.async {
            self.viewImageBigVW()
        }
    }
    
    // MARK: -  Password change pop up Method
    func viewImageBigVW() -> Void{
        
        self.mainBg = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        self.mainBg.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        
        bgVwBox = UIView(frame: CGRect(x: 20, y: 0, width: self.mainBg.frame.size.width - 40, height:210))
        bgVwBox.center = self.mainBg.center
        bgVwBox.backgroundColor=UIColor.white
        bgVwBox.layer.cornerRadius = 6.0
        bgVwBox.layer.masksToBounds = true
        self.mainBg.addSubview(bgVwBox)
       
   
        btnCross   = UIButton(type: UIButtonType.custom) as UIButton
       btnCross.frame = CGRect(x: bgVwBox.frame.width-7, y: bgVwBox.frame.minY-15, width:35, height: 35)
        btnCross.backgroundColor = UIColor.clear
        btnCross.setImage(UIImage(named: "cross1"), for: .normal)
        btnCross.addTarget(self, action: #selector(self.pressCross(_:)), for: .touchUpInside)
        btnCross.clipsToBounds = true
        self.mainBg.addSubview(btnCross)
        
        txtNewPassword =  UITextField(frame: CGRect(x: 30, y: 40, width: bgVwBox.frame.width-60, height: 44))
        txtNewPassword.textAlignment = NSTextAlignment.left
        txtNewPassword.backgroundColor = UIColor.white
        txtNewPassword.delegate=self
        txtNewPassword.placeholder="Enter new password."
        txtNewPassword.textColor=UIColor.black
        txtNewPassword.isSecureTextEntry=true
        txtNewPassword.font = UIFont(name: "Roboto-Regular", size: 15.0)!
        txtNewPassword.layer.borderColor=UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        txtNewPassword.layer.borderWidth=1.0
        txtNewPassword.layer.cornerRadius=4.0
        txtNewPassword.layer.masksToBounds = true
        bgVwBox.addSubview(txtNewPassword)
        
        txtConfirmPassword =  UITextField(frame: CGRect(x: 30, y:  txtNewPassword.frame.maxY+15, width: bgVwBox.frame.width-60, height: 44))
        txtConfirmPassword.textAlignment = NSTextAlignment.left
        txtConfirmPassword.backgroundColor = UIColor.white
        txtConfirmPassword.delegate=self
        txtConfirmPassword.placeholder="Enter confirm password."
        txtConfirmPassword.textColor=UIColor.black
        txtConfirmPassword.isSecureTextEntry=true
        txtConfirmPassword.font = UIFont(name: "Roboto-Regular", size: 15.0)!
        txtConfirmPassword.layer.borderColor=UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        txtConfirmPassword.layer.borderWidth=1.0
        txtConfirmPassword.layer.cornerRadius=4.0
        txtConfirmPassword.layer.masksToBounds = true
        bgVwBox.addSubview(txtConfirmPassword)
        
        btnSubmit   = UIButton(type: UIButtonType.custom) as UIButton
        btnSubmit.frame = CGRect(x: 0, y: txtConfirmPassword.frame.maxY+20, width: bgVwBox.frame.size.width, height: 50)
        btnSubmit.backgroundColor = UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0)
        btnSubmit.setTitle("Submit", for: .normal)
        btnSubmit.setTitleColor(UIColor.white, for: .normal)
        btnSubmit.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        btnSubmit.addTarget(self, action: #selector(self.pressSubmit(_:)), for: .touchUpInside)
        bgVwBox.addSubview(btnSubmit)
        
        self.view.addSubview(mainBg)
    }
    @IBAction func pressCross(_ sender: Any) {
        DispatchQueue.main.async {
            self.mainBg.removeFromSuperview()
        }
    }
    @IBAction func pressSubmit(_ sender: Any) {
        
        if (txtNewPassword.text==""){
            let uiAlert = UIAlertController(title: "", message: "Please enter new password.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
            }))
        }
      else if (txtConfirmPassword.text==""){
            let uiAlert = UIAlertController(title: "", message: "Please enter Confirm password.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
            }))
        }
         else if !(txtNewPassword.text!.isEqual(txtConfirmPassword.text!)){
            let uiAlert = UIAlertController(title: "", message: "Confirm password does not match.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
            }))
        }
        else{
            
           let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
            let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
            self.passwordChangeMethod(strauthkey: strauthkey, newPassword: txtNewPassword.text!, confirmpasword: txtConfirmPassword.text!)
        }
    }
    
    func passwordChangeMethod(strauthkey:String, newPassword:String, confirmpasword:String)
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "reset_password")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        let postString = "password=\(txtNewPassword.text!)&confirm_password=\(txtConfirmPassword.text!)"
        //print(postString)
        request.setValue(strauthkey, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                // check for fundamental networking error
                self.hideLoadingMode()
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    self.hideLoadingMode()
                    let dictemp = NSMutableDictionary(dictionary: json)
                    print("dictemp -> \(dictemp)")
                    
                    let message_code:Int = dictemp.value(forKey: "message_code") as! Int
                    if (message_code == 1)
                    {
                        //success

                     let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
                        print("main  -> \(dictemp)")
                        let myMutableDict: NSMutableDictionary = NSMutableDictionary(dictionary: dictemp)
                        myMutableDict.setValue(newPassword, forKey: "password")
                        UserDefaults.standard.set(myMutableDict, forKey: "dicLogin")
                        UserDefaults.standard.synchronize()
                        
                        let dictemp1 = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
                        print(" 2nd main  -> \(dictemp1)")
                        DispatchQueue.main.async {
                             self.hideLoadingMode()
                            self.mainBg.removeFromSuperview()
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
    
    // MARK: - Textfield Delegates Method
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
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
