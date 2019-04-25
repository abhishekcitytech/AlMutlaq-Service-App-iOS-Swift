//
//  CSTaskdetails.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 18/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit
import Foundation
import EventKit
class CSTaskdetails: UIViewController ,UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource
{
    //slot
    var btnChooseTime = UIButton()
     var btnAckChooseDate = UIButton()
    var datePicker = UIDatePicker()
     var strSlotDate = NSString()
      var datePicker1 = UIDatePicker()
    var vwDateACK = UIView()
    
    
    let cellReuseIdentifier = "cell"
    var tblView: UITableView? = UITableView()
    var strSlotTime = NSString()
    var arrMTime = NSMutableArray()
    var vwTimeACK = UIView()
     var PickerTimeACK: UIPickerView!
    var arrMPickerData = NSMutableArray()
    
    
     var vwReschedule = UIView()
       var btnReschuduleDate = UIButton()
      var strRescheduleDate = NSString()
    
      var btnReschuduleTime = UIButton()
     var vwRescheduleTime = UIView()
      var TimePicker = UIDatePicker()
      var strRescheduleTime = NSString()
     var arrRescheduledSlotTIME = NSMutableArray()
   var TimePickercustom: UIPickerView!
  
    
    
     //  var tblViewEngineer: UITableView? = UITableView()
    var PickerEngineer: UIPickerView!
       var arrEngineerList = NSMutableArray()
        var vwEngineer = UIView()
     var strEngineerID = NSString()
     var strEngineerName = NSString()
     var strEngineerChecking = NSString()
  
    
    
    var loadingCircle = UIView()
    var strIdentifier = NSString()
    
    var strPercentage = NSString()
    var FinalPercentage = NSString()
    
    @IBOutlet var lblHeaderTitle: UILabel!
    @IBOutlet var scrollOverall: UIScrollView!
    @IBOutlet var txtservicetype: UITextField!
    
    @IBOutlet var txtSubType: UITextField!
    @IBOutlet var viewtop: UIView!
    
    @IBOutlet var viewGrayout: UIView!
    
    @IBOutlet var lbldate: UILabel!
    @IBOutlet var lblbuildingflatno: UILabel!
    @IBOutlet var lbladdress: UILabel!
    
    @IBOutlet var imgvCalendar: UIImageView!
    @IBOutlet var imgvMap: UIImageView!
    @IBOutlet var imgvBuilding: UIImageView!
    @IBOutlet var imgvBooking: UIImageView!
    
    @IBOutlet var lblJobPosting: UILabel!
    
    @IBOutlet var lblReportingDate: UILabel!
    
    @IBOutlet var vwDate1: UIView!
    
    @IBOutlet var vwDate2: UIView!
    @IBOutlet var lblJobPostingDate2: UILabel!
    
    
    @IBOutlet var txtvnote: UITextView!
    
    @IBOutlet var VwMain: UIView!
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
    
    
    @IBOutlet var btnNoteHistory: UIButton!
    
     var tapGesture = UITapGestureRecognizer()
    var mainBg = UIView()
    var bgVwHeader = UIView()
    var btnDonepdf = UIButton()
    var cellImage = UIImageView()
    
    
    var mySecondVw = UIView()
    var myView = UIView()
    var viewWorkStatus = UIView()
    var arrmPercentage = NSMutableArray()
      var scrollPercentage = UIScrollView()
    
    var imgviconSlide = UIImageView()
    var myViewSlider = UIView()
    var myView1 = UIView()
    var lblSmallPercentage = UILabel()
    
    var textViewACKNote = UITextView()
      var scrollViewAcK  = UIScrollView()
    
    var textViewSatusUpdateNote = UITextView()
    var txtEngineername = UITextField()
    
    var arrMDetails = NSArray()
    
    var SegmentIndexYN = NSString()
    var mySegmentedControl = UISegmentedControl()
    var mySlider = UISegmentedControl()
    var SView = UIView()
    var IntSlider:Int = 0
    var buttonSlide = UIButton()
    
    var arrMParcentageButton = NSMutableArray()
    
    
   
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchDetails(strauthkey: strauthkey, strbookingID: strIdentifier as String)
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
         scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: txtvnote.frame.maxY+20)
     
      
        viewtop.layer.shadowColor = UIColor.lightGray.cgColor
        viewtop.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewtop.layer.shadowRadius = 0.0
        viewtop.layer.shadowOpacity = 2.0
        viewtop.layer.masksToBounds = false
        
        
        imgvBooking.layer.borderWidth = 1.0
        imgvBooking.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        imgvBooking.layer.cornerRadius = 4.0
        imgvBooking.layer.masksToBounds = true
        
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

        VwMain.layer.borderWidth = 1.0
        VwMain.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        VwMain.layer.cornerRadius = 4.0
        VwMain.layer.masksToBounds = true
        
        self.VwBooking.isHidden = true
        self.viewONLYBooking1.isHidden = true
        
        self.vwDate2.isHidden = true
        self.vwDate1.isHidden = true
        
        self.btnNoteHistory.isHidden = true
        
        
      
    }
    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func mySliderChanged(_ sender:UISegmentedControl!)
    {
        // let strPercentageValue = "\(arrmPercentage[(sender.tag)])" as NSString
        
        let st = arrmPercentage.object(at: sender.selectedSegmentIndex)
        FinalPercentage = st as! NSString
        print(st)
        
        IntSlider = self.mySlider.selectedSegmentIndex
        var frame = CGRect ()
        frame = self.SView.frame
        frame.size.width = (self.mySlider.frame.width / CGFloat(self.mySlider.numberOfSegments)) * CGFloat(self.mySlider.selectedSegmentIndex)
        self.SView.frame = frame
        
    }
   
    //MARK: -   fetchDetails Method
    func fetchDetails(strauthkey:String, strbookingID:String)
    {
        print("selected bookingID", strbookingID)
        
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@%@", Constants.conn.ConnUrl, "customer_service_center/selected-date-servicedetails/", strbookingID)
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
                    print("dictempdictempdictempdictempdictemp -> \(dictemp)")
                    
                    let message_code =  String(format: "%@", dictemp.value(forKey: "message_code")as! CVarArg)
                    print("message_code",message_code)
                    if (message_code == "1")
                    {
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        self.arrMDetails = NSMutableArray(array: arrm1)
                        
                        
                        OperationQueue.main.addOperation
                            {
                                self.hideLoadingMode()
                                let dictemp: NSDictionary = self.arrMDetails[0] as! NSDictionary
                                
                                let strservicename = String(format:"%@",(dictemp.value(forKey: "service_name") as? String)!)
                             //   let strbookingdate = String(format:"%@",(dictemp.value(forKey: "booking_requested_date") as! CVarArg))
                                let strbuildingno = String(format:"%@",(dictemp.value(forKey: "building_no") as! CVarArg))
                                let strflatno = String(format:"%@",(dictemp.value(forKey: "flat_no")  as! CVarArg))
                                let straddress = String(format:"%@",(dictemp.value(forKey: "building_address")  as! CVarArg))
                                let strbookingnotes = String(format:"%@",(dictemp.value(forKey: "booking_notes") as! CVarArg))
                                let strtenantname = String(format:"%@",(dictemp.value(forKey: "tenant_name") as? String)!)
                                
                                self.lblHeaderTitle.text=NSString(format:"%@",strservicename) as String
                                self.txtservicetype.text=NSString(format:"Tenant: %@",strtenantname) as String
                                self.txtSubType.text = self.nullToNil(value: dictemp.value(forKey: "subservice_name") as AnyObject) as? String
                                //NSString(format:" %@", String(format: "%@", dictemp.value(forKey: "subservice_name") as! CVarArg) as NSString) as String
                                // self.lbldate.text=strbookingdate
                                self.lblbuildingflatno.text=NSString(format:"%@, %@", strbuildingno,strflatno) as String
                                self.lbladdress.text=NSString(format:" %@", straddress) as String
                                self.txtvnote.text=strbookingnotes
                                
                                // TAP Gesture
                                self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.myviewTapped(_:)))
                                self.tapGesture.numberOfTapsRequired = 1
                                self.tapGesture.numberOfTouchesRequired = 1
                                self.imgvBooking.addGestureRecognizer(self.tapGesture)
                                
                                let strUrl = String(format: "%@", dictemp.value(forKey: "booking_image") as! CVarArg)
                                if(strUrl .isEqual("")){
                                    self.imgvBooking.image=UIImage(named: "serviceimagebg.png")
                                }
                                else{
                                    self.imgvBooking.isUserInteractionEnabled = true
                                    self.imgvBooking.backgroundColor = UIColor.white
                                    let imageUrl = dictemp.value(forKey: "booking_image") as! String
                                    self.imgvBooking.imageFromURL(urlString: imageUrl)
                                    
                                    /* DispatchQueue.global(qos: .background).async {
                                     // Background Thread
                                     let imageUrl = dictemp.value(forKey: "booking_image") as! String
                                     let url = URL(string: imageUrl)
                                     let imageData:NSData = NSData(contentsOf: url!)!
                                     DispatchQueue.main.async {
                                     // Run UI Updates or call completion block
                                     self.imgvBooking.backgroundColor = UIColor.white
                                     let image = UIImage(data: imageData as Data)
                                     self.imgvBooking.image = image
                                     }
                                     }*/
                                }
                                self.imgvBooking.layer.borderWidth = 1.0
                                self.imgvBooking.layer.borderColor = UIColor.clear.cgColor
                                self.imgvBooking.layer.cornerRadius = 4.0
                                self.imgvBooking.layer.masksToBounds = true
                                
                                
                                
                                let strstatus = String(format:"%@",(dictemp.value(forKey: "booking_status") as? String)!)
                                let stracknowledged = String(format:"%@",(dictemp.value(forKey: "booking_acknowledge") as? String)!)
                                
                                let booking_accepted =   String(format:"%@",(dictemp.value(forKey: "booking_accepted") as? String)!)
                                if (strstatus == "0")
                                {
                                    //Booked
                                    if (stracknowledged == "N")
                                    {
                                        self.acknowledgementView()
                                    }
                                    else
                                    {
                                        /// ack bt not approve by tenant
                                        if(booking_accepted.isEqual("N") )
                                        {
                                            
                                            let label = UILabel(frame:CGRect(x: 0, y: UIScreen.main.bounds.size.height-50, width: UIScreen.main.bounds.size.width, height: 50))
                                            label.textAlignment = .center
                                            label.textColor = UIColor.black
                                            label.backgroundColor = UIColor.darkGray
                                            label.text = "Tenant approval pending"
                                            label.font = UIFont(name: "Roboto-Regular", size: 18.0)!
                                            self.view.addSubview(label)
                                            
                                        }
                                        else{
                                            /// tenant approve
                                            self.serviceupdateView()
                                        }
                                        
                                    }
                                    
                                }
                                else if (strstatus == "1")
                                {
                                    //Rescheduled
                                    if (stracknowledged == "N")
                                    {
                                        self.acknowledgementView()
                                    }
                                    else
                                    {
                                        self.serviceupdateView()
                                    }
                                }
                                else if (strstatus == "3")
                                {
                                    //Closed
                                    self.serviceclosedView()
                                }
                                else if (strstatus == "4")
                                {
                                    //Cancel
                                    self.serviceCancelView()
                                }
                                self.SetupFullView()
                        }
                        //  self.hideLoadingMode()
                        
                        
                    }
                    else    if (message_code == "0")
                    { // error
                        let uiAlert = UIAlertController(title: "", message: "Network error.", preferredStyle: UIAlertControllerStyle.alert)
                        self.present(uiAlert, animated: true, completion: nil)
                        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            print("Click of default button")
                        }))
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
        OperationQueue.main.addOperation
            {
                self.hideLoadingMode()
        }
    }
    
    // MARK: - SetupFullView VW
    func SetupFullView() -> Void
    {
        OperationQueue.main.addOperation{
            let dicServiceDetails: NSDictionary = self.arrMDetails[0] as! NSDictionary
            
            
            let strAck = dicServiceDetails.value(forKey: "booking_acknowledge") as? String
            //let booking_accepted = dicServiceDetails.value(forKey: "booking_accepted") as? String
            if(strAck!.isEqual("N") )
            {
                // ack bt tenant  approve
                self.VwBooking.isHidden = true
                self.viewONLYBooking1.isHidden = false
                
                var strtenantbooking = NSString(format:"%@", (dicServiceDetails.value(forKey: "tenant_slot_time") as! String)) as String
                strtenantbooking = strtenantbooking.replacingOccurrences(of: "-", with: "  -  ", options: NSString.CompareOptions.literal, range: nil)
                self.lblONLYRequested.text = NSString(format:"%@", strtenantbooking) as String
                
                
                
                self.vwDate2.isHidden = true
                self.vwDate1.isHidden = false
                self.lblJobPostingDate2.text = NSString(format:"%@", (dicServiceDetails.value(forKey: "tenant_slot_date") as! String)) as String
                
            }
            else
            {
                self.vwDate1.isHidden = true
                self.vwDate2.isHidden = false
                self.lblJobPosting.text = NSString(format:"%@", (dicServiceDetails.value(forKey: "tenant_slot_date") as! CVarArg)) as String
                let ResudlingDate =  NSString(format:"%@", (dicServiceDetails.value(forKey: "acknowledge_requested_date") as! CVarArg)) as String
                
                if(ResudlingDate.isEqual("") )
                {
                    self.lblReportingDate.text = NSString(format:"%@", (dicServiceDetails.value(forKey: "acknowledge_slot_date") as! CVarArg)) as String
                }
                else{
                    self.lblReportingDate.text = ResudlingDate
                }

                /* if(booking_accepted!.isEqual("N") )
                 {
                 // ack bt tenant not approve
                 self.VwBooking.isHidden = true
                 self.viewONLYBooking1.isHidden = false
                 
                 var strtenantbooking = NSString(format:"%@", (dicServiceDetails.value(forKey: "tenant_slot_time") as! String)) as String
                 strtenantbooking = strtenantbooking.replacingOccurrences(of: "-", with: "  -  ", options: NSString.CompareOptions.literal, range: nil)
                 self.lblONLYRequested.text = NSString(format:"%@", strtenantbooking) as String
                 
                 }else{*/
                
                // ack bt tenant  approve
                self.VwBooking.isHidden = false
                self.viewONLYBooking1.isHidden = true
                
                var strtenantbooking = NSString(format:"%@", (dicServiceDetails.value(forKey: "tenant_slot_time") as! String)) as String
                strtenantbooking = strtenantbooking.replacingOccurrences(of: "-", with: "  -  ", options: NSString.CompareOptions.literal, range: nil)
                self.lblRequested.text = NSString(format:"%@", strtenantbooking) as String
                
                var stCskrbooking = NSString(format:"%@", (dicServiceDetails.value(forKey: "csk_slot_time") as! String)) as String
                stCskrbooking = stCskrbooking.replacingOccurrences(of: "-", with: "  -  ", options: NSString.CompareOptions.literal, range: nil)
                
                if(ResudlingDate.isEqual("") )
                {
                     self.lblReportingTime.text = NSString(format:"%@", stCskrbooking) as String
                }
                else{
                     self.lblReportingTime.text = NSString(format:"%@", (dicServiceDetails.value(forKey: "acknowledge_requested_time") as! CVarArg)) as String
                }
    
            }
            
            let dictemp: NSDictionary = self.arrMDetails[0] as! NSDictionary
            let arrmP :NSArray =  dictemp.value(forKey: "booking_update_note") as! NSArray
            let arrBooking_update_note:NSMutableArray = NSMutableArray(array: arrmP)
            if arrBooking_update_note.count == 0
            {
                self.btnNoteHistory.isHidden=true
            }
            else{
                self.btnNoteHistory.isHidden=false
            }
        }
    }
    
    // MARK: - serviceupdateView Method
    func serviceupdateView() -> Void
    {
        
        let buttonServiceupdate = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height-50, width: UIScreen.main.bounds.size.width, height: 50))
        buttonServiceupdate.backgroundColor=UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0)
        buttonServiceupdate.tag=2
        buttonServiceupdate.setTitle("Update Service Status", for: .normal)
        buttonServiceupdate.setTitleColor(UIColor.white, for: .normal)
        buttonServiceupdate.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonServiceupdate.addTarget(self, action: #selector(pressServiceupdate), for: .touchUpInside)
        buttonServiceupdate.layer.cornerRadius = 0.0
        buttonServiceupdate.layer.masksToBounds = true
        self.view.addSubview(buttonServiceupdate)
    }
    @objc func pressServiceupdate()
    {
        //// Percentage  service
        let dictemp1 = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp1.value(forKey: "token") as! CVarArg)
        self.fetchACKpercentage(strauthkey: strauthkey)
        
    }
    // MARK: - closedUpdateview Method
    func serviceclosedView() -> Void
    {
        let buttonClosed = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height-50, width: UIScreen.main.bounds.size.width, height: 50))
        buttonClosed.backgroundColor=UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1.0)
        buttonClosed.tag=1
        buttonClosed.setTitle("Closed", for: .normal)
        buttonClosed.setTitleColor(UIColor.white, for: .normal)
        buttonClosed.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonClosed.addTarget(self, action: #selector(pressClosed), for: .touchUpInside)
        buttonClosed.layer.cornerRadius = 0.0
        buttonClosed.layer.masksToBounds = true
        self.view.addSubview(buttonClosed)
    }
    @objc func pressClosed(){
        print("Button Closed")
    }
    
    // MARK: - CancelUpdateview Method
    func serviceCancelView() -> Void
    {
        let buttonCancel = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height-50, width: UIScreen.main.bounds.size.width, height: 50))
        buttonCancel.backgroundColor=UIColor.red
        buttonCancel.tag=1
        buttonCancel.setTitle("Cancelled", for: .normal)
        buttonCancel.setTitleColor(UIColor.white, for: .normal)
        buttonCancel.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonCancel.addTarget(self, action: #selector(pressCancel), for: .touchUpInside)
        buttonCancel.layer.cornerRadius = 0.0
        buttonCancel.layer.masksToBounds = true
        self.view.addSubview(buttonCancel)
    }
    @objc func pressCancel(){
        print("Button Cancel")
    }
    // MARK: - acknowledgementView Method
    func acknowledgementView() -> Void
    {
        self.hideLoadingMode()
        let buttonAcknowledgement = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height-50, width: UIScreen.main.bounds.size.width, height: 50))
        buttonAcknowledgement.backgroundColor=UIColor.darkGray
        buttonAcknowledgement.tag=1
        buttonAcknowledgement.setTitle("Acknowledge", for: .normal)
        buttonAcknowledgement.setTitleColor(UIColor.white, for: .normal)
        buttonAcknowledgement.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonAcknowledgement.addTarget(self, action: #selector(pressAcknowledgement), for: .touchUpInside)
        buttonAcknowledgement.layer.cornerRadius = 0.0
        buttonAcknowledgement.layer.masksToBounds = true
        self.view.addSubview(buttonAcknowledgement)
    }
    @objc func pressAcknowledgement(){
        
            self.acknowledgementPopUpView()
      
        print("Button Acknowledgement")
        
    }
    
    // MARK: - acknowledgement Popup View Method
    func acknowledgementPopUpView() -> Void
    {
        self.myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        self.myView.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        
        self.scrollViewAcK  = UIScrollView(frame: CGRect(x: 0, y: 50, width: self.myView.frame.size.width, height: UIScreen.main.bounds.height-50))
        self.scrollViewAcK.delegate = self
        scrollViewAcK.center = self.myView.center
        self.scrollViewAcK.contentSize = CGSize(width: scrollViewAcK.frame.size.width, height: scrollViewAcK.frame.size.height)
        self.scrollViewAcK.backgroundColor = UIColor.clear
        self.myView.addSubview(self.scrollViewAcK)
        
        mySecondVw = UIView(frame: CGRect(x: 10, y: 0, width: self.scrollViewAcK.frame.size.width - 20, height:400));
        mySecondVw.center = self.scrollViewAcK.center
        mySecondVw.backgroundColor=UIColor.white
        mySecondVw.layer.cornerRadius = 6.0
        mySecondVw.layer.masksToBounds = true
        self.scrollViewAcK.addSubview(mySecondVw)
        
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 15, width: mySecondVw.frame.size.width, height: 20))
        label1.textAlignment = .center
        label1.textColor = UIColor.black
        label1.backgroundColor = UIColor.clear
        label1.text = "Acknowledgement"
        label1.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        mySecondVw.addSubview(label1)
        
        
        
        
        
        let label2 = UILabel(frame: CGRect(x: 80, y: label1.frame.maxY+5, width: mySecondVw.frame.size.width-80, height: 20))
        label2.textAlignment = .left
        label2.backgroundColor = UIColor.clear
        label2.textColor = UIColor.gray
        
        label2.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        mySecondVw.addSubview(label2)
        
        
        OperationQueue.main.addOperation {
            
            let dictemp: NSDictionary = self.arrMDetails[0] as! NSDictionary
            
        //    let strbooking_requested_date = String(format:"Booking date : %@",(dictemp.value(forKey: "booking_requested_date") as? String)!)
         /*   let strbooking_requested_time = String(format:"%@",(dictemp.value(forKey: "booking_requested_time") as? String)!)
            let strDT = String(format: "%@", strbooking_requested_date)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formatter.timeZone = TimeZone(abbreviation: "GMT")
            let sDate = formatter.date(from: strDT as String)! as NSDate
            
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let strtenantDateTime = formatter.string(from: ((sDate as NSDate) as Date) ) as NSString
            */
            label2.text = String(format:"Requested Date : %@", (self.nullToNil(value: dictemp.value(forKey: "tenant_slot_date") as AnyObject) as? String)!)
           
        }
        
        
        let label3 = UILabel(frame: CGRect(x: 80, y: label2.frame.maxY+5, width: mySecondVw.frame.size.width - 80, height: 20))
        label3.textAlignment = .left
        label3.backgroundColor = UIColor.clear
        label3.textColor = UIColor.gray
        OperationQueue.main.addOperation {
            
            let dictemp: NSDictionary = self.arrMDetails[0] as! NSDictionary
            label3.text = String(format:"Requested Slot  : %@",(dictemp.value(forKey: "tenant_slot_time") as? String)!)
        }
        label3.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        mySecondVw.addSubview(label3)
        
        btnAckChooseDate = UIButton(frame: CGRect(x: 10, y: label3.frame.maxY+10, width:  mySecondVw.frame.size.width - 20, height: 35))
        btnAckChooseDate.tag=1
        btnAckChooseDate.setTitle("Choose reporting date", for: .normal)
        btnAckChooseDate.setTitleColor(UIColor.darkGray, for: .normal)
        btnAckChooseDate.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        btnAckChooseDate.backgroundColor=UIColor.white
        btnAckChooseDate.addTarget(self, action: #selector(pressChooseDate), for: .touchUpInside)
        let border = CALayer()
        let width = CGFloat(0.8)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: btnAckChooseDate.frame.size.height - width, width: btnAckChooseDate.frame.size.width, height: btnAckChooseDate.frame.size.height)
        border.borderWidth = width
        btnAckChooseDate.layer.addSublayer(border)
        btnAckChooseDate.layer.masksToBounds = true
        mySecondVw.addSubview(btnAckChooseDate)
        
        let imgviconAckChooseDate = UIImageView(frame: CGRect(x: btnAckChooseDate.frame.maxX - 48, y: 5.5, width: 24, height: 24))
        imgviconAckChooseDate.backgroundColor = UIColor.clear
        imgviconAckChooseDate.image = UIImage(named:"clock")
        btnAckChooseDate.addSubview(imgviconAckChooseDate)
        
        btnChooseTime = UIButton(frame: CGRect(x: 10, y: btnAckChooseDate.frame.maxY+10, width:  mySecondVw.frame.size.width - 20, height: 35))
        btnChooseTime.tag=1
        btnChooseTime.setTitle("Choose reporting time", for: .normal)
        btnChooseTime.setTitleColor(UIColor.darkGray, for: .normal)
        btnChooseTime.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        self.btnChooseTime.backgroundColor=UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 0.90)
        self.btnChooseTime.isUserInteractionEnabled = false
      
        btnChooseTime.addTarget(self, action: #selector(pressChooseSlotTime), for: .touchUpInside)
        let border1 = CALayer()
        let width1 = CGFloat(0.8)
        border1.borderColor = UIColor.lightGray.cgColor
        border1.frame = CGRect(x: 0, y: btnChooseTime.frame.size.height - width1, width: btnChooseTime.frame.size.width, height: btnChooseTime.frame.size.height)
        border1.borderWidth = width1
        btnChooseTime.layer.addSublayer(border1)
        btnChooseTime.layer.masksToBounds = true
        mySecondVw.addSubview(btnChooseTime)
        
        let imgviconAckChooseTime = UIImageView(frame: CGRect(x: btnChooseTime.frame.maxX - 48, y: 5.5, width: 24, height: 24))
        imgviconAckChooseTime.backgroundColor = UIColor.clear
        imgviconAckChooseTime.image = UIImage(named:"clock")
        btnChooseTime.addSubview(imgviconAckChooseTime)
        
        textViewACKNote = UITextView(frame: CGRect(x: 10, y: btnChooseTime.frame.maxY+10, width: mySecondVw.frame.size.width - 20, height: 150));
        textViewACKNote.textAlignment = NSTextAlignment.justified
        textViewACKNote.backgroundColor = UIColor.white
        textViewACKNote.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        textViewACKNote.layer.borderWidth = 1.0
        textViewACKNote.layer.cornerRadius=4.0
        textViewACKNote.layer.masksToBounds=true
        textViewACKNote.delegate=self
        textViewACKNote.textColor=UIColor.black
        textViewACKNote.font = UIFont(name: "Roboto-Regular", size: 15.0)!
        mySecondVw.addSubview(textViewACKNote)
        
        let labelbgButton = UILabel(frame: CGRect(x: 0, y: mySecondVw.frame.size.height-50, width: mySecondVw.frame.size.width, height: 50))
        labelbgButton.backgroundColor = UIColor.lightGray
        mySecondVw.addSubview(labelbgButton)
        
        let buttonCancel = UIButton(frame: CGRect(x: 0, y: mySecondVw.frame.size.height-49, width: mySecondVw.frame.size.width/2-1, height: 50))
        buttonCancel.backgroundColor=UIColor.white
        buttonCancel.tag=1
        buttonCancel.setTitle("Cancel", for: .normal)
        buttonCancel.setTitleColor(UIColor.red, for: .normal)
        buttonCancel.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonCancel.addTarget(self, action: #selector(pressCancelACK), for: .touchUpInside)
        mySecondVw.addSubview(buttonCancel)
        
        let buttonSubmit = UIButton(frame: CGRect(x: buttonCancel.frame.size.width+1, y: mySecondVw.frame.size.height-49, width: mySecondVw.frame.size.width/2, height: 50))
        buttonSubmit.backgroundColor=UIColor.white
        buttonSubmit.tag=2
        buttonSubmit.setTitle("Submit", for: .normal)
        buttonSubmit.setTitleColor(UIColor.black, for: .normal)
        buttonSubmit.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonSubmit.addTarget(self, action: #selector(pressSubmitACK), for: .touchUpInside)
        mySecondVw.addSubview(buttonSubmit)
        
        self.view.addSubview(self.myView)
        
    }
    
    // MARK: - Choose Ack Date btn
    @objc func pressChooseDate(sender: UIButton)
    {
        self.removeAckfeild()
        self.datePickerChooseDate()
        
    }
    
    // MARK: - ack SlotTime Pop  Method
    func datePickerChooseDate() {
        
        
        self.vwTimeACK.removeFromSuperview()
        self.vwDateACK.removeFromSuperview()
        
        vwDateACK =  UIView(frame: CGRect(x: 0, y:  UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200))
        
        vwDateACK.backgroundColor = UIColor(red: 231/255, green: 235/255, blue: 245/255, alpha: 1.0)
        
        let buttonDone = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width-80, y: 0, width: 80, height: 30))
        buttonDone.backgroundColor = UIColor.clear
        buttonDone.tag=1
        buttonDone.setTitle("Done", for: .normal)
        buttonDone.setTitleColor(UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0), for: .normal)
        buttonDone.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonDone.addTarget(self, action: #selector(pressDoneDate1), for: .touchUpInside)
        vwDateACK.addSubview(buttonDone)
        
        datePicker1 = UIDatePicker(frame: CGRect(x: 0, y:buttonDone.frame.maxY, width: UIScreen.main.bounds.size.width, height:170))
        datePicker1.datePickerMode = .date
        datePicker1.backgroundColor = UIColor.white
        self.datePicker1.minimumDate = Date()
        
        
        
        // Booking date minimum date set
        let dictemp: NSDictionary = self.arrMDetails[0] as! NSDictionary
        let strtenant_slot_datee = String(format:"%@",(dictemp.value(forKey: "tenant_slot_date") as? String)!)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        let sDate = formatter.date(from: strtenant_slot_datee as String)! as NSDate
      
        print("dddddddd %@",sDate)
        let dateA = Date()
        // Compare them
        switch dateA.compare(sDate as Date) {
      
        case .orderedAscending:
             print("current low")
              datePicker1.date = sDate as Date
             self.datePicker1.minimumDate = sDate as Date
        case .orderedSame:
             datePicker1.date = Date()
        case .orderedDescending:
             print("current big")
              datePicker1.date = Date()
        }
        
        
       
         /// end /////////
        
        
      
        if strSlotDate == "" {
            datePicker1.date = Date()
        }
        else{
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(abbreviation: "GMT")
            let sDate = formatter.date(from: strSlotDate as String)! as NSDate
            datePicker1.date = sDate as Date
        }
        
        
        datePicker1.addTarget(self, action:    #selector(dateUpdated(_:)), for: .valueChanged)
        vwDateACK.addSubview(datePicker1)
       self.myView.addSubview(vwDateACK)
    }
    @IBAction func dateUpdated(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter ()
        formatter.dateFormat = "yyyy-MM-dd"
        
        strSlotDate = formatter.string(from: (datePicker.date as NSDate) as Date) as NSString
        
    }
    
    @objc func pressDoneDate1()
    {
        let formatter = DateFormatter ()
        formatter.dateFormat = "yyyy-MM-dd"
        let dictemp: NSDictionary = self.arrMDetails[0] as! NSDictionary
        let strtenant_slot_datee = String(format:"%@",(dictemp.value(forKey: "tenant_slot_date") as? String)!)
        let sDate = formatter.date(from: strtenant_slot_datee as String)! as NSDate
        
        print("dddddddd %@",sDate)
        let dateA = Date()
        var strDateSelect =  String()
        
        switch dateA.compare(sDate as Date) {
        case .orderedAscending:
            print("current low")
            strDateSelect = formatter.string(from: sDate as Date) 
        case .orderedSame:
            strDateSelect = formatter.string(from: Date())
        case .orderedDescending:
            print("current big")
            strDateSelect = formatter.string(from: Date())
        }
        
        if strSlotDate.isEqual(to: "") {
            strSlotDate =  strDateSelect as NSString
            //strString =  String(format:" %@", strDateSelect as NSString)
        }
        else{
           // strString =  String(format:" %@",strSlotDate as String)
        }
        
        btnAckChooseDate.setTitle(strSlotDate as String, for: .normal)
        vwDateACK.removeFromSuperview()
        self.view.endEditing(true)
        
        strSlotTime = ""
        btnChooseTime.setTitle("Choose reporting time", for: .normal)
        self.btnChooseTime.backgroundColor=UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 0.90)
        self.btnChooseTime.isUserInteractionEnabled = false
        
        let dictemp1 = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp1.value(forKey: "token") as! CVarArg)
        self.fetchACKSlotTime(strauthkey: strauthkey,strdate: strSlotDate as String)
       
    }
    func removeAckfeild(){
        textViewACKNote.resignFirstResponder()
        vwDateACK.removeFromSuperview()
        txtvnote.resignFirstResponder()
        tblView?.removeFromSuperview()
    }
    
    // MARK: - press ACK slot time  button
    @objc func pressChooseSlotTime(sender: UIButton)
    {
        self.removeAckfeild()
        self.popupListSlotTime()
    }
    
    // MARK: - ACK SlotTime Pop   Method
    func popupListSlotTime()
    {
        if arrMPickerData.count > 0 {
        txtvnote.resignFirstResponder()
        self.vwTimeACK.removeFromSuperview()
        self.vwDateACK.removeFromSuperview()
        
        vwTimeACK = UIView(frame: CGRect(x: 0, y:  UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200))
        vwTimeACK.backgroundColor = UIColor(red: 231/255, green: 235/255, blue: 245/255, alpha: 1.0)
        
        let buttonDone = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width-80, y: 0, width: 80, height: 30))
        buttonDone.backgroundColor = UIColor.clear
        buttonDone.tag=1
        buttonDone.setTitle("Done", for: .normal)
        buttonDone.setTitleColor(UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0), for: .normal)
        buttonDone.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonDone.addTarget(self, action: #selector(pressDoneTimeACK), for: .touchUpInside)
        vwTimeACK.addSubview(buttonDone)
        
        PickerTimeACK = UIPickerView (frame: CGRect(x: 0, y:buttonDone.frame.maxY, width: UIScreen.main.bounds.size.width, height:170))
        PickerTimeACK.dataSource = self
        PickerTimeACK.delegate = self
        PickerTimeACK.showsSelectionIndicator = true
        PickerTimeACK.backgroundColor = UIColor.white
        
        vwTimeACK.addSubview(PickerTimeACK)
        self.myView.addSubview(vwTimeACK)
        }
    }
    @objc func pressDoneTimeACK()
    {
        if strSlotTime == "" {
            strSlotTime = arrMPickerData[0] as! NSString
        }
        btnChooseTime.setTitle(strSlotTime as String, for: .normal)
        self.view.endEditing(true)
        self.vwTimeACK.removeFromSuperview()
    }
    @objc func pressCancelACK()
    {
        self.myView.removeFromSuperview()
    }
    @objc func pressSubmitACK()
    {
        if (strSlotTime.isEqual(to: "")){
            let uiAlert = UIAlertController(title: "", message: "Please select slot time .", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if (strSlotDate.isEqual(to: "")){
            let uiAlert = UIAlertController(title: "", message: "Please select slot date .", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            self.acknowledgeBookedServiceMethod(strbookingID: strIdentifier as String,slotdate:strSlotDate as String , slottime:strSlotTime as String , strnote: textViewACKNote.text as String)
        }
    }
    
    // MARK: - Reschedule workstatus Popup  View Method
    func workstatusPopUpView() -> Void
    {
        let di = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", di.value(forKey: "token") as! CVarArg)
        self.fetchengineerlist(strauthkey: strauthkey)
     
        arrmPercentage.removeAllObjects()
        let parts =  self.strPercentage.components(separatedBy: ",")
        print(parts.count)
        print(parts)
        
        for part in parts
        {
            let strPercent = String(format: "%@%@",part,"%")
            arrmPercentage.add(strPercent)
            print(strPercent)
        }
        print(arrmPercentage)
        
        self.viewWorkStatus = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        self.viewWorkStatus.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        
        scrollPercentage = UIScrollView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-20))
        scrollPercentage.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-20)
        scrollPercentage.backgroundColor=UIColor.clear
        self.viewWorkStatus.addSubview(scrollPercentage)
        
        let ditemp: NSDictionary = self.arrMDetails[0] as! NSDictionary
        let completion_percentage =  String(format: "%@", ditemp.value(forKey: "booking_completion_percentage") as! CVarArg)
        if (completion_percentage != "100")
        {
              myView1 = UIView(frame: CGRect(x: 10, y: 0, width: self.viewWorkStatus.frame.size.width - 20, height:440))
        }else{
              myView1 = UIView(frame: CGRect(x: 10, y: 0, width: self.viewWorkStatus.frame.size.width - 20, height:380))
        }
        myView1.center = self.viewWorkStatus.center
        myView1.backgroundColor=UIColor.white
        myView1.layer.cornerRadius = 6.0
        myView1.layer.masksToBounds = true
        scrollPercentage.addSubview(myView1)
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 15, width: myView1.frame.size.width, height: 20))
        label1.textAlignment = .center
        label1.textColor = UIColor.black
        label1.backgroundColor = UIColor.clear
        label1.text = "Service Status"
        label1.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        myView1.addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: 0, y: label1.frame.maxY+5, width: myView1.frame.size.width, height: 20))
        label2.textAlignment = .center
        label2.backgroundColor = UIColor.clear
        label2.textColor = UIColor.gray
        let Currentdate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let CurrentdateTime = formatter.string(from: Currentdate)
        label2.text = CurrentdateTime
        label2.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        myView1.addSubview(label2)
        
        self.view.addSubview(self.viewWorkStatus)
        
        myViewSlider = UIView(frame: CGRect(x: 10, y: label2.frame.maxY+20, width: myView1.frame.size.width - 20, height:40))
        myViewSlider.backgroundColor=UIColor.clear
        myViewSlider.layer.borderColor=UIColor.lightGray.cgColor
        myViewSlider.layer.borderWidth=0.8
        myViewSlider.layer.cornerRadius = 6.0
        myViewSlider.layer.masksToBounds = true
        myView1.addSubview(myViewSlider)
        
        let lenthh:Int =  Int(myViewSlider.frame.width / CGFloat(arrmPercentage.count))
    
        var i  = NSInteger(0)
        for dddd in 0 ..< arrmPercentage.count
        {
            buttonSlide = UIButton(frame: CGRect(x: i + dddd , y: 0, width: lenthh, height: 40))
            buttonSlide.tag=dddd
            let strtitle = String(format:"%@",(arrmPercentage[dddd] as? String)!)
            buttonSlide.setTitle(strtitle, for: .normal)
            buttonSlide.isUserInteractionEnabled=true
            buttonSlide.isSelected = false
            buttonSlide.setTitleColor(UIColor.black, for: .normal)
            buttonSlide.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 12.0)!
            buttonSlide.addTarget(self, action: #selector(buttonActionPercentageClick), for: .touchUpInside)
            buttonSlide.backgroundColor=UIColor.clear
            myViewSlider.addSubview(buttonSlide)
            
            arrMParcentageButton.add(buttonSlide)
            i =   NSInteger(CGFloat(i) + buttonSlide.frame.size.width)
        }
        
        //for Reschudule date
        if (completion_percentage != "100")                         
        {
            btnReschuduleDate = UIButton(frame: CGRect(x: 10, y:myViewSlider.frame.maxY+10, width: (myView1.frame.size.width - 20)/2-5, height: 40))
            btnReschuduleDate.backgroundColor=UIColor.white
            btnReschuduleDate.tag=2
            btnReschuduleDate.setTitle("Reschedule date", for: .normal)
            btnReschuduleDate.setTitleColor(UIColor.black, for: .normal)
            btnReschuduleDate.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 15.0)!
            btnReschuduleDate.addTarget(self, action: #selector(pressRescheduledDate), for: .touchUpInside)
            btnReschuduleDate.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
            btnReschuduleDate.layer.borderWidth = 1.0
            btnReschuduleDate.layer.cornerRadius=4.0
            btnReschuduleDate.layer.masksToBounds=true
            btnReschuduleDate.isUserInteractionEnabled = true
            
            btnReschuduleTime = UIButton(frame: CGRect(x: btnReschuduleDate.frame.maxX+5, y:myViewSlider.frame.maxY+10, width: (myView1.frame.size.width - 20)/2-5, height: 40))
            btnReschuduleTime.backgroundColor=UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 0.90)
            btnReschuduleTime.isUserInteractionEnabled = false
            btnReschuduleTime.tag=122
            btnReschuduleTime.setTitle("Reschedule time", for: .normal)
            btnReschuduleTime.setTitleColor(UIColor.black, for: .normal)
            btnReschuduleTime.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 15.0)!
            btnReschuduleTime.addTarget(self, action: #selector(pressRescheduledTime), for: .touchUpInside)
            btnReschuduleTime.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
            btnReschuduleTime.layer.borderWidth = 1.0
            btnReschuduleTime.layer.cornerRadius=4.0
            btnReschuduleTime.layer.masksToBounds=true
            
            self.myView1.addSubview(btnReschuduleTime)
            self.myView1.addSubview(btnReschuduleDate)
            textViewSatusUpdateNote = UITextView(frame: CGRect(x: 10, y: btnReschuduleDate.frame.maxY+15, width: myView1.frame.size.width - 20, height: 110));
        }
        else
        {
               textViewSatusUpdateNote = UITextView(frame: CGRect(x: 10, y: myViewSlider.frame.maxY+10, width: myView1.frame.size.width - 20, height: 110));
        }
        textViewSatusUpdateNote.textAlignment = NSTextAlignment.justified
        textViewSatusUpdateNote.backgroundColor = UIColor.white
        textViewSatusUpdateNote.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        textViewSatusUpdateNote.layer.borderWidth = 1.0
        textViewSatusUpdateNote.layer.cornerRadius=4.0
        textViewSatusUpdateNote.layer.masksToBounds=true
        textViewSatusUpdateNote.delegate=self
        textViewSatusUpdateNote.textColor=UIColor.black
        textViewSatusUpdateNote.font = UIFont(name: "Roboto-Regular", size: 15.0)!
        myView1.addSubview(textViewSatusUpdateNote)
        
        txtEngineername = UITextField(frame: CGRect(x: 10, y: textViewSatusUpdateNote.frame.maxY+20, width: myView1.frame.size.width - 20, height: 44));
        txtEngineername.textAlignment = .left
        txtEngineername.backgroundColor = UIColor.white
        txtEngineername.delegate=self
        txtEngineername.placeholder="Engineer"
        txtEngineername.textColor=UIColor.black
        txtEngineername.font = UIFont(name: "Roboto-Regular", size: 15.0)!
        
       let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: txtEngineername.frame.size.height - width, width: txtEngineername.frame.size.width, height: txtEngineername.frame.size.height)
        border.borderWidth = width
        txtEngineername.layer.addSublayer(border)
        txtEngineername.layer.masksToBounds = true
        myView1.addSubview(txtEngineername)
        
        let labelbgButton = UILabel(frame: CGRect(x: 0, y: myView1.frame.size.height-50, width: myView1.frame.size.width, height: 50))
        labelbgButton.backgroundColor = UIColor.lightGray
        myView1.addSubview(labelbgButton)
        
        let buttonCancel = UIButton(frame: CGRect(x: 0, y: myView1.frame.size.height-49.5, width: myView1.frame.size.width/2-0.5, height: 50))
        buttonCancel.backgroundColor=UIColor.white
        buttonCancel.tag=1
        buttonCancel.setTitle("Cancel", for: .normal)
        buttonCancel.setTitleColor(UIColor.red, for: .normal)
        buttonCancel.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonCancel.addTarget(self, action: #selector(pressCancelWS), for: .touchUpInside)
        myView1.addSubview(buttonCancel)
        
        let buttonSubmit = UIButton(frame: CGRect(x: buttonCancel.frame.size.width+0.5, y: myView1.frame.size.height-49.5, width: myView1.frame.size.width/2, height: 50))
        buttonSubmit.backgroundColor=UIColor.white
        buttonSubmit.tag=2
        buttonSubmit.setTitle("Submit", for: .normal)
        buttonSubmit.setTitleColor(UIColor.black, for: .normal)
        buttonSubmit.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonSubmit.addTarget(self, action: #selector(pressSubmitWS), for: .touchUpInside)
        myView1.addSubview(buttonSubmit)
        
        self.view.addSubview(self.viewWorkStatus)
       // slider  font set
        if arrmPercentage.count<7 {
           buttonSlide.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14.0)!
            
        }else{
             buttonSlide.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 10.0)!
        }
        
          /// Reschedule data come
        let dictemp: NSDictionary = self.arrMDetails[0] as! NSDictionary
        let arrmP :NSArray =  dictemp.value(forKey: "booking_update_note") as! NSArray
        let arrBooking_update_note:NSMutableArray = NSMutableArray(array: arrmP)
        if arrBooking_update_note.count > 0
        {
             let dic: NSDictionary = arrBooking_update_note[0] as! NSDictionary
           let strBooking_update_note = dic.value(forKey: "note") as! String
            self.textViewSatusUpdateNote.text=NSString(format:" %@",strBooking_update_note as CVarArg) as String
                self.txtEngineername.text = (dic.value(forKey: "labour_name") as! String)
          
        }
      
       
        for x in 0 ..< arrmPercentage.count
        {
            
            let strVal = arrmPercentage.object(at: x)
            let booking_completion_percentage:Int = dictemp.value(forKey: "booking_completion_percentage") as! Int
            
            var completion_percentage = String(booking_completion_percentage)
            completion_percentage = String(format: "%@%@",completion_percentage as CVarArg,"%")
            
            if (strVal as AnyObject).isEqual(completion_percentage)
            {
        
                FinalPercentage = completion_percentage as NSString
                for d in 0 ..<  arrMParcentageButton.count
                {
                    if d <  x+1{
                        let button:UIButton = arrMParcentageButton [d] as! UIButton
                        
                        button.isSelected = true
                        button.setTitleColor(UIColor.white, for: .selected)
                        button.backgroundColor = UIColor(red: 53.0/255, green: 101.0/255, blue: 204.0/255, alpha: 1.0)
                        self.myViewSlider .addSubview(button)
                    }
                    else{
                        let button:UIButton = arrMParcentageButton [d] as! UIButton
                        
                        button.isSelected = false
                        button.setTitleColor(UIColor.black, for: .normal)
                        button.backgroundColor = UIColor.clear
                        self.myViewSlider .addSubview(button)
                    }
                    
                }
            }
         }
     }
    //
    
    @objc func pressCancelWS()
    {
        self.viewWorkStatus.removeFromSuperview()
    }
    @objc func pressSubmitWS()
    {
        
         if ( FinalPercentage != "100%" && strRescheduleDate == ""  ){
         let uiAlert = UIAlertController(title: "", message: "Reschedule date.", preferredStyle: UIAlertControllerStyle.alert)
         self.present(uiAlert, animated: true, completion: nil)
         uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
         print("Click of default button")
         }))
         }
         else if ( FinalPercentage != "100%" && strRescheduleTime == ""  ){
         let uiAlert = UIAlertController(title: "", message: "Reschedule time.", preferredStyle: UIAlertControllerStyle.alert)
         self.present(uiAlert, animated: true, completion: nil)
         uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
         print("Click of default button")
         }))
         }
         else if (textViewSatusUpdateNote.text=="")
         {
         let uiAlert = UIAlertController(title: "", message: "Please enter update note.", preferredStyle: UIAlertControllerStyle.alert)
         self.present(uiAlert, animated: true, completion: nil)
         uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
         print("Click of default button")
         }))
         }
         else
         {
        self.statusUpdate(strbookingID: strIdentifier as String, strPercentage: FinalPercentage as String, strUpdateNote: textViewSatusUpdateNote.text!, labourName: txtEngineername.text!, labourID: strEngineerID as String, Reschudule_date: strRescheduleDate as String, Reschudule_time: strRescheduleTime as String)

         }
     }
    
    // MARK: - Add Event To Calendar Method
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil)
    {
        DispatchQueue.global(qos: .background).async { () -> Void in
            let eventStore = EKEventStore()
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if (granted) && (error == nil)
                {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = title
                    event.startDate = startDate
                    event.endDate = endDate
                    event.notes = description
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    
                    // 3600 seconds before
                    let alarm:EKAlarm = EKAlarm(relativeOffset: 1)
                    event.alarms = [alarm]
                    
                    do{
                        let strMsg = String(format: "%@ %@ %@ %@","Event is created in your calendar for", self.strRescheduleDate as CVarArg,"at",self.strRescheduleTime as CVarArg)
                        let uiAlert = UIAlertController(title: "", message: strMsg, preferredStyle: UIAlertControllerStyle.alert)
                        self.present(uiAlert, animated: true, completion: nil)
                        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            print("Click of default button")
                        }))
                        print("Saved & Completed")
                        try eventStore.save(event, span: .thisEvent)
                    }
                    catch let e as NSError{
                        print("Not Saved & Not Completed")
                        completion?(false, e)
                        return
                    }
                    completion?(true, nil)
                }
                else
                {
                    print("Error")
                    completion?(false, error as NSError?)
                }
            })
        }
    }
    
    // MARK: - button Action Percentage Click Method
    @objc func buttonActionPercentageClick(sender: UIButton)
    {
        let strPercentageValue = "\(arrmPercentage[(sender.tag)])" as NSString
        print(strPercentageValue)
        FinalPercentage = strPercentageValue
    
        for d in 0 ..<  arrMParcentageButton.count
        {
            if d <  sender.tag + 1
            {
            let button:UIButton = arrMParcentageButton [d] as! UIButton
             DispatchQueue.main.async { [unowned self] in
            button.isSelected = true
            button.setTitleColor(UIColor.white, for: .selected)
            button.backgroundColor =  UIColor(red: 53.0/255, green: 101.0/255, blue: 204.0/255, alpha: 1.0)
            self.myViewSlider .addSubview(button)}
            }
            else{
                let button:UIButton = arrMParcentageButton [d] as! UIButton
                 DispatchQueue.main.async { [unowned self] in
                button.isSelected = false
                button.setTitleColor(UIColor.black, for: .normal)
                button.backgroundColor = UIColor.clear
                self.myViewSlider .addSubview(button)
                }
            }
        }
        
        // for btnReschuduleDate disable or enable
        
       if (FinalPercentage == "100%" || FinalPercentage == "100")
        {
            strRescheduleDate = ""
            vwReschedule.removeFromSuperview()
            btnReschuduleDate.backgroundColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 0.90)
            btnReschuduleDate.isUserInteractionEnabled = false
            btnReschuduleDate.setTitle("Reschedule date", for: .normal)
            
            strRescheduleTime = ""
            vwRescheduleTime.removeFromSuperview()
            btnReschuduleTime.backgroundColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 0.90)
            btnReschuduleTime.isUserInteractionEnabled = false
            btnReschuduleTime.setTitle("Reschedule time", for: .normal)
        }
        else{
            btnReschuduleDate.backgroundColor=UIColor.white
            btnReschuduleDate.isUserInteractionEnabled = true
        }
    }
 // MARK: - button  RescheduledDate Method
    @objc func pressRescheduledDate()
    {
       
        self.vwRescheduleTime.removeFromSuperview()
        self.vwReschedule.removeFromSuperview()
        self.vwEngineer.removeFromSuperview()
        txtEngineername.resignFirstResponder()
        textViewSatusUpdateNote.resignFirstResponder()
        
        vwReschedule = UIView(frame: CGRect(x: 0, y:  UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200))
        vwReschedule.backgroundColor = UIColor(red: 231/255, green: 235/255, blue: 245/255, alpha: 1.0)
        
        let buttonDone = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width-80, y: 0, width: 80, height: 30))
        buttonDone.backgroundColor = UIColor.clear
        buttonDone.tag=1
        buttonDone.setTitle("Done", for: .normal)
        buttonDone.setTitleColor(UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0), for: .normal)
        buttonDone.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonDone.addTarget(self, action: #selector(pressDoneDate), for: .touchUpInside)
        vwReschedule.addSubview(buttonDone)
       datePicker = UIDatePicker(frame: CGRect(x: 0, y:buttonDone.frame.maxY, width: UIScreen.main.bounds.size.width, height:170))
       datePicker.datePickerMode = .date
       datePicker.backgroundColor = UIColor.white
      
        if strRescheduleDate == "" {
            datePicker.date = Date()
        }
        else{
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(abbreviation: "GMT")
            let sDate = formatter.date(from: strRescheduleDate as String)! as NSDate
               datePicker.date = sDate as Date
         }
  
        self.datePicker.minimumDate = Date()
        datePicker.addTarget(self, action:    #selector(dateUpdated1(_:)), for: .valueChanged)
        vwReschedule.addSubview(datePicker)
        //  txtVoucherDate.inputView = datePicker1
        self.viewWorkStatus.addSubview(vwReschedule)
     
    }
    @IBAction func dateUpdated1(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter ()
        formatter.dateFormat = "yyyy-MM-dd"
       strRescheduleDate = formatter.string(from: (datePicker.date as NSDate) as Date) as NSString
     }
    
    @objc func pressDoneDate(){
        let formatter = DateFormatter ()
        formatter.dateFormat = "yyyy-MM-dd"
        var strString =  String()
        if strRescheduleDate.isEqual(to: "") {
            strRescheduleDate =  formatter.string(from: Date() as Date)  as NSString
            strString =  String(format:" %@", formatter.string(from: Date() as Date) as NSString)
        }
        else{
            strString =  String(format:" %@",strRescheduleDate as String)
        }
        btnReschuduleDate.setTitle(strString, for: .normal)
        vwReschedule.removeFromSuperview()
        self.view.endEditing(true)

         strRescheduleTime = ""
         btnReschuduleTime.setTitle("Reschedule time", for: .normal)
        btnReschuduleTime.backgroundColor=UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 0.90)
        btnReschuduleTime.isUserInteractionEnabled = false
  
        
        /// date formating to send date
      /*  let formatterReschedule = DateFormatter ()
        formatterReschedule.dateFormat = "DD-MM-YYYY"
        let strDate =  formatter.date(from: strRescheduleDate as String)
        let strDateString = formatterReschedule.string(from: strDate!)
        print("final format date : %@",strDateString)*/
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchRescheduled_slot(strauthkey: strauthkey, strdate: strRescheduleDate as String)
        
    }
    // MARK: -button  Rescheduled time Method
    @objc func pressRescheduledTime()
    {
        if arrRescheduledSlotTIME.count > 0 {
         self.vwEngineer.removeFromSuperview()
         self.vwReschedule.removeFromSuperview()
        self.vwRescheduleTime.removeFromSuperview()
        txtEngineername.resignFirstResponder()
        textViewSatusUpdateNote.resignFirstResponder()
      
       vwRescheduleTime = UIView(frame: CGRect(x: 0, y:  UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200))
         vwRescheduleTime.backgroundColor = UIColor(red: 231/255, green: 235/255, blue: 245/255, alpha: 1.0)
        
        let buttonDone = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width-80, y: 0, width: 80, height: 30))
        buttonDone.backgroundColor = UIColor.clear
        buttonDone.tag=1
        buttonDone.setTitle("Done", for: .normal)
        buttonDone.setTitleColor(UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0), for: .normal)
        buttonDone.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonDone.addTarget(self, action: #selector(pressDoneTime), for: .touchUpInside)
        vwRescheduleTime.addSubview(buttonDone)
        
       TimePickercustom = UIPickerView (frame: CGRect(x: 0, y:buttonDone.frame.maxY, width: UIScreen.main.bounds.size.width, height:170))
        TimePickercustom.dataSource = self
        TimePickercustom.delegate = self
        TimePickercustom.backgroundColor = UIColor.white
       vwRescheduleTime.addSubview(TimePickercustom)
      self.viewWorkStatus.addSubview(vwRescheduleTime)
        }
    }
    
    @objc func pressDoneTime(){
        if strRescheduleTime == "" {
            strRescheduleTime = arrRescheduledSlotTIME[0] as! NSString
        }
        btnReschuduleTime.setTitle(strRescheduleTime as String, for: .normal)
        vwRescheduleTime.removeFromSuperview()
        self.view.endEditing(true)
     
    }
   
    // MARK: - pickerView Delegates Method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == PickerEngineer{
          return arrEngineerList.count
        } else  if pickerView == PickerTimeACK{
            return arrMPickerData.count
        }
        else{
            return arrRescheduledSlotTIME.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == PickerEngineer{
            let   dicTemp = arrEngineerList.object(at: row) as! NSDictionary
            let str =  String(format: "%@", dicTemp.value(forKey: "engineer_name")as! CVarArg) as NSString
            
            return str as String
        }
        else  if pickerView == PickerTimeACK{
            
            return (arrMPickerData[row] as! String)
          }
        else{
           return (arrRescheduledSlotTIME[row] as! String)
        }
       
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == PickerEngineer{
            strEngineerChecking = "1"
            let   dicTemp = arrEngineerList.object(at: row) as! NSDictionary
            strEngineerName =  String(format: "%@", dicTemp.value(forKey: "engineer_name")as! CVarArg) as NSString
            strEngineerID = String(format: "%@", dicTemp.value(forKey: "engineer_id")as! CVarArg) as NSString
            
            print("Engineer name :%@",strEngineerName)
            print("Engineer strEngineerID :%@",strEngineerID)
        }
        else  if pickerView == PickerTimeACK{
            
            strSlotTime =  NSString(format:"%@",(arrMPickerData.object(at:row) as! String))
           
        }
        else{
            strRescheduleTime = arrRescheduledSlotTIME[row] as! NSString
            print("time picker slot : %@",strRescheduleTime)
        }
     }

   // MARK: -  Engineer list Pop  Method
    func EngineerListPopUp() {
        
        strEngineerChecking = ""
       
          self.vwReschedule.removeFromSuperview()
          self.vwRescheduleTime.removeFromSuperview()
         self.vwEngineer.removeFromSuperview()
         textViewSatusUpdateNote.resignFirstResponder()
        txtEngineername.resignFirstResponder()
         view.endEditing(true)
        vwEngineer = UIView(frame: CGRect(x: 0, y:  UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200))
        vwEngineer.backgroundColor = UIColor(red: 231/255, green: 235/255, blue: 245/255, alpha: 1.0)
        
        let buttonDone = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width-80, y: 0, width: 80, height: 30))
        buttonDone.backgroundColor = UIColor.clear
        buttonDone.tag=1
        buttonDone.setTitle("Done", for: .normal)
        buttonDone.setTitleColor(UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0), for: .normal)
        buttonDone.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonDone.addTarget(self, action: #selector(pressDoneEngineer), for: .touchUpInside)
        vwEngineer.addSubview(buttonDone)
        
        PickerEngineer = UIPickerView (frame: CGRect(x: 0, y:buttonDone.frame.maxY, width: UIScreen.main.bounds.size.width, height:170))
        PickerEngineer.dataSource = self
        PickerEngineer.delegate = self
        PickerEngineer.backgroundColor = UIColor.white
        self.vwEngineer.addSubview(PickerEngineer)
       self.viewWorkStatus.addSubview(vwEngineer)
      
    }
     @objc func pressDoneEngineer(){
        
        if strEngineerName.isEqual(to: "") ||   strEngineerChecking != "1" {
            let   dicTemp = arrEngineerList.object(at: 0) as! NSDictionary
            strEngineerName =  String(format: "%@", dicTemp.value(forKey: "engineer_name")as! CVarArg) as NSString
            strEngineerID = String(format: "%@", dicTemp.value(forKey: "engineer_id")as! CVarArg) as NSString
        }
     
        
        self.txtEngineername.text = strEngineerName as String
      self.vwEngineer.removeFromSuperview()
    }
    func handleTap1()
    {
       self.vwEngineer.removeFromSuperview()
    
    }
    //MARK: -   fetch Parcentage Method
    func fetchengineerlist(strauthkey:String)
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "customer_service_center/engineer-list")
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
                    print("dictemp percetage -> \(dictemp)")
                    
                    let message_code =  String(format: "%@", dictemp.value(forKey: "message_code")as! CVarArg)
                    if (message_code == "1")
                    {
                        //success
                        OperationQueue.main.addOperation {
                            self.arrEngineerList.removeAllObjects()
                            let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                            self.arrEngineerList = NSMutableArray(array: arrm1)
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
    //MARK: -   fetch Parcentage Method
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
                        OperationQueue.main.addOperation {
                            self.strPercentage=dictemp.value(forKey: "data") as! NSString
                            //print(" self.strPercentage  : %@", self.strPercentage)
                            self.workstatusPopUpView()
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
    
    //MARK: -   fetch ACK Time Slot Method
    func fetchACKSlotTime(strauthkey:String , strdate:String)
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@/%@", Constants.conn.ConnUrl, "customer_service_center/request_booking_slot",strdate)
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
                    self.arrMPickerData.removeAllObjects()
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
                            self.arrMPickerData.add(strTotal)
                            
                        }
                        
                        OperationQueue.main.addOperation {
                           
                            self.btnChooseTime.backgroundColor=UIColor.white
                            self.btnChooseTime.isUserInteractionEnabled = true
                           
                            print(" self.arrMPickerData", self.arrMPickerData)
                          
                        }
                         self.hideLoadingMode()
                    }
                    else if (message_code == "5")
                    {
                        // ofc closed
                        
                         self.hideLoadingMode()
                        OperationQueue.main.addOperation {
                            self.btnAckChooseDate.setTitle("Choose reporting date", for: .normal)
                            self.strSlotDate = ""
                            
                           let message =  String(format: "%@", dictemp.value(forKey: "message")as! CVarArg)
                            let uiAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                    else if (message_code == "6")
                    {
                          // previous date
                         self.hideLoadingMode()
                         OperationQueue.main.addOperation {
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
   
    //MARK: -   fetch Rescheduled  Time slot
    func fetchRescheduled_slot(strauthkey:String , strdate:String)
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@/%@", Constants.conn.ConnUrl, "customer_service_center/request_rescheduled_slot",strdate)
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
                    self.arrRescheduledSlotTIME.removeAllObjects()
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
                            self.arrRescheduledSlotTIME.add(strTotal)
                            
                        }
                        OperationQueue.main.addOperation {
                           
                            self.btnReschuduleTime.backgroundColor=UIColor.white
                            self.btnReschuduleTime.isUserInteractionEnabled = true
                            print(" arrRescheduledSlotTIME", self.arrRescheduledSlotTIME)
                          
                        }
                    }
                    if (message_code == "5")
                    { //ofc clsed
                    
                        self.hideLoadingMode()
                        OperationQueue.main.addOperation {
                            self.btnReschuduleDate.setTitle("Reschedule date", for: .normal)
                            self.strRescheduleDate = ""
                            
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
   
    // MARK: - Acknowledgement Submit Method
    func acknowledgeBookedServiceMethod(strbookingID:String,slotdate:String,slottime:String, strnote:String)
    {
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.showLoadingMode()
        
        let strconnurl = String(format: "%@%@%@",Constants.conn.ConnUrl,"customer_service_center/acknowledge_booked_service/",strbookingID)
        
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        let postString = "booking_acknowledge_note=\(strnote)&slot_date=\(slotdate)&slot_time=\(slottime)"
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
                            OperationQueue.main.addOperation {
                                
                                self.myView.removeFromSuperview()
                                let obj = TenantThankYouPage()
                                obj.strMessage = "Service has been acknowledged. You will receive confirmation from Tenant soon."
                                self.navigationController?.pushViewController(obj, animated: true)
                            }
                            
                            /*  self.myView.removeFromSuperview()
                             let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
                             let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
                             self.fetchDetails(strauthkey: strauthkey, strbookingID: self.strIdentifier as String)*/
                        }
                    }
                    else if (message_code == 0)
                    {
                        // working time over
                        let strMessage = dictemp.value(forKey: "message") as! String
                        
                        OperationQueue.main.addOperation {
                            let uiAlert = UIAlertController(title: "", message: strMessage+"." , preferredStyle: UIAlertControllerStyle.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                self.myView.removeFromSuperview()
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
    
    
    
    // MARK: - Status Update Method
    func statusUpdate(strbookingID:String, strPercentage:String, strUpdateNote:String, labourName:String, labourID:String, Reschudule_date:String, Reschudule_time:String)
    {
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.showLoadingMode()
        
        let strconnurl = String(format: "%@%@%@",Constants.conn.ConnUrl,"customer_service_center/change_booking_status/",strbookingID)
        
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        let postString = "status_update_note=\(strUpdateNote)&completion_percentage=\(strPercentage)&labour_name=\(labourName)&labour_id=\(labourID)&reschedule_date=\(Reschudule_date)&reschedule_time=\(Reschudule_time)"
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
                    if (message_code == 1)
                    {
                        //success
                        OperationQueue.main.addOperation {
                            
                            if( !(self.FinalPercentage == "100%" || self.FinalPercentage == "100"))
                            {
                                //let timeZone = NSTimeZone.local
                                //let strTimeZoneName = String(format: "%@", timeZone as CVarArg)
                                //print("strTimeZoneName",strTimeZoneName)
                                
                                var start = String(format: "%@", self.strRescheduleTime as CVarArg)
                                start = String(start.prefix(5))
                                print("start   :%@",start)
                                let strDT = String(format: "%@ %@", self.strRescheduleDate, start)
                                
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                                formatter.timeZone = NSTimeZone.local //TimeZone(abbreviation: "GMT")
                                let sDate = formatter.date(from: strDT as String)! as NSDate
                                var end = String(format: "%@", self.strRescheduleTime as CVarArg)
                                end = String(end.suffix(5))
                                print("end   :%@",end)
                                
                                let strDTend = String(format: "%@ %@", self.strRescheduleDate, end)
                                let endDate = formatter.date(from: strDTend as String)! as NSDate
                                
                                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                                let strtenantDateTime = formatter.string(from: ((sDate as NSDate) as Date) ) as NSString
                                let formtt = DateFormatter()
                                formtt.dateFormat = "yyyy-MM-dd HH:mm"
                                formtt.timeZone = NSTimeZone.local //TimeZone(abbreviation: "GMT")
                                let FinalDateTime = formtt.date(from: strtenantDateTime as String)! as NSDate
                                print("FinalDateTime   :%@",FinalDateTime)
                                
                                let strMsg = String(format: "%@","Event is created in your calendar for", self.strRescheduleDate as CVarArg,"at",self.strRescheduleTime as CVarArg)
                                
                                
                                print("FinalDateTime",FinalDateTime)
                                print("endDate",endDate)
                                
                                self.addEventToCalendar(title: "Reschedule Reminder", description: strMsg, startDate: FinalDateTime as Date , endDate: endDate as Date )
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                                self.viewWorkStatus.removeFromSuperview()
                                let obj = TenantThankYouPage()
                                obj.strMessage = "Service status updated sucessfully."
                                self.navigationController?.pushViewController(obj, animated: true)
                                // }
                            })
                            
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
  //     scrollImg.contentMode = .scaleAspectFit
        
        
        cellImage = UIImageView(frame: CGRect(x: 0, y: 0, width: mainBg.frame.size.width, height: 300))
        cellImage.center=CGPoint(x: mainBg.frame.midX, y: mainBg.frame.midY-40)
        cellImage.backgroundColor=UIColor.clear
          cellImage.contentMode = .scaleAspectFit
        
        let dictemp: NSDictionary = self.arrMDetails[0] as! NSDictionary
       let strUrl = String(format: "%@", dictemp.value(forKey: "booking_image") as! CVarArg)
        if(strUrl .isEqual("")){
            cellImage.image=UIImage(named: "serviceimagebg.png")
        }
        else{
          
           
            let imageUrl =   dictemp.value(forKey: "booking_image") as! String
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
          mainBg.addSubview(scrollImg)
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
    
    //MARK: -   Note History Method
    @IBAction func pressNoteHistory(_ sender: Any)
    {
        let dictemp: NSDictionary = self.arrMDetails[0] as! NSDictionary
        let arrmP :NSArray =  dictemp.value(forKey: "booking_update_note") as! NSArray
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
    
     //MARK: -   string Null checking
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
    // MARK: - Textfield Delegates Method
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEqual(txtEngineername) {
            self.vwRescheduleTime.removeFromSuperview()
            self.vwReschedule.removeFromSuperview()
            textViewSatusUpdateNote.resignFirstResponder()
            txtEngineername.resignFirstResponder()
            
            view.endEditing(true)
            
            
            let screenSize = UIScreen.main.bounds
            if (screenSize.height == 480.0){
                //4S
                self.scrollPercentage.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y-40), animated: true)
            }
            else if (screenSize.height == 568.0){
                //5S
                self.scrollPercentage.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y-40), animated: true)
            }
            else{
                self.scrollPercentage.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - 180), animated: true)
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.isEqual(txtEngineername) {
            
            self.scrollPercentage.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.isEqual(txtEngineername) {
            
            
            self.vwRescheduleTime.removeFromSuperview()
            self.vwReschedule.removeFromSuperview()
            textViewSatusUpdateNote.resignFirstResponder()
            txtEngineername.resignFirstResponder()
            
            view.endEditing(true)
            self.EngineerListPopUp()
            /*   if tblViewEngineer==nil {
             self.EngineerListPopUp()
             }
             else
             {
             handleTap1()
             }*/
            let screenSize = UIScreen.main.bounds
            if (screenSize.height == 480.0){
                //4S
                self.scrollPercentage.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y-40), animated: true)
            }
            else if (screenSize.height == 568.0){
                //5S
                self.scrollPercentage.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y-40), animated: true)
            }
            else{
                self.scrollPercentage.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - 180), animated: true)
            }
        }
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
    
    // MARK: - TextView Delegates Method
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        return true;
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool{
        if textView.isEqual(textViewACKNote) {
            self.scrollViewAcK.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        else  if textView.isEqual(textViewSatusUpdateNote) {
            textViewSatusUpdateNote.resignFirstResponder()
            self.scrollPercentage.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        else {
            
        }
        return true;
    }
    func textViewDidBeginEditing(_ textView: UITextView){
        if textView.isEqual(textViewACKNote) {
            self.vwTimeACK.removeFromSuperview()
            self.vwDateACK.removeFromSuperview()
            let screenSize = UIScreen.main.bounds
            if (screenSize.height == 480.0){
                //4S
                self.scrollViewAcK.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y+40), animated: true)
            }
            else if (screenSize.height == 568.0){
                //5S
                self.scrollViewAcK.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y+40), animated: true)
            }
            else{
                self.scrollViewAcK.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y), animated: true)
            }
        }
        else  if textView.isEqual(textViewSatusUpdateNote) {
            // percentage
            handleTap1()
            self.vwRescheduleTime.removeFromSuperview()
            self.vwReschedule.removeFromSuperview()
            txtEngineername.resignFirstResponder()
            vwEngineer.removeFromSuperview()
            
            
            
            let screenSize = UIScreen.main.bounds
            if (screenSize.height == 480.0){
                //4S
                self.scrollPercentage.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y+50), animated: true)
            }
            else if (screenSize.height == 568.0){
                //5S
                self.scrollPercentage.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y+40), animated: true)
            }
            else{
                self.scrollPercentage.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y), animated: true)
            }
        }
        else{
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
