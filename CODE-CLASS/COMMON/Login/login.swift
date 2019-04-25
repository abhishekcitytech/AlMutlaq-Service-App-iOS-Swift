//
//  login.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 03/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit
class login: ViewController,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate
{
    @IBOutlet var toplabel: UILabel!
    @IBOutlet var imgvLogo: UIImageView!
    
    @IBOutlet var lblUsr: UILabel!
    @IBOutlet var lblPwd: UILabel!
    
    @IBOutlet var viewSignin: UIView!
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!

    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnForgotPassword: UIButton!
    
    var loadingCircle = UIView()
    var dicLogin = NSMutableDictionary()
    
    var arrTemp = NSMutableArray()
    
    var viewForgotPasswordAll = UIView()
    var viewForgotPasswordBox = UIView()
    var scrollForgot  = UIScrollView()
    var txtForgotEmail = UITextField()
     var btnCross = UIButton()
    
    //for smilly
    var arrMTime = NSMutableArray()
    var arrMParcentageButton = NSMutableArray()
    var myView = UIView()
    var viewWorkStatus = UIView()
    var arrmPercentage = NSMutableArray()
    
    var arrMSmiley = NSMutableArray()
    var SmileyVW = UIView()
    var myViewStar = UIView()
    var myView1 = UIView()

    var buttonStar1 = UIButton()
    var buttonStar2 = UIButton()
    var buttonStar3 = UIButton()
    var buttonStar4 = UIButton()
    var buttonStar5 = UIButton()
  
    var btnSmiley1 = UIButton()
    var btnSmiley2 = UIButton()
    var btnSmiley3 = UIButton()
    var txtNoteSmiley = UITextView()
    
    var deactivatedVW = UIView()
    var activatedVW = UIView()
    var strDeactivatedNote = NSString()
    
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
        let hh = self.navigationController?.navigationBar.frame.maxY
         print("nav bar  : %@",hh ?? (Any).self)
        let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        print("nav bar  : %@",navigationBarHeight )
        self.setupborder()
        
        let value = UserDefaults.standard.integer(forKey: "tutoriallaunch")
        let datanotSave = UserDefaults.standard.integer(forKey: "dataNotSave")
        print("datanotSave",datanotSave)
        if (value == 0)
        {
            print("open tutorial")
            var obj = Tutorials()
            obj = Tutorials(nibName: "Tutorials", bundle: nil)
           self.navigationController?.pushViewController(obj, animated: true)
         
        }
        else
        {
            print("not open tutorial")
            if(datanotSave == 0){
                // data not save in UserDefaults
            }
            else
            {
                let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
                let username = dictemp.value(forKey: "username") as! NSString
                if(username.isEqual(""))
                {
                    txtUsername.text = ""
                }
                else
                {
                    txtUsername.text = dictemp.value(forKey: "username") as! NSString as String
                }
                let password = dictemp.value(forKey: "password") as! NSString
                if(password.isEqual(""))
                {
                    txtPassword.text = ""
                }
                else
                {
                    txtPassword.text = dictemp.value(forKey: "password") as! NSString as String
                }

                if (dictemp.count > 0)
                {
                    let strforcechangepassword = String(format: "%@", dictemp.value(forKey: "forcechangepassword") as! CVarArg)
                    if strforcechangepassword == "1"
                    {
                        let dicUserDetails = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
                        let strusertype = String(format: "%@", dicUserDetails.value(forKey: "user_type") as! CVarArg)
                        print("strusertype -> \(strusertype)")
                        if(strusertype .isEqual("T"))
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
                            self.navigationController?.pushViewController(obj, animated: true)
                        }
                        else if(strusertype .isEqual("S"))
                        {
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
                    }
                    else
                    {
                        let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                            (self.navigationController?.navigationBar.frame.height ?? 0.0)
                        let hh = self.navigationController?.navigationBar.frame.maxY
                        var obj = ForecChangePassword()
                       
                          if hh == -20.0 || navigationBarHeight == 64.0{
                            obj = ForecChangePassword(nibName: "ForecChangePassword", bundle: nil)
                        }
                        else{
                            //X
                            obj = ForecChangePassword(nibName: "ForecChangePasswordX", bundle: nil)
                        }
                        self.navigationController?.pushViewController(obj, animated: true)
                    }
                    }
                }
            }
        }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TextView Delegates Method
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool
    {
        if txtNoteSmiley.text.isEqual(" Note") && (txtNoteSmiley.textColor?.isEqual(UIColor.lightGray))!
        {
            txtNoteSmiley.text = ""
            txtNoteSmiley.textColor = UIColor.black
        }
        return true;
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool{
        if (textView == txtNoteSmiley) {
           // scrollLeave.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        return true;
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
    }
    func textViewDidEndEditing(_ textView: UITextView){
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView){
    }
    func textViewDidChangeSelection(_ textView: UITextView){
    }
    func keyboardWillBeHidden(notification: NSNotification) {
        
        if( txtNoteSmiley.text.count == 0){
            txtNoteSmiley.textColor = UIColor.lightGray
            txtNoteSmiley.text = " Note"
        }
    }
    
    //MARK: - Setup Border stye
    func setupborder() -> Void
    {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(red: 130/255, green: 130/255, blue: 128/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: txtUsername.frame.size.height - width, width: txtUsername.frame.size.width, height: txtUsername.frame.size.height)
        border.borderWidth = width
        txtUsername.layer.addSublayer(border)
        txtUsername.layer.masksToBounds = true
        txtUsername.attributedPlaceholder = NSAttributedString(string: "email",attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        let border1 = CALayer()
        let width1 = CGFloat(0.5)
        border1.borderColor = UIColor(red: 130/255, green: 130/255, blue: 128/255, alpha: 1.0).cgColor
        border1.frame = CGRect(x: 0, y: txtPassword.frame.size.height - width1, width: txtPassword.frame.size.width, height: txtPassword.frame.size.height)
        border1.borderWidth = width1
        txtPassword.layer.addSublayer(border1)
        txtPassword.layer.masksToBounds = true
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        let border2 = CALayer()
        let width2 = CGFloat(0.5)
        border2.borderColor = UIColor(red: 130/255, green: 130/255, blue: 128/255, alpha: 1.0).cgColor
        border2.frame = CGRect(x: 0, y: lblUsr.frame.size.height - width2, width: lblUsr.frame.size.width, height: lblUsr.frame.size.height)
        border2.borderWidth = width2
        lblUsr.layer.addSublayer(border2)
        lblUsr.layer.masksToBounds = true
        
        let border3 = CALayer()
        let width3 = CGFloat(0.5)
        border3.borderColor = UIColor(red: 130/255, green: 130/255, blue: 128/255, alpha: 1.0).cgColor
        border3.frame = CGRect(x: 0, y: lblPwd.frame.size.height - width3, width: lblPwd.frame.size.width, height: lblPwd.frame.size.height)
        border3.borderWidth = width3
        lblPwd.layer.addSublayer(border3)
        lblPwd.layer.masksToBounds = true
        
        btnLogin.layer.cornerRadius = 4.0
        btnLogin.layer.masksToBounds = true
    }
    
    // MARK: - Textfield Delegates Method
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEqual(txtForgotEmail) {
            let screenSize = UIScreen.main.bounds
            if (screenSize.height == 480.0){
                //4S
                self.scrollForgot.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y+60), animated: true)
            }
            else if (screenSize.height == 568.0){
                //5S
                self.scrollForgot.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y+40), animated: true)
            }
            else{
                self.scrollForgot.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y ), animated: true)
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.isEqual(txtForgotEmail) {
            self.scrollForgot.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
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
    
    // MARK: - pressLogin method
    @IBAction func pressLogin(_ sender: Any)
    {
        if (txtUsername.text=="")
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter valid email.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
       else if (txtPassword.text=="")
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter valid password.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            txtUsername.resignFirstResponder();
            txtPassword.resignFirstResponder();
         //   let deviceID = UIDevice.current.identifierForVendor!.uuidString
             //   OperationQueue.main.addOperation {
            let fcmSavedToken = UserDefaults.standard.value(forKey: "FCM_Token") as! CVarArg
               print("fcmSavedToken >>>",fcmSavedToken)
                    self.loginMethod(username: self.txtUsername.text!, pasword: self.txtPassword.text!, deviceType: "ios", deviceId: fcmSavedToken as! String)
           // }
           
        }
    }
    
   // MARK: - login POST method
    func loginMethod(username:String, pasword:String , deviceType:String, deviceId:String)
    {
        
      
        //btnLogin.isUserInteractionEnabled = false
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "login")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(txtUsername.text!)&password=\(txtPassword.text!)&device_type=\(deviceType)&device_id=\(deviceId)"
        print("postString >>>",postString)
        //request.setValue("", forHTTPHeaderField: "Authorization")
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
                
                OperationQueue.main.addOperation {
                   // self.btnLogin.isUserInteractionEnabled = true
                }
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    
                    
                    let dictemp = NSMutableDictionary(dictionary: json)
                    print("dictemp -> \(dictemp)")
                 
                    let message_code =  String(format: "%@", dictemp.value(forKey: "message_code")as! CVarArg)
                    if (message_code == "1")
                    {
                        //success
                        let dictemp1 :NSDictionary =  json.value(forKey: "data") as! NSDictionary
                        self.dicLogin = NSMutableDictionary(dictionary: dictemp1)
                        print("dicLogin -> \(self.dicLogin)")
                        self.dicLogin.setValue(username, forKey: "username")
                        self.dicLogin.setValue(pasword, forKey: "password")
                        
                        UserDefaults.standard.set(self.dicLogin, forKey: "dicLogin")
                        UserDefaults.standard.synchronize()
                        
                         UserDefaults.standard.set(1, forKey: "dataNotSave")
                         UserDefaults.standard.synchronize()
        
                        let strforcechangepassword = String(format: "%@", dictemp1.value(forKey: "forcechangepassword") as! CVarArg)
                        
                        if strforcechangepassword == "1"
                        {
                             OperationQueue.main.addOperation {
                                
                                let dicUserDetails = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
                                let strusertype = String(format: "%@", dicUserDetails.value(forKey: "user_type") as! CVarArg)
                                print("strusertype -> \(strusertype)")
                                if(strusertype .isEqual("T"))
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
                                    self.navigationController?.pushViewController(obj, animated: true)
                                }
                                else if(strusertype .isEqual("S"))
                                {
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
                            }
                            self.hideLoadingMode()
                        }
                        else
                        {
                            OperationQueue.main.addOperation {
                                let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                                    (self.navigationController?.navigationBar.frame.height ?? 0.0)
                                let hh = self.navigationController?.navigationBar.frame.maxY
                                var obj = ForecChangePassword()
                                if hh == -20.0 || navigationBarHeight == 64.0{
                                   obj = ForecChangePassword(nibName: "ForecChangePassword", bundle: nil)
                                   
                                }
                                else{
                                    //X
                                    obj = ForecChangePassword(nibName: "ForecChangePasswordX", bundle: nil)
                                }
                                  self.navigationController?.pushViewController(obj, animated: true)
                            }
                        }
                    }
                    else  if (message_code == "2")
                    {
                        // Deactivate
                          self.hideLoadingMode()
                          OperationQueue.main.addOperation {
                           
                            self.strDeactivatedNote =   dictemp.value(forKey: "message") as! NSString
                            var obj = DeactivatedNote()
                            let screenSize = UIScreen.main.bounds
                            if (screenSize.height == 568.0){
                                //5S
                                obj = DeactivatedNote(nibName: "DeactivatedNote5S", bundle: nil)
                            }
                            else if (screenSize.height == 480.0){
                                //5S
                                obj = DeactivatedNote(nibName: "DeactivatedNote4S", bundle: nil)
                            }
                            else if(screenSize.height == 667.0){
                                //6
                                obj = DeactivatedNote(nibName: "DeactivatedNote", bundle: nil)
                            }
                            else if(screenSize.height == 736.0){
                                // 6Plus
                                obj = DeactivatedNote(nibName: "DeactivatedNote6Plus", bundle: nil)
                            }
                            else if(screenSize.height == 812.0){
                                //x
                                obj = DeactivatedNote(nibName: "DeactivatedNoteX", bundle: nil)
                            }
                            else
                            {
                                obj = DeactivatedNote(nibName: "DeactivatedNoteXSMAX", bundle: nil)
                            }
                            obj.strMessage =  self.strDeactivatedNote
                            self.navigationController?.pushViewController(obj, animated: true)
                         }
                       
                    }
                    else  if (message_code == "0")
                    {
                        //invalid user
                        OperationQueue.main.addOperation {
                            let uiAlert = UIAlertController(title: "", message: "Please enter valid email or password.", preferredStyle: UIAlertControllerStyle.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                    else
                    {
                        //fail
                        OperationQueue.main.addOperation {
                        let uiAlert = UIAlertController(title: "", message: "Please enter valid email or password.", preferredStyle: UIAlertControllerStyle.alert)
                        self.present(uiAlert, animated: true, completion: nil)
                        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            print("Click of default button")
                        }))
                        }
                    }
                    self.hideLoadingMode()
                }
            }
            catch {
                self.hideLoadingMode()
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
 
    // MARK: - pressForgotpassword method
    @IBAction func pressForgotpassword(_ sender: Any)
    {
        self.forgotpasswordPopUpView()
    }
    func forgotpasswordPopUpView() -> Void
    {
         self.viewForgotPasswordAll = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
         self.viewForgotPasswordAll.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        
        self.scrollForgot  = UIScrollView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-50))
        self.scrollForgot.delegate = self
        self.scrollForgot.center = self.viewForgotPasswordAll.center
        self.scrollForgot.contentSize = CGSize(width: scrollForgot.frame.size.width, height: scrollForgot.frame.size.height)
        self.scrollForgot.backgroundColor = UIColor.clear
        self.viewForgotPasswordAll.addSubview(self.scrollForgot)
        
        viewForgotPasswordBox = UIView(frame: CGRect(x:20, y: 0, width:  self.viewForgotPasswordAll.frame.size.width - 40, height:140))
        viewForgotPasswordBox.center = self.scrollForgot.center
        viewForgotPasswordBox.backgroundColor=UIColor.white
        viewForgotPasswordBox.layer.cornerRadius = 6.0
        viewForgotPasswordBox.layer.masksToBounds = true
        self.scrollForgot.addSubview(viewForgotPasswordBox)
        
        btnCross   = UIButton(type: UIButtonType.custom) as UIButton
        btnCross.frame = CGRect(x: viewForgotPasswordBox.frame.width-7, y: viewForgotPasswordBox.frame.minY-15, width:35, height: 35)
        btnCross.backgroundColor = UIColor.clear
        btnCross.setImage(UIImage(named: "cross1"), for: .normal)
         btnCross.addTarget(self, action: #selector(pressCancelFP), for: .touchUpInside)
        btnCross.clipsToBounds = true
        self.scrollForgot.addSubview(btnCross)
        
        
        txtForgotEmail = UITextField(frame: CGRect(x: 10, y: 30, width: viewForgotPasswordBox.frame.size.width - 20, height: 44));
        txtForgotEmail.textAlignment = NSTextAlignment.center
        txtForgotEmail.backgroundColor = UIColor.white
        txtForgotEmail.delegate=self
        txtForgotEmail.autocapitalizationType = .none
        txtForgotEmail.placeholder="Email address"
        txtForgotEmail.textColor=UIColor.black
        txtForgotEmail.font = UIFont(name: "Roboto-Regular", size: 15.0)!
        txtForgotEmail.layer.borderColor=UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        txtForgotEmail.layer.borderWidth=1.0
        txtForgotEmail.layer.cornerRadius=4.0
        txtForgotEmail.layer.masksToBounds = true
        viewForgotPasswordBox.addSubview(txtForgotEmail)
        
        let btnSubmit   = UIButton(type: UIButtonType.custom) as UIButton
        btnSubmit.frame = CGRect(x: 0, y: txtForgotEmail.frame.maxY+20, width: viewForgotPasswordBox.frame.size.width, height: 50)
        btnSubmit.backgroundColor = UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0)
        btnSubmit.setTitle("Submit", for: .normal)
        btnSubmit.setTitleColor(UIColor.white, for: .normal)
        btnSubmit.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        btnSubmit.addTarget(self, action: #selector(pressSubmitFP), for: .touchUpInside)
        viewForgotPasswordBox.addSubview(btnSubmit)
    
        self.view.addSubview(self.viewForgotPasswordAll)
    }
    @objc func pressCancelFP()
    {
        self.viewForgotPasswordAll.removeFromSuperview()
    }
    @objc func pressSubmitFP()
    {
        if (txtForgotEmail.text == "")
        {
              OperationQueue.main.addOperation {
            let uiAlert = UIAlertController(title: "", message: "Please enter email.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
            }
        }
        else if  isValidEmail(email: txtForgotEmail.text) == false {
             OperationQueue.main.addOperation {
            let uiAlert = UIAlertController(title: "", message: " Please enter valid email.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        }
        else
        {
          //  self.viewForgotPasswordAll.removeFromSuperview()
            self.forgotPasswordMethod(mailId: txtForgotEmail.text!)
        }
    }
    // MARK: - isValidEmail method
    func isValidEmail(email:String?) -> Bool {
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    func forgotPasswordMethod(mailId:String){
      self.showLoadingMode()
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "forgot_password")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        let postString = "email=\(txtForgotEmail.text!)"
     
        print("postString  ->>",postString)
      //  request.setValue(strauthkey, forHTTPHeaderField: "Authorization")
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
                 
                    if (message_code == 1){
                        //error
                        OperationQueue.main.addOperation {
                              self.hideLoadingMode()
                            self.viewForgotPasswordAll.removeFromSuperview()
                              let message =  String(format: "%@", dictemp.value(forKey: "message")as! CVarArg)
                            let uiAlert = UIAlertController(title: "", message:message, preferredStyle: UIAlertControllerStyle.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                   else if (message_code == 0){
                        //error
                          OperationQueue.main.addOperation {
                            self.viewForgotPasswordAll.removeFromSuperview()
                        let message =  String(format: "%@", dictemp.value(forKey: "message")as! CVarArg)
                        let uiAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
                        self.present(uiAlert, animated: true, completion: nil)
                        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            print("Click of default button")
                        }))
                    }
                    }
                    else{
                        //fail
                        OperationQueue.main.addOperation {
                            self.viewForgotPasswordAll.removeFromSuperview()
                            let message =  String(format: "%@", dictemp.value(forKey: "message")as! CVarArg)
                            let uiAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
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
  /*  func showLoadingMode()
    {
        loadingCircle = UIView ()
        loadingCircle.backgroundColor = UIColor.white
        loadingCircle.alpha = 1.0
        
        let size = 80
        let size1 = 80
        var frame = loadingCircle.frame
        frame.size.width = CGFloat(size)
        frame.size.height = CGFloat(size1)
        
        frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
        frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
        loadingCircle.frame = frame
        
        loadingCircle.layer.cornerRadius = 40.0
        loadingCircle.layer.borderWidth = 1.0
        loadingCircle.layer.borderColor=UIColor.clear.cgColor
        loadingCircle.layer.masksToBounds = true
        
        let imgvLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        imgvLogo.backgroundColor = UIColor.clear
        imgvLogo.image = UIImage(named:"roundlogo-y")
        loadingCircle.addSubview(imgvLogo)
        
        let  animatedImageView =  UIImageView(frame: loadingCircle.bounds)
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
        loadingCircle.addSubview(animatedImageView)
        loadingCircle.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        self.view.addSubview(loadingCircle)
    }
    func hideLoadingMode()
    {
        OperationQueue.main.addOperation {
            self.loadingCircle.removeFromSuperview()
        }
    }*/
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
    // MARK: - Deactivated PopUp View method
    func deactivetedUpView() -> Void
    {
        self.deactivatedVW = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        self.deactivatedVW.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        
        activatedVW = UIView(frame: CGRect(x: 0, y: 0, width: self.deactivatedVW.frame.size.width , height:self.deactivatedVW.frame.size.height))
        activatedVW.center = self.deactivatedVW.center
        activatedVW.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        activatedVW.layer.cornerRadius = 6.0
        activatedVW.layer.masksToBounds = true
        self.deactivatedVW.addSubview(activatedVW)
        
        let imgvicon = UIImageView(frame: CGRect(x:(activatedVW.frame.maxX/2-20), y:activatedVW.frame.midY-150, width: 40, height: 40))
        imgvicon.image = UIImage(named:"deactivated")
        imgvicon.backgroundColor = UIColor.clear
        activatedVW.addSubview(imgvicon)
        
        let label1 = UILabel(frame: CGRect(x: 10, y: imgvicon.frame.maxY+15, width: activatedVW.frame.size.width, height: 20))
        label1.textAlignment = .center
        label1.textColor = UIColor.white
        label1.backgroundColor = UIColor.clear
        label1.text = "Account deactivated"
        label1.font = UIFont(name: "Roboto-Regular", size: 25.0)!
        activatedVW.addSubview(label1)
        
        let lblMessage = UILabel(frame: CGRect(x: 20, y: label1.frame.maxY+15, width: activatedVW.frame.size.width-40, height: 180))
        lblMessage.textAlignment = .center
        lblMessage.numberOfLines=15
        lblMessage.textColor = UIColor.white
        lblMessage.backgroundColor = UIColor.clear
        lblMessage.text = strDeactivatedNote as String
        lblMessage.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        
        lblMessage.layer.borderColor=UIColor.white.cgColor
        lblMessage.layer.borderWidth=0.8
        lblMessage.layer.cornerRadius = 4.0
        lblMessage.layer.masksToBounds = true
        activatedVW.addSubview(lblMessage)
        
        let buttonCancel = UIButton(frame: CGRect(x: (activatedVW.frame.maxX/2-40), y: activatedVW.frame.size.height-100, width: 80, height: 80))//
        buttonCancel.tag=1
        buttonCancel.setImage(UIImage(named: "crosspage"), for: .normal)
        buttonCancel.addTarget(self, action: #selector(pressCancelDeactivate), for: .touchUpInside)
        buttonCancel.layer.cornerRadius = 4.0
        buttonCancel.layer.masksToBounds = true
        activatedVW.addSubview(buttonCancel)
        
        self.view.addSubview(self.deactivatedVW)
    }
    @objc func pressCancelDeactivate()
    {
        self.deactivatedVW.removeFromSuperview()
    }
}
