//
//  Tenantjobcreate.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 03/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class Tenantjobcreate: ViewController,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate
{
    let cellReuseIdentifier = "cell"
    var tblView: UITableView? = UITableView()
    var tblViewSubType: UITableView? = UITableView()
 
    var loadingCircle = UIView()
    
    let picker = UIImagePickerController()
    
    var strServicetypeid = NSString()
    var strServicetype = NSString()
    
    var base64String = NSString()
    
    @IBOutlet var viewtop: UIView!
    
    @IBOutlet var scrollOverall: UIScrollView!
    @IBOutlet var viewTopGrayout: UIView!
    @IBOutlet var txtservicetype: UITextField!
    
    @IBOutlet var lblrequesteddate: UILabel!
    @IBOutlet var lblbuildingflatno: UILabel!
    @IBOutlet var lblAddress: UILabel!
    
    @IBOutlet var imgvCalendar: UIImageView!
    @IBOutlet var imgvMap: UIImageView!
    @IBOutlet var imgvBuilding: UIImageView!
    
    @IBOutlet var btnTakePic: UIButton!
    @IBOutlet var btnSubType: UIButton!
    var arrSubType = NSMutableArray()
    var strSubType = NSString()
    var rowNumber = Int()
    
    @IBOutlet var btnChooseDate: UIButton!
    @IBOutlet var btnTime: UIButton!
    
    @IBOutlet var txtvnote: UITextView!
    @IBOutlet var btnSubmit: UIButton!
    
    var myPickerView: UIPickerView = UIPickerView()
    var arrMPickerData = NSMutableArray()
    var arrMTime = NSMutableArray()
    
    //date
    var datePicker1 = UIDatePicker()
    var vwDateJob = UIView()
    var strdate = NSString()
    
    var vwTimeJob = UIView()
    var strTime = NSString()
    var arrSlotTIME = NSMutableArray()
    var TimePicker: UIPickerView!
    
    
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
        
        self.setupBorder()
        
        btnChooseDate.layer.borderColor=UIColor.lightGray.cgColor
        btnChooseDate.layer.borderWidth=0.8
        btnChooseDate.layer.cornerRadius = 4.0
        btnChooseDate.layer.masksToBounds = true
        
        self.btnTime.backgroundColor=UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 0.90)
        self.btnTime.isUserInteractionEnabled = false
        
        btnTime.layer.borderColor=UIColor.lightGray.cgColor
        btnTime.layer.borderWidth=0.8
        btnTime.layer.cornerRadius = 4.0
        btnTime.layer.masksToBounds = true
        
        txtvnote.text="Please describe your service notes"
        txtvnote.textColor=UIColor.lightGray
        
        txtservicetype.isUserInteractionEnabled=false
        txtservicetype.text=strServicetype as String
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:MM"
        let result = formatter.string(from: date)
        lblrequesteddate.text=result
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        lblbuildingflatno.text=String(format: "Building - %@, Flat- %@", dictemp.value(forKey: "customer_building_no")as! CVarArg,dictemp.value(forKey: "customer_flat_no") as! CVarArg)
        lblAddress.text=String(format: "%@", dictemp.value(forKey: "customer_street_address") as! CVarArg)
        
        // scrolling page
        let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
            //5S
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+350)
        }
        else if(screenSize.height == 480.0){
            //6
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+450)
        }
        else if(screenSize.height == 667.0){
            //6
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+250)
        }
        else if(screenSize.height == 736.0){
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+250)
        }
        else if(screenSize.height == 812.0){
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+300)
        }
        else{
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: scrollOverall.frame.size.height+300)
        }
        let dictemplogin = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemplogin.value(forKey: "token") as! CVarArg)
        self.fetchSubTypeService(strauthkey: strauthkey, strServiceID: self.strServicetypeid as String)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Textfield Border Setup Method
    func setupBorder() -> Void
    {
        viewtop.layer.shadowColor = UIColor.lightGray.cgColor
        viewtop.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewtop.layer.shadowRadius = 0.0
        viewtop.layer.shadowOpacity = 2.0
        viewtop.layer.masksToBounds = false
        
        viewTopGrayout.layer.borderWidth = 1.0
        viewTopGrayout.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        viewTopGrayout.layer.cornerRadius = 4.0
        viewTopGrayout.layer.masksToBounds = true
      
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: btnSubType.frame.size.height - width, width: btnSubType.frame.size.width, height: btnSubType.frame.size.height)
        border.borderWidth = width
        btnSubType.layer.addSublayer(border)
        btnSubType.layer.masksToBounds = true
        
        btnTakePic.layer.borderWidth = 1.0
        btnTakePic.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        btnTakePic.layer.cornerRadius = 4.0
        btnTakePic.layer.masksToBounds = true
        
        let border1 = CALayer()
        let width1 = CGFloat(1.0)
        border1.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        border1.frame = CGRect(x: 0, y: txtservicetype.frame.size.height - width1, width: txtservicetype.frame.size.width, height: txtservicetype.frame.size.height)
        border1.borderWidth = width1
        txtservicetype.layer.addSublayer(border1)
        txtservicetype.layer.masksToBounds = true
        
        btnSubmit.layer.cornerRadius = 4.0
        btnSubmit.layer.masksToBounds = true
    }
    
    
    // MARK: - TextView Delegates Method
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool
    {
        if( (txtvnote.text=="Please describe your service notes") && (txtvnote.textColor==UIColor.lightGray))
        {
            txtvnote.text = ""
            txtvnote.textColor=UIColor.black
        }
        return true;
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool{
          scrollOverall.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        return true;
    }
    func textViewDidBeginEditing(_ textView: UITextView){
       let screenSize = UIScreen.main.bounds
         if (screenSize.height == 568.0){
         //5S
         scrollOverall.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y-10), animated: true)
         }
         else if(screenSize.height == 667.0){
         //6
         scrollOverall.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y-30), animated: true)
         
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
         }
        
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
    func keyboardWillBeHidden(_ aNotification: Notification){
        print(txtvnote.text.count)
        if (txtvnote.text.count==0)
        {
            txtvnote.textColor=UIColor.lightGray
            txtvnote.text="Please describe your service notes"
        }
    }
    
    // MARK: - presssubmit method
    @IBAction func presssubmit(_ sender: Any)
    {
        if (strSubType.isEqual(to: "")){
            let uiAlert = UIAlertController(title: "", message: "Please select service sub type .", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if (strdate.isEqual(to: "")){
            let uiAlert = UIAlertController(title: "", message: "Please select slot date.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
       else if (strTime.isEqual(to: "")){
            let uiAlert = UIAlertController(title: "", message: "Please select slot time.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            if ( txtvnote.text=="Please describe your service notes")
            {
                txtvnote.text = ""
            }
            self.submitMethod(servideid:  strServicetypeid as String, subTypeId: strSubType as String, notetext: txtvnote.text, slotdate: strdate as String, slottime: strTime as String)
        }
    }
    
    func submitMethod(servideid:String, subTypeId:String, notetext:String, slotdate:String, slottime:String)
    {
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.showLoadingMode()
        
        base64String = base64String.replacingOccurrences(of: "+", with: "%2B") as NSString
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "tenant/book_service")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        
        var postString = "service=\(servideid)&subservice=\(subTypeId)&booking_note=\(notetext)&slot_date=\(slotdate)&slot_time=\(slottime)&booking_image=\(base64String)"
        postString = postString.replacingOccurrences(of: "", with: "%20")
      //  print("postString  ->>",postString)
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
                 
                    
                    if (message_code == 1){
                        //success
                        OperationQueue.main.addOperation {
                            let obj = TenantThankYouPage()
                               let messageText:String = dictemp.value(forKey: "message") as! String
                            obj.strMessage = messageText as NSString
                            self.navigationController?.pushViewController(obj, animated: true)
                        }
                    }
                    else if (message_code == 0){
                        //error
                        OperationQueue.main.addOperation {
                              let messageText:String = dictemp.value(forKey: "message") as! String
                            let uiAlert = UIAlertController(title: "", message: messageText, preferredStyle: UIAlertControllerStyle.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
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
  
     // MARK: - Sub type  Method
    @IBAction func pressSubType(_ sender: Any)
    {
        if tblViewSubType != nil {
           handleTap1()
        }
        else{
             self.popupListSubtype()
        }
     }
    func popupListSubtype()
    {
        txtvnote.resignFirstResponder()
        tblViewSubType?.removeFromSuperview()
        tblViewSubType=nil
        
        tblViewSubType = UITableView(frame: CGRect(x: btnSubType.frame.minX, y: btnSubType.frame.maxY+2, width: btnSubType.frame.width, height: 0))
        tblViewSubType?.delegate = self
        tblViewSubType?.dataSource = self
        scrollOverall.addSubview(tblViewSubType!)
        tblViewSubType?.tag = 112
        
        tblViewSubType?.backgroundView = nil
        tblViewSubType?.backgroundColor = UIColor.white
        tblViewSubType?.separatorColor = UIColor.clear
        tblViewSubType?.layer.cornerRadius = 2.0
        tblViewSubType?.layer.borderWidth = 0.6
        tblViewSubType?.layer.borderColor=UIColor.lightGray.cgColor
        tblViewSubType?.layer.masksToBounds = true
        
        UIView .animate(withDuration: 0.35, delay: 0.0, options: .curveEaseIn, animations: {
            var frame = CGRect()
            frame = (self.tblViewSubType?.frame)!
            frame.size.height =  UIScreen.main.bounds.size.height/3.0-64
            self.tblViewSubType?.frame = frame
        }, completion: nil)
    }
    
    
    // MARK: - tableView delegate & datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
             return arrSubType.count
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier:cellReuseIdentifier)
        
        if tableView == tblViewSubType
        {
            let dictemp: NSDictionary = arrSubType[indexPath.row] as! NSDictionary
        
            cell.selectionStyle=UITableViewCellSelectionStyle.none
            cell.accessoryType = UITableViewCellAccessoryType.none
            cell.backgroundColor=UIColor.white
            cell.clearsContextBeforeDrawing = true
            cell.contentView.clearsContextBeforeDrawing = true
            
            let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:  (tblViewSubType?.frame.size.width)!, height: 40))
            title1.textAlignment = .center
            title1.textColor = UIColor.darkGray
            title1.backgroundColor = UIColor.clear
            title1.text = dictemp.value(forKey: "sub_typename") as? String
            title1.font = UIFont (name: "Roboto-Regular", size: 13)
            cell.contentView.addSubview(title1)
            
            let lblSeparator = UILabel(frame: CGRect(x: 15, y: 39.5, width: tableView.frame.size.width-30, height: 0.5))
            lblSeparator.backgroundColor = UIColor.lightGray
            cell.contentView.addSubview(lblSeparator)
        }
       /* else
        {
            cell.selectionStyle=UITableViewCellSelectionStyle.none
            cell.accessoryType = UITableViewCellAccessoryType.none
            cell.backgroundColor=UIColor.white
            cell.clearsContextBeforeDrawing = true
            cell.contentView.clearsContextBeforeDrawing = true
            
            let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:  (tblView?.frame.size.width)!, height: 40))
            title1.textAlignment = .center
            title1.textColor = UIColor.darkGray
            title1.backgroundColor = UIColor.clear
            title1.text = (arrMPickerData.object(at: indexPath.row) as! String)
            title1.font = UIFont (name: "Roboto-Regular", size: 13)
            cell.contentView.addSubview(title1)
            
            let lblSeparator = UILabel(frame: CGRect(x: 15, y: 39.5, width: tableView.frame.size.width-30, height: 0.5))
            lblSeparator.backgroundColor = UIColor.lightGray
            cell.contentView.addSubview(lblSeparator)
        }*/
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
         if tableView == tblViewSubType{
            rowNumber = indexPath.row
              let dictemp: NSDictionary = arrSubType[indexPath.row] as! NSDictionary
            strSubType = String(format: "%@", dictemp.value(forKey: "subtype_id") as! CVarArg) as NSString
            let strtime = NSString(format:" %@", String(format: "%@", dictemp.value(forKey: "sub_typename") as! CVarArg) as NSString)
            btnSubType.setTitle(strtime as String, for: .normal)
            handleTap1()
        }
        /* else{
            strSlotTime =  NSString(format:"%@",(arrMPickerData.object(at: indexPath.row) as! String))
            
            strSlotTime = strSlotTime.replacingOccurrences(of: " ", with: "") as NSString
            
            let strtime = NSString(format:"Slot time : %@",(arrMPickerData.object(at: indexPath.row) as! String))
            btnChooseServicePicker.setTitle(strtime as String, for: .normal)
            handleTap()
        }
        */
        
    }
    
    func handleTap1()
    {
        UIView .animate(withDuration: 0.35, delay: 0.0, options: .curveEaseIn, animations: {
            var frame = CGRect()
            frame = (self.tblViewSubType?.frame)!
            frame.size.height = 0
            self.tblViewSubType?.frame = frame
        }, completion: { (nil) in
            self.tblViewSubType?.removeFromSuperview()
            self.tblViewSubType = nil
        })
        
    }
   
     // MARK: - choose date button  Method
    @IBAction func pressChooseDate(_ sender: Any) {
       
        self.datePickerDate()
        
    }
    
    // MARK: - Date Pop  Method
    func datePickerDate()
    {
        self.vwDateJob.removeFromSuperview()
        self.vwTimeJob.removeFromSuperview()
        txtvnote.resignFirstResponder()
        
        vwDateJob =  UIView(frame: CGRect(x: 0, y:  UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200))
        
        vwDateJob.backgroundColor = UIColor(red: 231/255, green: 235/255, blue: 245/255, alpha: 1.0)
        
        let buttonDone = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width-80, y: 0, width: 80, height: 30))
        buttonDone.backgroundColor = UIColor.clear
        buttonDone.tag=1
        buttonDone.setTitle("Done", for: .normal)
        buttonDone.setTitleColor(UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0), for: .normal)
        buttonDone.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonDone.addTarget(self, action: #selector(pressDoneDate1), for: .touchUpInside)
        vwDateJob.addSubview(buttonDone)
        
        datePicker1 = UIDatePicker(frame: CGRect(x: 0, y:buttonDone.frame.maxY, width: UIScreen.main.bounds.size.width, height:170))
        datePicker1.datePickerMode = .date
        datePicker1.backgroundColor = UIColor.white
        
        
        if strdate == "" {
            datePicker1.date = Date()
        }
        else{
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(abbreviation: "GMT")
            let sDate = formatter.date(from: strdate as String)! as NSDate
            datePicker1.date = sDate as Date
        }
        
        self.datePicker1.minimumDate = Date()
        
        datePicker1.addTarget(self, action:    #selector(dateUpdated(_:)), for: .valueChanged)
        vwDateJob.addSubview(datePicker1)
        self.view.addSubview(vwDateJob)
       
    }
    @IBAction func dateUpdated(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter ()
        formatter.dateFormat = "yyyy-MM-dd"
        
        strdate = formatter.string(from: (datePicker.date as NSDate) as Date) as NSString
        
    }
    
    @objc func pressDoneDate1(){
        let formatter = DateFormatter ()
        formatter.dateFormat = "yyyy-MM-dd"
        var strString =  String()
        if strdate.isEqual(to: "") {
            strdate =  formatter.string(from: Date() as Date)  as NSString
            strString =  String(format:" %@", formatter.string(from: Date() as Date) as NSString)
        }
        else{
            strString =  String(format:" %@",strdate as String)
        }
        
        
        btnChooseDate.setTitle(strString, for: .normal)
        vwDateJob.removeFromSuperview()
        self.view.endEditing(true)
        
        self.strTime = ""
        self.btnTime.backgroundColor=UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 0.90)
        self.btnTime.isUserInteractionEnabled = false
        self.btnTime.setTitle(" Choose time", for: .normal)
       
        
        
        /// date formating to send date
        let formatterReschedule = DateFormatter ()
        formatterReschedule.dateFormat = "yyyy-MM-dd"
        let strDate =  formatter.date(from: strdate as String)
        let strDateString = formatterReschedule.string(from: strDate!)
        print("final format date : %@",strDateString)
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchTenant_slot(strauthkey: strauthkey, strdate: strDateString)
        
        
        
    }
    
    // MARK: - press  time slot Method
    @IBAction func pressTime(_ sender: Any)
    {
        
        if arrMTime.count > 0 {
        self.vwDateJob.removeFromSuperview()
        self.vwTimeJob.removeFromSuperview()
        txtvnote.resignFirstResponder()
      
        vwTimeJob = UIView(frame: CGRect(x: 0, y:  UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200))
        vwTimeJob.backgroundColor = UIColor(red: 231/255, green: 235/255, blue: 245/255, alpha: 1.0)
        
        let buttonDone = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width-80, y: 0, width: 80, height: 30))
        buttonDone.backgroundColor = UIColor.clear
        buttonDone.tag=1
        buttonDone.setTitle("Done", for: .normal)
        buttonDone.setTitleColor(UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0), for: .normal)
        buttonDone.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonDone.addTarget(self, action: #selector(pressDoneTime1), for: .touchUpInside)
        vwTimeJob.addSubview(buttonDone)
        
        TimePicker = UIPickerView (frame: CGRect(x: 0, y:buttonDone.frame.maxY, width: UIScreen.main.bounds.size.width, height:170))
        TimePicker.dataSource = self
        TimePicker.delegate = self
        TimePicker.backgroundColor = UIColor.white
        vwTimeJob.addSubview(TimePicker)
        self.view.addSubview(vwTimeJob)
        }
    }
    
    @objc func pressDoneTime1(){
        if strTime == "" {
            strTime = arrMTime[0] as! NSString
        }
        btnTime.setTitle(strTime as String, for: .normal)
        vwTimeJob.removeFromSuperview()
        self.view.endEditing(true)
        
    }
    

    //MARK: -   fetch Tenant_slot time
    func fetchTenant_slot(strauthkey:String , strdate:String)
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@/%@", Constants.conn.ConnUrl, "tenant/booking_slot",strdate)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
          print("strconnurl -> \(strconnurl)")
        request.httpMethod = "GET"
        //let postString = ""
        request.setValue(strauthkey, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //request.httpBody = postString.data(using: String.Encoding.utf8)
        
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
                    self.arrMTime.removeAllObjects()
                    let dictemp = NSMutableDictionary(dictionary: json)
                    print("dictemp -> \(dictemp)")
                    
                    let message_code =  String(format: "%@", dictemp.value(forKey: "message_code")as! CVarArg)
                    if (message_code == "1")
                    {
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        let arrData :NSMutableArray = NSMutableArray(array: arrm1)
                        for d in 0 ..<  arrData.count
                        {
                            let dic = arrData.object(at: d)
                            print("dic",dic)
                            var start = String(format: "%@", (dic as AnyObject).value(forKey: "start") as! CVarArg)
                            var end = String(format: "%@", (dic as AnyObject).value(forKey: "end") as! CVarArg)
                            // cut as 10:30 like
                            start = String(start.prefix(5))
                            end = String(end.prefix(5))
                            
                            // remove :
                            let lastChar = start.last!
                            if (lastChar == ":") {
                                start = String(start.prefix(4))
                                
                            }
                            let strTotal = String(format: "%@ - %@", start,end)
                            self.arrMTime.add(strTotal)
                            
                        }
                        OperationQueue.main.addOperation {
                            self.btnTime.backgroundColor=UIColor.white
                            self.btnTime.isUserInteractionEnabled = true
                            print(" arrMTime", self.arrMTime)
                            
                        }
                    }
                    if (message_code == "5")
                    { //ofc clsed
                        
                        self.hideLoadingMode()
                        OperationQueue.main.addOperation {
                            self.btnChooseDate.setTitle("Choose date", for: .normal)
                            self.strdate = ""
                            
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
   
    //MARK: -   SubTypeService Method
    func fetchSubTypeService(strauthkey:String , strServiceID:String)
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@/%@", Constants.conn.ConnUrl, "tenant/view-subservices",strServiceID)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
         // let postString = "sevrice_id=\(txtUsername.text!)"
        request.setValue(strauthkey, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //request.httpBody = postString.data(using: String.Encoding.utf8)
        
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
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        let arrData :NSMutableArray = NSMutableArray(array: arrm1)
                        self.arrSubType = arrData
                    
                        print("  self.arrSubType ",  self.arrSubType )
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
    // MARK: - pressTakePic method
    @IBAction func pressTakePic(_ sender: Any)
    {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerController Delegate method
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker, animated: true, completion: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func openGallary()
    {
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if var pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
           pickedImage = resizeImage(image: pickedImage, targetSize: CGSize(width: 300, height: 200))
            btnTakePic.setBackgroundImage(pickedImage, for: UIControlState.normal)
            
            let imageData:Data =  UIImageJPEGRepresentation(pickedImage, 0.5)!
            base64String = imageData.base64EncodedString() as NSString
            //print(base64String)
        }
        /*
         Swift Dictionary named “info”.
         We have to unpack it from there with a key asking for what media information we want.
         We just want the image, so that is what we ask for.  For reference, the available options are:
         UIImagePickerControllerMediaType
         UIImagePickerControllerOriginalImage
         UIImagePickerControllerEditedImage
         UIImagePickerControllerCropRect
         UIImagePickerControllerMediaURL
         UIImagePickerControllerReferenceURL
         UIImagePickerControllerMediaMetadata
         */
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
           newSize =  CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
         } else {
            newSize =  CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
          
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
           let rect =  CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
      
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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
    
    
    //MARK:- PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == datePicker1{
             return arrMPickerData.count
          }
         else{
              return arrMTime.count
          }
     }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == datePicker1{
           return arrMPickerData[row] as? String
        }
        else{
            return arrMTime[row] as? String
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == datePicker1{
           // return arrMPickerData[row] as? String
        }
        else{
              strTime =  NSString(format:"%@",(arrMTime.object(at:row) as! String))
        }
    }
    
    //MARK: -   -Compare two Times Method
    func comparetwo_time(end:NSDate, Start:NSDate) -> Date
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let tomorrow = Start.addingTimeInterval(3.0 * 60.0 * 60.0)
        let dateInterval = DateInterval(start: Start as Date, end: tomorrow as Date)
        print("dateInterval : ",dateInterval)
        print("  dateInterval.end : ",  dateInterval.end)
        let addingDate:NSDate = dateInterval.end as NSDate
        print("  addingDate as Date : ",  addingDate as Date)
        return addingDate as Date
    }
    
    
}
