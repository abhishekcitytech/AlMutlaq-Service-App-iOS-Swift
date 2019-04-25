//
//  JobDetail.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 03/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class JobDetail: ViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate
{
    var loadingCircle = UIView()
    
    @IBOutlet var viewtop: UIView!
    @IBOutlet var scrollOverall: UIScrollView!
    @IBOutlet var btnNoteHistory: UIButton!
    
    @IBOutlet var VwMaon: UIView!
    @IBOutlet var txtservicetype: UITextField!
    
    @IBOutlet var txtSubType: UITextField!
    @IBOutlet var imgvService: UIImageView!
    @IBOutlet var txtdate: UITextField!
    @IBOutlet var txtbuildingno: UITextField!
    @IBOutlet var txtaddress: UITextField!
    @IBOutlet var imgvCalendar: UIImageView!
    @IBOutlet var imgvMap: UIImageView!
    @IBOutlet var imgvBuilding: UIImageView!
    
    @IBOutlet var lblJobPosting: UILabel!
    @IBOutlet var lblReportingDate: UILabel!
    
  
    @IBOutlet var vwDate2: UIView!
      @IBOutlet var vwDate1: UIView!
    @IBOutlet var lblJobPostingDate2: UILabel!
    
    @IBOutlet var txtvnote: UITextView!

    @IBOutlet var VwBooking: UIView!
    @IBOutlet var VwBooking1: UIView!
    @IBOutlet var VwBooking2: UIView!
    
    @IBOutlet var lblREQ: UILabel!
    @IBOutlet var lblREP: UILabel!
    @IBOutlet var lblRequested: UILabel!
    @IBOutlet var lblReportingTime: UILabel!
    
    @IBOutlet var viewONLYBooking1: UIView!
    @IBOutlet var lblONLYREQ: UILabel!
    @IBOutlet var lblONLYRequested: UILabel!
    
    @IBOutlet var btnAck: UIButton!

    var strPercentage = NSString()
    var FinalPercentage = NSString()
    var arrmPercentage = NSMutableArray()
    var arrMParcentageButton = NSMutableArray()
    
    var  myViewSlider = UIView ()
    var mainBg = UIView()
    var bgVwHeader = UIView()
    var btnDonepdf = UIButton()
    var cellImage = UIImageView()
   
    var dicServiceDetails = NSMutableDictionary()
    
    var tapGesture = UITapGestureRecognizer()
/// ack
      var myView = UIView()
     var mySecondVw = UIView()
    
     var lblDisplay = UILabel()
     var strIdentifier = NSString()
    
    
   
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
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchServiceDetails(strauthkey: strauthkey)
        
     
        viewtop.layer.shadowColor = UIColor.lightGray.cgColor
        viewtop.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewtop.layer.shadowRadius = 0.0
        viewtop.layer.shadowOpacity = 2.0
        viewtop.layer.masksToBounds = false
        
        self.vwDate2.isHidden = true
        self.vwDate1.isHidden = true
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: txtservicetype.frame.size.height - width, width: txtservicetype.frame.size.width+100, height: txtservicetype.frame.size.height)
        border.borderWidth = width
        txtservicetype.layer.addSublayer(border)
        txtservicetype.layer.masksToBounds = true
        
        let border1 = CALayer()
        let width1 = CGFloat(1.0)
        border1.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        border1.frame = CGRect(x: 0, y: txtSubType.frame.size.height - width1, width: txtSubType.frame.size.width+100, height: txtSubType.frame.size.height)
        border1.borderWidth = width1
        txtSubType.layer.addSublayer(border1)
        txtSubType.layer.masksToBounds = true
        
        VwMaon.layer.borderWidth = 1.0
        VwMaon.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        VwMaon.layer.cornerRadius = 4.0
        VwMaon.layer.masksToBounds = true
        
        txtvnote.layer.borderWidth = 1.0
        txtvnote.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        txtvnote.layer.cornerRadius = 4.0
        txtvnote.layer.masksToBounds = true
        txtvnote.isUserInteractionEnabled = false
      
     
        
    }
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }

    func pageDesignFinal(){
        print("dic ->",dicServiceDetails)
        // note Button
        let arrmP :NSArray =  dicServiceDetails.value(forKey: "booking_update_note") as! NSArray
        let arrBooking_update_note:NSMutableArray = NSMutableArray(array: arrmP)
        if arrBooking_update_note.count == 0
        {
            self.btnNoteHistory.isHidden=true
        }
        else{
            self.btnNoteHistory.isHidden=false
        }
        //bject.feature = nullToNil(dicServiceDetails.value(forKey: "service_name") as? String)
        
        txtservicetype.text = (nullToNil(value: dicServiceDetails.value(forKey: "service_name") as? String as AnyObject) as! String)
            //dicServiceDetails.value(forKey: "service_name") as? String
        txtSubType.text = nullToNil(value: dicServiceDetails.value(forKey: "subservice_name") as AnyObject) as? String
          //  NSString(format:" %@", String(format: "%@", dicServiceDetails.value(forKey: "subservice_name") as! CVarArg) as NSString) as String
        //    txtdate.text=dicServiceDetails.value(forKey: "booking_requested_date") as? String
        
        txtbuildingno.text=NSString(format:" Bulding no: %@, Flat no: %@", (dicServiceDetails.value(forKey: "building_no") as? String)!,(dicServiceDetails.value(forKey: "flat_no") as? String)!) as String
        txtaddress.text=dicServiceDetails.value(forKey: "building_address") as? String
        
        txtvnote.isUserInteractionEnabled=true
        txtvnote.text=dicServiceDetails.value(forKey: "booking_notes") as? String
        let strAck = dicServiceDetails.value(forKey: "booking_acknowledge") as? String
        
        
        
        if(strAck!.isEqual("N"))
        {
            btnAck.isHidden = true
            
            VwBooking.isHidden = true
            viewONLYBooking1.isHidden = false
            
            var strbooking = NSString(format:"%@", (dicServiceDetails.value(forKey: "tenant_slot_time") as! String)) as String
            strbooking = strbooking.replacingOccurrences(of: "-", with: "  -  ", options: NSString.CompareOptions.literal, range: nil)
            lblONLYRequested.text=NSString(format:"%@", strbooking) as String
            
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: txtvnote.frame.maxY+100)
            
            
            
            self.vwDate2.isHidden = true
            self.vwDate1.isHidden = false
            self.lblJobPostingDate2.text = NSString(format:"%@", (dicServiceDetails.value(forKey: "tenant_slot_date") as! String)) as String
        }
        else
        {
            let bokingSt = dicServiceDetails.value(forKey: "booking_status") as? String
            if(bokingSt!.isEqual("0"))
            {
                btnAck.isHidden = false
            }
            else{
                btnAck.isHidden = true
            }
            
            let strbooking_accepted = dicServiceDetails.value(forKey: "booking_accepted") as? String
            if(strbooking_accepted!.isEqual("N"))
            {
                ACKPopUpView()
            }
            
            self.vwDate1.isHidden = true
            self.vwDate2.isHidden = false
            self.lblJobPosting.text = NSString(format:"%@", (dicServiceDetails.value(forKey: "tenant_slot_date") as! String)) as String
            
            let ResudlingDate =  NSString(format:"%@", (dicServiceDetails.value(forKey: "acknowledge_requested_date") as! CVarArg)) as String
            
            if(ResudlingDate.isEqual("") )
            {
                self.lblReportingDate.text = NSString(format:"%@", (dicServiceDetails.value(forKey: "acknowledge_slot_date") as! CVarArg)) as String
            }
            else{
                self.lblReportingDate.text = ResudlingDate
            }
            
            VwBooking.isHidden = false
            viewONLYBooking1.isHidden = true
            
            var strtenantbooking = NSString(format:"%@", (dicServiceDetails.value(forKey: "tenant_slot_time") as! String)) as String
            strtenantbooking = strtenantbooking.replacingOccurrences(of: "-", with: "  -  ", options: NSString.CompareOptions.literal, range: nil)
            lblRequested.text = NSString(format:"%@", strtenantbooking) as String
            
            var stCskrbooking = NSString(format:"%@", (dicServiceDetails.value(forKey: "csk_slot_time") as! String)) as String
            stCskrbooking = stCskrbooking.replacingOccurrences(of: "-", with: "  -  ", options: NSString.CompareOptions.literal, range: nil)
          
            
            
            if(ResudlingDate.isEqual("") )
            {
                  lblReportingTime.text = NSString(format:"%@", stCskrbooking) as String
            }
            else{
                self.lblReportingTime.text = NSString(format:"%@", (dicServiceDetails.value(forKey: "acknowledge_requested_time") as! CVarArg)) as String
                
            }
            
            
            scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: txtvnote.frame.maxY+100)
            //---- Create Parcentage Bar ----//
            let dictemp1 = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
            let strauthkey = String(format: "Bearer%@", dictemp1.value(forKey: "token") as! CVarArg)
            self.fetchACKpercentage(strauthkey: strauthkey)
        }
        
        // TAP Gesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imgvService.addGestureRecognizer(tapGesture)
        
        let strUrl = String(format: "%@", dicServiceDetails.value(forKey: "booking_image") as! CVarArg)
        if(strUrl .isEqual(""))
        {
            imgvService.image=UIImage(named: "serviceimagebg.png")
            imgvService.isUserInteractionEnabled = false
        }
        else
        {
            imgvService.isUserInteractionEnabled = true
            self.imgvService.backgroundColor = UIColor.white
            let imageUrl = self.dicServiceDetails.value(forKey: "booking_image") as! String
            self.imgvService.imageFromURL(urlString: imageUrl)
           //self.resizeImage(image:  self.imgvService, targetSize: CGSize(width: 300,  height: 180))
        }
        imgvService.layer.borderWidth = 1.0
        imgvService.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        imgvService.layer.cornerRadius = 4.0
        imgvService.layer.masksToBounds = true
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Imageview PopUp method
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        self.viewImageBigVW()
    }
    func viewImageBigVW() -> Void
    {
        DispatchQueue.main.async {
            self.showLoadingMode()
        }
        mainBg = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        mainBg.backgroundColor = UIColor.black
        
        btnDonepdf   = UIButton(type: UIButtonType.custom) as UIButton
        btnDonepdf = UIButton(frame:CGRect(x: UIScreen.main.bounds.size.width-60, y: 30, width: 60, height: 28))
        btnDonepdf.backgroundColor = UIColor.clear
        btnDonepdf.setTitle("Done", for: .normal)
        btnDonepdf.setTitleColor(UIColor.white, for: .normal)
        btnDonepdf.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        btnDonepdf.addTarget(self, action: #selector(self.done(_:)), for: .touchUpInside)
        btnDonepdf.clipsToBounds = true
        btnDonepdf.clipsToBounds = true
        mainBg.addSubview(btnDonepdf)
        
        let vWidth = UIScreen.main.bounds.size.width
        let vHeight = UIScreen.main.bounds.size.height
        
        let scrollImg: UIScrollView = UIScrollView()
        scrollImg.delegate = self
        scrollImg.frame = CGRect(x: 0, y: 64, width: vWidth, height: vHeight)
        scrollImg.backgroundColor = UIColor.clear
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 6.0
      
        mainBg.addSubview(scrollImg)
        
        
        cellImage = UIImageView(frame: CGRect(x: 0, y: 0, width: mainBg.frame.size.width, height: 300))
        cellImage.center=CGPoint(x: mainBg.frame.midX, y: mainBg.frame.midY-40)
        cellImage.backgroundColor=UIColor.clear
          cellImage.contentMode = .scaleAspectFit
        
        let strUrl = String(format: "%@", dicServiceDetails.value(forKey: "booking_image") as! CVarArg)
        if(strUrl .isEqual("")){
            cellImage.image=UIImage(named: "serviceimagebg.png")
        }
        else{
            let imageUrl = self.dicServiceDetails.value(forKey: "booking_image") as! String
            self.cellImage.imageFromURL(urlString: imageUrl)
             self.cellImage.isUserInteractionEnabled = true
             self.hideLoadingMode()
            
          /* DispatchQueue.global(qos: .background).async {
                // Background Thread
                let imageUrl = self.dicServiceDetails.value(forKey: "booking_image") as! String
                print("imageUrl -->",imageUrl)
                let url = URL(string: imageUrl)
                let imageData:NSData = NSData(contentsOf: url!)!
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.cellImage.image = image
                    self.cellImage.isUserInteractionEnabled = true
                    self.hideLoadingMode()
                }
            }*/
        }
        scrollImg.addSubview(cellImage)
        self.view.addSubview(mainBg)
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.cellImage
    }
    @IBAction func done(_ sender: Any) {
        DispatchQueue.main.async {
            self.mainBg.removeFromSuperview()
        }
    }
    //MARK: -   fetchServiceDetails Method
    func fetchServiceDetails(strauthkey:String)
    {
        OperationQueue.main.addOperation {
            self.lblDisplay.removeFromSuperview()
           // self.arrMjobslist.removeAllObjects()
        }
        self.showLoadingMode()
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "tenant/view-services")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue(strauthkey, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
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
                    print("message_code -> \(message_code)")
                    if (message_code == 1){
                        //success
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        let arrData :NSMutableArray = NSMutableArray(array: arrm1)
                        for d in 0 ..<  arrData.count
                        {
                    
                             let dictemp: NSDictionary = arrData[d] as! NSDictionary
                              let strbookingID = String(format:"%@",(dictemp.value(forKey: "service_boooking_id") as? CVarArg)!)
                            if (self.strIdentifier as String == strbookingID) {
                                  OperationQueue.main.addOperation {
                           self.dicServiceDetails =  NSMutableDictionary(dictionary: dictemp)
                            self.pageDesignFinal()
                                }
                          }
                        }
                         print(" self.dicServiceDetails -> \( self.dicServiceDetails)")
                     }
                    else  if (message_code == 0){
                        
                        //fail
                        self.showLabelNoData()
                        
                    }
                    else  if (message_code == 2)
                    {
                        self.showLabelNoData()
                    }
                    else{
                        //fail
                        self.showLabelNoData()
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
    func showLabelNoData()
    {
        OperationQueue.main.addOperation {
           self.lblDisplay = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width/2-100, y: 0, width: 200, height: 30))
            self.lblDisplay.center = self.view.center
            self.lblDisplay.textAlignment = .center
            self.lblDisplay.textColor = UIColor.black
            self.lblDisplay.backgroundColor = UIColor.clear
            self.lblDisplay.text = "There is no Job ."
            self.lblDisplay.font = UIFont(name: "Roboto-Regular", size: 14.0)!
            self.lblDisplay.layer.cornerRadius = 6.0
            self.lblDisplay.layer.masksToBounds = true
            self.view.addSubview( self.lblDisplay)
        }
    }
    //MARK: -  fetchACKpercentage Method
    func fetchACKpercentage(strauthkey:String)
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "customer_service_center/service-percentage")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
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
                    let dictemp = NSMutableDictionary(dictionary: json)
                    //print("dictemp percetage -> \(dictemp)")
                    
                    let message_code:Int = dictemp.value(forKey: "message_code") as! Int
                    if (message_code == 1){
                        //success
                        self.strPercentage=dictemp.value(forKey: "data") as! NSString
                        //print(" self.strPercentage  : %@", self.strPercentage)
                        
                        self.arrmPercentage.removeAllObjects()
                        let parts =  self.strPercentage.components(separatedBy: ",")
                        print(parts.count)
                        print(parts)
                        
                        for part in parts {
                            let strPercent = String(format: "%@%@",part,"%")
                            self.arrmPercentage.add(strPercent)
                            //print(strPercent)
                        }
                        //print(self.arrmPercentage)
                        self.hideLoadingMode()
                        
                         let strP = "\(self.dicServiceDetails.value(forKey: "booking_completion_percentage") ?? "")"
                        if(!strP.isEqual("0.00"))
                        {
                           self.SliderVW()
                        }
                    }
                    else{
                        //fail
                        self.scrollOverall.contentSize = CGSize(width: self.scrollOverall.frame.size.width, height: self.txtvnote.frame.maxY+100)
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
    
    //MARK: -   Slide percentage Method
    func SliderVW() -> Void
    {
        DispatchQueue.main.async {
            
            self.myViewSlider = UIView(frame: CGRect(x: 10, y: self.txtvnote.frame.maxY+20, width: self.scrollOverall.frame.size.width - 20, height:40))
            self.myViewSlider.backgroundColor=UIColor.clear
            self.myViewSlider.layer.borderColor=UIColor.lightGray.cgColor
            self.myViewSlider.layer.borderWidth=0.8
            self.myViewSlider.layer.cornerRadius = 6.0
            self.myViewSlider.layer.masksToBounds = true
            self.scrollOverall.addSubview(self.myViewSlider)
            //print("arrmPercentage.count",self.arrmPercentage.count)
            //print("arrmPercentage",self.arrmPercentage)
            
            let lenthh:Int =  Int(self.myViewSlider.frame.width / CGFloat(self.arrmPercentage.count))
            var buttonSlide = UIButton()
            
            var i  = NSInteger(0)
            for dddd in 0 ..< self.arrmPercentage.count
            {
                //print("pages",dddd)
                buttonSlide = UIButton(frame: CGRect(x: i + dddd , y: 0, width: lenthh, height: 40))
                buttonSlide.tag=dddd
                let strtitle = String(format:"%@",(self.arrmPercentage[dddd] as? String)!)
                buttonSlide.setTitle(strtitle, for: .normal)
                buttonSlide.isUserInteractionEnabled=true
                buttonSlide.isSelected = false
                buttonSlide.setTitleColor(UIColor.black, for: .normal)
                buttonSlide.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 12.0)!
                buttonSlide.backgroundColor=UIColor.clear
                self.myViewSlider.addSubview(buttonSlide)
                
                self.arrMParcentageButton.add(buttonSlide)
                
                i =   NSInteger(CGFloat(i) + buttonSlide.frame.size.width)
            }
            
            // slider  font set
            if self.arrmPercentage.count<7 {
                buttonSlide.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14.0)!
                
            }else{
                buttonSlide.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 10.0)!
            }
            
            for x in 0 ..< self.arrmPercentage.count
            {
                let strVal = self.arrmPercentage.object(at: x)
               let booking_completion_percentage = "\(self.dicServiceDetails.value(forKey: "booking_completion_percentage") ?? "")"
                let p:Float = Float(booking_completion_percentage)!
            //    p = p * 100
                print("p :",p)
                
                var completion_percentage = String(p)
                completion_percentage = completion_percentage.replacingOccurrences(of: ".0", with: "", options: NSString.CompareOptions.literal, range: nil)
                completion_percentage = String(format: "%@%@",completion_percentage as CVarArg,"%")
                print("completion_percentage :",completion_percentage)
                
                if (strVal as AnyObject).isEqual(completion_percentage)
                {
                    self.FinalPercentage = completion_percentage as NSString
                    for d in 0 ..<  self.arrMParcentageButton.count
                    {
                        if d <  x+1{
                            let button:UIButton = self.arrMParcentageButton [d] as! UIButton
                            
                            button.isSelected = true
                            button.setTitleColor(UIColor.white, for: .selected)
                            button.backgroundColor = UIColor(red: 53.0/255, green: 101.0/255, blue: 204.0/255, alpha: 1.0)
                            self.myViewSlider .addSubview(button)
                        }
                        else{
                            let button:UIButton = self.arrMParcentageButton [d] as! UIButton
                            
                            button.isSelected = false
                            button.setTitleColor(UIColor.black, for: .normal)
                            button.backgroundColor = UIColor.clear
                            self.myViewSlider .addSubview(button)
                        }
                    }
                }
            }
            
            self.scrollOverall.contentSize = CGSize(width: self.scrollOverall.frame.size.width, height: self.myViewSlider.frame.maxY+100)
        }
    }
    //MARK: -   Note History Method
    @IBAction func pressNoteHistory(_ sender: Any)
    {
        let arrmP :NSArray =   (dicServiceDetails.value(forKey: "booking_update_note") as? NSArray)!
        // let dictemp: NSDictionary = self.arrMDetails[0] as! NSDictionary
        //  let arrmP :NSArray =  dictemp.value(forKey: "booking_update_note") as! NSArray
        let arrBooking_update_note:NSMutableArray = NSMutableArray(array: arrmP)
        
        if arrBooking_update_note.count > 0 {
            let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
            let hh = self.navigationController?.navigationBar.frame.maxY
            var obj = ServiceNoteHistory()
            if hh == -20.0 || navigationBarHeight == 64.0{
                obj = ServiceNoteHistory(nibName: "ServiceNoteHistory", bundle: nil)
            }
            else{
                //X
                obj = ServiceNoteHistory(nibName: "ServiceNoteHistoryX", bundle: nil)
            }
           obj.arrMNote = arrBooking_update_note as NSMutableArray
            self.present(obj, animated: true, completion: nil)
        }
    }
    // MARK: - ack Accept/ Decline pop up view
    func ACKPopUpView() -> Void
    {
        self.myView = UIView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height-64))
        self.myView.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        
        mySecondVw = UIView(frame: CGRect(x: 10, y: 0, width: self.myView.frame.size.width - 20, height:150));
        //   mySecondVw.center = self.myView.center+30
        mySecondVw.frame.origin.y = UIScreen.main.bounds.height / 2 - mySecondVw.frame.size.height
        
        mySecondVw.backgroundColor=UIColor.white
        mySecondVw.layer.cornerRadius = 6.0
        mySecondVw.layer.masksToBounds = true
        self.myView.addSubview(mySecondVw)
        
        let strbooking_requested_date = String(format:"%@",(self.dicServiceDetails.value(forKey: "acknowledge_slot_date") as? String)!)
        let strbooking_requested_time = String(format:"%@",(self.dicServiceDetails.value(forKey: "csk_slot_time") as? String)!)
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 10, width: mySecondVw.frame.size.width, height: 90))
        label1.textAlignment = .center
        label1.textColor = UIColor.black
        label1.backgroundColor = UIColor.clear
        label1.numberOfLines = 4
        // label1.sizeToFit()
        label1.lineBreakMode = .byWordWrapping
        label1.text =  String(format:"Are you available on %@ at %@  for our service engineer to visit your premises?",strbooking_requested_date,strbooking_requested_time)
        label1.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        mySecondVw.addSubview(label1)
        
        
        
        
        /*      let strDT = String(format: "%@ %@", strbooking_requested_date, strbooking_requested_time)
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         formatter.timeZone = TimeZone(abbreviation: "GMT")
         let sDate = formatter.date(from: strDT as String)! as NSDate
         
         formatter.dateFormat = "yyyy-MM-dd HH:mm"
         let strtenantDateTime = formatter.string(from: ((sDate as NSDate) as Date) ) as NSString
         
         label2.text = String(format:"Date : %@",strtenantDateTime)
         */
        
        
        
        let labelbgButton = UILabel(frame: CGRect(x: 0, y: mySecondVw.frame.size.height-50, width: mySecondVw.frame.size.width, height: 50))
        labelbgButton.backgroundColor = UIColor.lightGray
        mySecondVw.addSubview(labelbgButton)
        
        let buttonCancel = UIButton(frame: CGRect(x: 0, y: mySecondVw.frame.size.height-49, width: mySecondVw.frame.size.width/2-1, height: 50))
        buttonCancel.backgroundColor=UIColor.white
        buttonCancel.tag=1
        buttonCancel.setTitle("NO", for: .normal)
        buttonCancel.setTitleColor(UIColor.red, for: .normal)
        buttonCancel.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonCancel.addTarget(self, action: #selector(pressDeclineACK), for: .touchUpInside)
        mySecondVw.addSubview(buttonCancel)
        
        let buttonSubmit = UIButton(frame: CGRect(x: buttonCancel.frame.size.width+1, y: mySecondVw.frame.size.height-49, width: mySecondVw.frame.size.width/2, height: 50))
        buttonSubmit.backgroundColor=UIColor.white
        buttonSubmit.tag=2
        buttonSubmit.setTitle("YES", for: .normal)
        buttonSubmit.setTitleColor(UIColor.black, for: .normal)
        buttonSubmit.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonSubmit.addTarget(self, action: #selector(pressAcceptACK), for: .touchUpInside)
        mySecondVw.addSubview(buttonSubmit)
        
        self.view.addSubview(self.myView)
        
    }
    @objc func pressDeclineACK()
    {
        let subTypeId = String(format:"%@",(self.dicServiceDetails.value(forKey: "subservice_id") as! CVarArg))
        let bookingId = String(format:"%@",(self.dicServiceDetails.value(forKey: "service_boooking_id") as! CVarArg))
        let serviceId = String(format:"%@",(self.dicServiceDetails.value(forKey: "service_id") as! CVarArg))
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.ACKAcceptDecline(strauthkey: strauthkey, booking_id: bookingId, service_id: serviceId, subType_id: subTypeId, status: "N")
        OperationQueue.main.addOperation {
            self.myView.removeFromSuperview()
        }
    }
    @objc func pressAcceptACK()
    {
        let subTypeId = String(format:"%@",(self.dicServiceDetails.value(forKey: "subservice_id") as! CVarArg))
        let bookingId = String(format:"%@",(self.dicServiceDetails.value(forKey: "service_boooking_id") as! CVarArg))
        let serviceId = String(format:"%@",(self.dicServiceDetails.value(forKey: "service_id") as! CVarArg))
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.ACKAcceptDecline(strauthkey: strauthkey, booking_id: bookingId, service_id: serviceId, subType_id: subTypeId, status: "Y")
        OperationQueue.main.addOperation {
            self.myView.removeFromSuperview()
        }
    }
    
    //MARK: -   Ack acceptor Decline Method
    
    func  ACKAcceptDecline(strauthkey:String ,booking_id:String ,service_id:String ,subType_id:String ,status:String)
    {
        
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@%@", Constants.conn.ConnUrl, "tenant/booking_accepted_decline/",booking_id)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        let postString = "service=\(service_id)&subservice=\(subType_id)&status=\(status)"
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
                        OperationQueue.main.addOperation {
                            self.myView.removeFromSuperview()
                            self.navigationController?.popViewController(animated: true)
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
    
    
    //MARK: -  Custom Spinner Method
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
