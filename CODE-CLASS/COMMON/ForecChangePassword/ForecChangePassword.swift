//
//  ForecChangePassword.swift
//  AlMutlaqRealEstate
//
//  Created by Sabnam Nasrin on 17/12/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class ForecChangePassword: UIViewController ,UITextFieldDelegate{
    
    var loadingCircle = UIView()
    
    @IBOutlet var vwPassword: UIView!
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var txtNewPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    
    @IBOutlet var btnSubmit: UIButton!
    
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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(red: 130/255, green: 130/255, blue: 128/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: txtNewPassword.frame.size.height - width, width: txtNewPassword.frame.size.width, height: txtNewPassword.frame.size.height)
        border.borderWidth = width
        txtNewPassword.layer.addSublayer(border)
        txtNewPassword.layer.masksToBounds = true
        txtNewPassword.attributedPlaceholder = NSAttributedString(string: "New Password",attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        let border1 = CALayer()
        let width1 = CGFloat(0.5)
        border1.borderColor = UIColor(red: 130/255, green: 130/255, blue: 128/255, alpha: 1.0).cgColor
        border1.frame = CGRect(x: 0, y: txtConfirmPassword.frame.size.height - width1, width: txtConfirmPassword.frame.size.width, height: txtConfirmPassword.frame.size.height)
        border1.borderWidth = width1
        txtConfirmPassword.layer.addSublayer(border1)
        txtConfirmPassword.layer.masksToBounds = true
        txtConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm New Password",attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
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
    
    
    // MARK: - Submit Method
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
            self.ForceChangepasswordMethod(strauthkey: strauthkey, newPassword: txtNewPassword.text!, confirmpasword: txtConfirmPassword.text!)
        }
    }
    
    // MARK: -  Force Changepassword Method
    func ForceChangepasswordMethod(strauthkey:String, newPassword:String, confirmpasword:String)
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "force_change_password")
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
                    
                    let message_code:Int = dictemp1.value(forKey: "message_code") as! Int
                    if (message_code == 1)
                    {
                        //success
                        OperationQueue.main.addOperation {
                            
                            let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
                            print("main  -> \(dictemp)")
                            let myMutableDict: NSMutableDictionary = NSMutableDictionary(dictionary: dictemp)
                            myMutableDict.setValue(self.txtNewPassword.text, forKey: "password")
                            myMutableDict.setValue(self.txtNewPassword.text, forKey: "forcechangepassword")
                            UserDefaults.standard.set(myMutableDict, forKey: "dicLogin")
                            UserDefaults.standard.synchronize()
                            
                            self.gotoDashboardPage()
                        }
                    }
                    else
                    {
                        
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
    
    // MARK: -  Redirect To Dashboard Method
    func gotoDashboardPage() {
        
        let dicUserDetails = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strusertype = String(format: "%@", dicUserDetails.value(forKey: "user_type") as! CVarArg)
        print("strusertype -> \(strusertype)")
        if(strusertype .isEqual("T"))
        {
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
        else if(strusertype .isEqual("S"))
        {
            OperationQueue.main.addOperation{
              
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
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
