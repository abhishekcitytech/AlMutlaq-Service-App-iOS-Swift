//
//  AddComplain.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 18/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class AddComplain: UIViewController,UITextFieldDelegate,UITextViewDelegate ,UIScrollViewDelegate
{
    var loadingCircle = UIView()
    
    @IBOutlet var SegmentCon: UISegmentedControl!
    @IBOutlet var scrollOverall: UIScrollView!
    @IBOutlet var txtSubject: UITextField!
    @IBOutlet var txtvNotes: UITextView!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var viewtop: UIView!
    
    var strSugCompain = NSString()
    
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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
      //  let items = ["Complaint", "Suggestion"]
  //      SegmentCon = UISegmentedControl(items: items)
       // SegmentCon.items = items
        SegmentCon.frame = CGRect(x: 10, y: 10, width: SegmentCon.frame.size.width, height:38)
        SegmentCon.selectedSegmentIndex = 0
        SegmentCon.tintColor = UIColor(red: 53.0/255, green: 101.0/255, blue: 204.0/255, alpha: 1)
        SegmentCon.backgroundColor = UIColor.white
        SegmentCon.addTarget(self, action: #selector(self.mySliderChanged(_:)), for: .valueChanged)
        
        let font = UIFont(name: "Roboto-Regular", size: 14.0)!
        SegmentCon.setTitleTextAttributes([NSAttributedStringKey.font: font],
                                        for: .normal)
      //  self.scrollOverall.addSubview(SegmentCon)
         strSugCompain = "C"
        
        txtvNotes.text = "Please describe your notes"
        txtvNotes.textColor = UIColor.lightGray
        
        viewtop.layer.shadowColor = UIColor.lightGray.cgColor
        viewtop.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewtop.layer.shadowRadius = 0.0
        viewtop.layer.shadowOpacity = 2.0
        viewtop.layer.masksToBounds = false
        
        let border1 = CALayer()
        let width1 = CGFloat(1.0)
        border1.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        border1.frame = CGRect(x: 0, y: txtSubject.frame.size.height - width1, width: txtSubject.frame.size.width, height: txtSubject.frame.size.height)
        border1.borderWidth = width1
        txtSubject.layer.addSublayer(border1)
        txtSubject.layer.masksToBounds = true
        
        txtvNotes.layer.borderWidth=1.0
        txtvNotes.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        txtvNotes.layer.cornerRadius = 4.0
        txtvNotes.layer.masksToBounds = true
        
        btnSubmit.layer.cornerRadius = 4.0
        btnSubmit.layer.masksToBounds = true
        // scrolling page
       
        
        let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
            //5S
            
           scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+350)
        }
        else if(screenSize.height == 480.0){
            //6
               scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+400)
            
        }
        else if(screenSize.height == 667.0){
            //6
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+250)
            
        }
        else if(screenSize.height == 736.0){
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+250)
            
        }
        else if(screenSize.height == 812.0){
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+350)
        }
        else
        {
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+350)
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Slider  method
    @objc func mySliderChanged(_ sender:UISegmentedControl!)
    {
       switch sender.selectedSegmentIndex
            {
            case 0:
              strSugCompain = "C"
            case 1:
              strSugCompain = "S"
            default:
                break
            }
        }
    
    
    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 70
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    // MARK: - TextView Delegates Method
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool
    {
        if txtvNotes.text.isEqual("Please describe your notes") && (txtvNotes.textColor?.isEqual(UIColor.lightGray))!
        {
            txtvNotes.text = ""
            txtvNotes.textColor = UIColor.black
        }
        return true; 
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool{
        scrollOverall.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        return true;
    }
    func textViewDidBeginEditing(_ textView: UITextView){
    /*  let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
            //5S
            scrollOverall.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y-10), animated: true)
        }
        else if(screenSize.height == 667.0){
            //6
            scrollOverall.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y+100), animated: true)
            
        }
        else if(screenSize.height == 736.0){
            scrollOverall.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
            
        }
        else if(screenSize.height == 812.0){
            scrollOverall.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        }
        else
        {
            scrollOverall.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y-10), animated: true)
        }*/
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
    
    // MARK: - Get Subordinates Button call Method
    func keyboardWillBeHidden(notification: NSNotification) {
        if( txtvNotes.text.count == 0){
            txtvNotes.textColor = UIColor.lightGray
            txtvNotes.text = "Please describe your notes"
        }
    }
    
    // MARK: - pressSubmit method
    @IBAction func pressSubmit(_ sender: Any)
    {
        if(txtSubject.text=="")
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter subject.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if(txtvNotes.text=="")
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your complain note.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
            //print("dictemp :%@",dictemp)
            let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
            self.addcomplain(strauthkey: strauthkey, strSubject: txtSubject.text!, strNotes: txtvNotes.text!, strType:strSugCompain as String )
        }
    }
    //  --data 'complain_subject=complain%20for%20service%2012&complain_note=bboking%2012&complain_type=S'

    //MARK: -   addcomplain Method
    func  addcomplain(strauthkey:String ,strSubject:String ,strNotes:String ,strType:String)
    {
        
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "tenant/add_complain")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        let postString = "complain_subject=\(strSubject)&complain_note=\(strNotes)&complain_type=\(strType)"
        request.setValue(strauthkey, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
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
                        //success
                        self.GoTOThankYouPage(strMSG: dictemp.value(forKey: "message") as! NSString)
                    }
                    else{
                        //fail
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
    
    // MARK: -  Go To ThankYou Page Method
    func GoTOThankYouPage(strMSG: NSString ) -> Void
    {
        OperationQueue.main.addOperation {
        let obj2 = TenantThankYouPage()
        obj2.strMessage = "Your complaint is registered successfully."
        self.navigationController?.pushViewController(obj2, animated: true)
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

}
