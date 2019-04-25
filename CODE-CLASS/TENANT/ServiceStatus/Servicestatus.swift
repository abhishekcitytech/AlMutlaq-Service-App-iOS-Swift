//
//  Servicestatus.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 17/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class Servicestatus: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextViewDelegate
{
    var loadingCircle = UIView()
    
    let cellReuseIdentifier = "cell"
    @IBOutlet var tabvList: UITableView!
    
    @IBOutlet var viewtop: UIView!
    @IBOutlet var btnSlide: UIButton!
    
    var arrMjobslist = NSMutableArray()
    var lblDisplay = UILabel()
    
    var viewWorkStatus = UIView()
    var arrMSmiley = NSMutableArray()
    var arrMText = NSMutableArray()
    var SmileyVW = UIView()
    var myViewStar = UIView()
    var myView1 = UIView()
    
    var buttonStar1 = UIButton()
    var buttonStar2 = UIButton()
    var buttonStar3 = UIButton()
    var buttonStar4 = UIButton()
    var buttonStar5 = UIButton()
    
    var imgSmile1 = UIImageView()
    var lblsmile2 = UILabel()
    
    var txtNoteSmiley = UITextView()
    var strFBCount = Int()
    var service_boooking_id = Int()
    var strNoteCome = NSString()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchServiceStatusList(strauthkey: strauthkey)

    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        viewtop.layer.shadowColor = UIColor.lightGray.cgColor
        viewtop.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewtop.layer.shadowRadius = 0.0
        viewtop.layer.shadowOpacity = 2.0
        viewtop.layer.masksToBounds = false
    
        tabvList.backgroundView=nil
        tabvList.backgroundColor=UIColor.clear
        tabvList.separatorColor=UIColor.clear
        tabvList.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    //MARK: -   fetchServiceStatusList Method
    func fetchServiceStatusList(strauthkey:String)
    {
        OperationQueue.main.addOperation {
            self.lblDisplay.removeFromSuperview()
            self.arrMjobslist.removeAllObjects()
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
                          self.arrMjobslist.removeAllObjects()
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        self.arrMjobslist = NSMutableArray(array: arrm1)
                        //print("self.arrMjobslist -> \(self.arrMjobslist)")
                     
                            
                            if(self.arrMjobslist.count > 0){
                                  OperationQueue.main.addOperation {
                                self.tabvList.reloadData()
                                }
                            }else{
                                self.showLabelNoData()
                            }
                       
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
               self.arrMjobslist.removeAllObjects()
            self.tabvList.reloadData()
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
    // MARK: - tableView delegate & datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMjobslist.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
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
        
        cell.selectionStyle=UITableViewCellSelectionStyle.none
        cell.accessoryType = UITableViewCellAccessoryType.none
        cell.backgroundColor=UIColor.white
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dictemp: NSDictionary = arrMjobslist[indexPath.row] as! NSDictionary
        
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: tableView.frame.size.width-80, height: 24))
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.text = dictemp.value(forKey: "service_name") as? String
        label.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        cell.contentView.addSubview(label)
        
        let label1 = UILabel(frame: CGRect(x: 15, y: label.frame.maxY, width: tableView.frame.size.width-50, height: 22))
        label1.textAlignment = .left
        label1.textColor = UIColor.darkGray
        label1.backgroundColor = UIColor.clear
        label1.text = dictemp.value(forKey: "booking_notes") as? String
        label1.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        label1.numberOfLines=0
        label1.contentMode = .scaleToFill
        cell.contentView.addSubview(label1)
        
        let imgvicon1 = UIImageView(frame: CGRect(x: 15, y: label1.frame.maxY+4, width: 18, height: 18))
        imgvicon1.backgroundColor = UIColor.clear
        imgvicon1.image = UIImage(named:"calendar")
        cell.contentView.addSubview(imgvicon1)
        
        let label2 = UILabel(frame: CGRect(x: imgvicon1.frame.maxX+10, y: label1.frame.maxY+4, width: tableView.frame.size.width-50, height: 22))
        label2.textAlignment = .left
        label2.backgroundColor = UIColor.clear
        label2.textColor = UIColor.gray
        label2.text = dictemp.value(forKey: "tenant_slot_date") as? String
        label2.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        cell.contentView.addSubview(label2)
        
        let imgvicon2 = UIImageView(frame: CGRect(x: 15, y: label2.frame.maxY+4, width: 18, height: 18))
        imgvicon2.backgroundColor = UIColor.clear
        imgvicon2.image = UIImage(named:"mapgray")
        cell.contentView.addSubview(imgvicon2)
        
        let label3 = UILabel(frame: CGRect(x: imgvicon2.frame.maxX+10, y: label2.frame.maxY+4, width: tableView.frame.size.width-50, height: 22))
        label3.textAlignment = .left
        label3.backgroundColor = UIColor.clear
        label3.textColor = UIColor.gray
    
        label3.text = String(format: "%@,%@,%@", (dictemp.value(forKey: "building_address") as? String)!,(dictemp.value(forKey: "building_no") as? String)!,(dictemp.value(forKey: "flat_no") as? String)!)
        label3.font = UIFont(name: "Roboto-Regular", size: 13.0)!
        cell.contentView.addSubview(label3)
        
        let strbooking_status = String(format: "%@", dictemp.value(forKey: "booking_status") as! CVarArg)
        
        
        let lblSTATUS = UILabel(frame: CGRect(x: 0, y: label.frame.minY, width: 0, height: 0))
        lblSTATUS.textAlignment = .center
        lblSTATUS.textColor = UIColor.black
        lblSTATUS.font = UIFont(name: "Roboto-Bold", size: 12.0)!
        lblSTATUS.layer.cornerRadius = 4.0
        lblSTATUS.layer.masksToBounds = true
        lblSTATUS.backgroundColor = UIColor.clear
        if strbooking_status.isEqual("0")
        {
            lblSTATUS.text="BOOKED"
            lblSTATUS.textColor = UIColor(red: 78.0/255, green: 129.0/255, blue: 237.0/255, alpha: 1.0)
            
            let strAck = String(format: "%@", dictemp.value(forKey: "booking_acknowledge") as! CVarArg)
            if(strAck.isEqual("Y"))
            {
                let imgvicon1 = UIImageView(frame: CGRect(x: tableView.frame.size.width-44, y: label.frame.maxY+12, width:24, height:24))
                imgvicon1.backgroundColor = UIColor.clear
                imgvicon1.image = UIImage(named:"acked")
                cell.contentView.addSubview(imgvicon1)
            }
        }
        else if strbooking_status.isEqual("1")
        {
              lblSTATUS.text="RESCHEDULED"
              lblSTATUS.textColor = UIColor(red: 255.0/255, green: 147.0/255, blue: 0.0/255, alpha: 1.0)
            
        }
        else if strbooking_status.isEqual("3")
        {
            lblSTATUS.text="CLOSED"
            lblSTATUS.textColor =   UIColor(red: 127.0/255, green: 186.0/255, blue: 2.0/255, alpha: 1.0)
            
            _ = String(format: "%@", dictemp.value(forKey: "tenant_rating") as! CVarArg)
            let btnFeedback = UIButton(frame: CGRect(x:  tableView.frame.size.width-45 , y: label.frame.maxY+15, width:32, height: 32))
            btnFeedback.backgroundColor=UIColor.white
            btnFeedback.tag = indexPath.row
            btnFeedback.setImage(UIImage(named: "feedback"), for: .normal)
            btnFeedback.addTarget(self, action: #selector(pressFeedBack), for: .touchUpInside)
            cell.contentView.addSubview(btnFeedback)
        }
        else if strbooking_status.isEqual("4")
        {
            lblSTATUS.text="CANCELLED"
            lblSTATUS.textColor = UIColor.red
        }
        
        var rect: CGRect = lblSTATUS.frame
        rect.size = (lblSTATUS.text?.size(withAttributes: [NSAttributedStringKey.font: UIFont(name: "Roboto-Bold" , size: 12.0)!]))!
        lblSTATUS.frame.size.width = rect.size.width + 10
        lblSTATUS.frame.size.height = rect.size.height + 10
        lblSTATUS.frame.origin.x = tableView.frame.size.width - lblSTATUS.frame.size.width - 20
        
        cell.contentView.addSubview(lblSTATUS)
        
        let labelSeparator = UILabel(frame: CGRect(x: 15, y: 114.5, width: tableView.frame.size.width-30, height: 0.5))
        labelSeparator.backgroundColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0)
        cell.contentView.addSubview(labelSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictemp: NSDictionary = arrMjobslist[indexPath.row] as! NSDictionary
      
        var obj = JobDetail()
        let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
            //5S
            obj = JobDetail(nibName: "JobDetail5S", bundle: nil)
        }
            
        else if (screenSize.height == 480.0){
            //5S
            obj = JobDetail(nibName: "JobDetail4S", bundle: nil)
        }
        else if(screenSize.height == 667.0){
            //6
            obj = JobDetail(nibName: "JobDetail", bundle: nil)
        }
        else if(screenSize.height == 736.0){
            // 6Plus
            obj = JobDetail(nibName: "JobDetail6Plus", bundle: nil)
        }
        else if(screenSize.height == 812.0){
            //x
            obj = JobDetail(nibName: "JobDetailX", bundle: nil)
        }
        else{
            obj = JobDetail(nibName: "JobDetailXSMAX", bundle: nil)
        }
         let strbookingID = String(format:"%@",(dictemp.value(forKey: "service_boooking_id") as? CVarArg)!)
        obj.strIdentifier = strbookingID as NSString
           print("dictemp strbookingID -> \(dictemp)")
           print("strbookingID -> \(strbookingID)")
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    //MARK: -  press  Rating button
    @objc func pressFeedBack(sender: UIButton)
    {
        strFBCount = 0
        let dictemp: NSDictionary = arrMjobslist[sender.tag] as! NSDictionary
        print("dictemp  ->>",dictemp)
        service_boooking_id =  ((dictemp.value(forKey: "service_boooking_id")  ?? String()) as AnyObject).integerValue
        strFBCount = ((dictemp.value(forKey: "tenant_rating")  ?? String()) as AnyObject).integerValue
        strNoteCome = dictemp.value(forKey: "tenant_rating_note") as! NSString
        print("strFBCount --- %@",strFBCount)
        print("service_boooking_id --- %@",service_boooking_id)
        self.FeedbackPopUpView()
    }
    
    // MARK: - Feedback rating Popup View Method
    func FeedbackPopUpView() -> Void
    {
        arrMText=["Rate this service","Very Bad","Bad","Good","Very Good","Excellent",]
        arrMSmiley = ["roundlogo", "\u{1F620}","\u{1F614}","\u{1F642}","\u{1F60A}","\u{1F600}",]
       
        self.viewWorkStatus = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        self.viewWorkStatus.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        
        myView1 = UIView(frame: CGRect(x: 30, y: 0, width: self.viewWorkStatus.frame.size.width - 60, height:400))
        myView1.center = self.viewWorkStatus.center
        myView1.backgroundColor=UIColor.white
        myView1.layer.cornerRadius = 6.0
        myView1.layer.masksToBounds = true
        self.viewWorkStatus.addSubview(myView1)
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 15, width: myView1.frame.size.width, height: 20))
        label1.textAlignment = .center
        label1.textColor = UIColor.black
        label1.backgroundColor = UIColor.clear
        label1.text = "Give your feedback"
        label1.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        myView1.addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: 0, y: label1.frame.maxY+5, width: myView1.frame.size.width, height: 0.5))
        label2.backgroundColor = UIColor.lightGray
        myView1.addSubview(label2)
        
        let  VWsm = UIView(frame: CGRect(x: 30, y: label1.frame.maxY+10, width: self.myView1.frame.size.width - 60, height:115))
        VWsm.backgroundColor=UIColor.clear
        VWsm.layer.cornerRadius = 6.0
        VWsm.layer.masksToBounds = true
        self.myView1.addSubview(VWsm)
       
        imgSmile1 = UIImageView(frame: CGRect(x: (VWsm.frame.size.width)/2-40, y:0, width: 80, height: 80))
        let imoji : String = (arrMSmiley.object(at: 0) as! String)
        imgSmile1.image =  UIImage(named: imoji )
        VWsm.addSubview(imgSmile1)
        
        lblsmile2 = UILabel(frame: CGRect(x: 0, y: Int(imgSmile1.frame.maxY+5), width: Int(VWsm.frame.size.width), height: 30))
        lblsmile2.textAlignment = .center
        lblsmile2.textColor = UIColor.gray
        lblsmile2.backgroundColor = UIColor.clear
        let str1 : String = (arrMText.object(at: 0) as! String)
        lblsmile2.text = str1
        lblsmile2.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        VWsm.addSubview(lblsmile2)
        
        myViewStar = UIView(frame: CGRect(x: myView1.frame.size.width/2-140, y: VWsm.frame.maxY+10, width: 280, height:40))
        myViewStar.backgroundColor=UIColor.clear
        myView1.addSubview(myViewStar)
        
        buttonStar1 = UIButton(frame: CGRect(x:15 , y: 5, width:  40, height: 35))
        buttonStar1.tag=1
        buttonStar1.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar1.addTarget(self, action: #selector(btnStarClick1), for: .touchUpInside)
        buttonStar1.backgroundColor=UIColor.clear
        myViewStar.addSubview(buttonStar1)
        
        buttonStar2 = UIButton(frame: CGRect(x: Int(buttonStar1.frame.maxX)+12 , y: 5, width:  40, height: 35))
        buttonStar2.tag=2
        buttonStar2.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar2.addTarget(self, action: #selector(btnStarClick2), for: .touchUpInside)
        buttonStar2.backgroundColor=UIColor.clear
        myViewStar.addSubview(buttonStar2)
        
        buttonStar3 = UIButton(frame: CGRect(x: Int(buttonStar2.frame.maxX)+12 , y: 5, width:  40, height: 35))
        buttonStar3.tag=3
        buttonStar3.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar3.addTarget(self, action: #selector(btnStarClick3), for: .touchUpInside)
        buttonStar3.backgroundColor=UIColor.clear
        myViewStar.addSubview(buttonStar3)
        
        buttonStar4 = UIButton(frame: CGRect(x: Int(buttonStar3.frame.maxX)+12 , y: 5, width:  40, height: 35))
        buttonStar4.tag=4
        buttonStar4.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar4.addTarget(self, action: #selector(btnStarClick4), for: .touchUpInside)
        buttonStar4.backgroundColor=UIColor.clear
        myViewStar.addSubview(buttonStar4)
        
        buttonStar5 = UIButton(frame: CGRect(x: Int(buttonStar4.frame.maxX)+12 , y: 5, width:  40, height: 35))
        buttonStar5.tag=5
        buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar5.addTarget(self, action: #selector(btnStarClick5), for: .touchUpInside)
        buttonStar5.backgroundColor=UIColor.clear
        myViewStar.addSubview(buttonStar5)
        
        
        txtNoteSmiley = UITextView(frame: CGRect(x: 10, y: myViewStar.frame.maxY+20, width: myView1.frame.size.width - 20, height: 110));
        txtNoteSmiley.text = " Note"
        txtNoteSmiley.textColor = UIColor.lightGray
        txtNoteSmiley.textAlignment = NSTextAlignment.justified
        txtNoteSmiley.backgroundColor = UIColor.white
        txtNoteSmiley.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        txtNoteSmiley.layer.borderWidth = 1.0
        txtNoteSmiley.layer.cornerRadius=4.0
        txtNoteSmiley.layer.masksToBounds=true
        txtNoteSmiley.delegate=self
        txtNoteSmiley.font = UIFont(name: "Roboto-Regular", size: 15.0)!
        myView1.addSubview(txtNoteSmiley)
        
        let lblSep = UILabel(frame: CGRect(x: 0, y: myView1.frame.size.height-50.5, width: myView1.frame.size.width, height: 0.5))
        lblSep.backgroundColor = UIColor.lightGray
        myView1.addSubview(lblSep)
        
        let buttonCancel = UIButton(frame: CGRect(x: 0, y: myView1.frame.size.height-49.5, width: myView1.frame.size.width/2-0.5, height: 50))
        buttonCancel.backgroundColor=UIColor.white
        buttonCancel.tag=1
        buttonCancel.setTitle("Not now", for: .normal)
        buttonCancel.setTitleColor(UIColor.red, for: .normal)
        buttonCancel.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonCancel.addTarget(self, action: #selector(pressCancelWS), for: .touchUpInside)
        myView1.addSubview(buttonCancel)
        
        let lblSeparator = UILabel(frame: CGRect(x: buttonCancel.frame.maxX , y: myView1.frame.size.height-50.5, width: 1, height: buttonCancel.frame.size.height+1))
        lblSeparator.backgroundColor = UIColor.lightGray
        myView1.addSubview(lblSeparator)
        
        let buttonSubmit = UIButton(frame: CGRect(x: buttonCancel.frame.size.width+1, y: myView1.frame.size.height-49.5, width: myView1.frame.size.width/2, height: 50))
        buttonSubmit.backgroundColor=UIColor.white
        buttonSubmit.tag=2
        buttonSubmit.setTitle("Submit", for: .normal)
        buttonSubmit.setTitleColor(UIColor.black, for: .normal)
        buttonSubmit.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonSubmit.addTarget(self, action: #selector(pressSubmitWS), for: .touchUpInside)
        myView1.addSubview(buttonSubmit)
        
        self.view.addSubview(self.viewWorkStatus)
        
    
        /// data come from already saved data
      
        
        if strFBCount == 1{
        
            buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar2.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar3.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar4.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
        }
        else  if strFBCount == 2{
        
            buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar3.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar4.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
            
        }
        else  if strFBCount == 3{
      
            buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar3.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar4.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
        }
        else  if strFBCount == 4{
            buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar3.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar4.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
        }
        else  if strFBCount == 5{
            
            buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar3.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar4.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar5.setImage(UIImage(named: "star-selected"), for: .normal)
        }
        
     
        if strFBCount == 0
        {
         
        }
        else
        {
            
           self.displaydataCome()
            
            let notestr  =  String(format: "%@", strNoteCome as NSString )
            if !notestr.isEqual("") {
                txtNoteSmiley.textColor = UIColor.black
                txtNoteSmiley.text =  String(format: "%@", strNoteCome as NSString )
            }
            txtNoteSmiley.isUserInteractionEnabled = false
            txtNoteSmiley.backgroundColor =  UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.5)
            txtNoteSmiley.frame = CGRect(x: 10, y: myViewStar.frame.maxY+20, width: myView1.frame.size.width - 20, height: buttonSubmit.frame.size.height + txtNoteSmiley.frame.size.height - 20)
            buttonStar1 .isUserInteractionEnabled = false
            buttonStar2 .isUserInteractionEnabled = false
            buttonStar3 .isUserInteractionEnabled = false
            buttonStar4 .isUserInteractionEnabled = false
            buttonStar5 .isUserInteractionEnabled = false
            buttonSubmit.isHidden = true
            buttonCancel.isHidden = true
            lblSep.isHidden = true
            lblSeparator.isHidden = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Servicestatus.myviewTapped(_:)))
            tapGesture.numberOfTapsRequired = 1
            tapGesture.numberOfTouchesRequired = 1
            self.viewWorkStatus.addGestureRecognizer(tapGesture)
            self.viewWorkStatus.isUserInteractionEnabled = true
        }
    }
    func displaydataCome() -> Void
    {
        let imoji : String = (arrMSmiley.object(at: strFBCount) as! String)
        imgSmile1.image = String.imageL(imoji)()
        lblsmile2 .text = (arrMText.object(at: strFBCount) as! String)
    }
    @objc func btnStarClick1(sender: UIButton)
    {
         strFBCount = 1
         self.displaydataCome()
  
        buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar2.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar3.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar4.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
    }
    @objc func btnStarClick2(sender: UIButton)
    {
        strFBCount = 2
        self.displaydataCome()
        
        buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar3.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar4.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
    }
    @objc func btnStarClick3(sender: UIButton)
    {
        strFBCount = 3
       self.displaydataCome()
       
        buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar3.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar4.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
    }
    @objc func btnStarClick4(sender: UIButton)
    {
        strFBCount = 4
        self.displaydataCome()
        buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar3.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar4.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
    }
    @objc func btnStarClick5(sender: UIButton)
    {
        strFBCount = 5
       self.displaydataCome()
        
        buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar3.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar4.setImage(UIImage(named: "star-selected"), for: .normal)
        buttonStar5.setImage(UIImage(named: "star-selected"), for: .normal)
    }
  
    @objc func pressCancelWS()
    {
        self.viewWorkStatus.removeFromSuperview()
    }
    @objc func pressSubmitWS()
    {
        if strFBCount == 0
        {
            let uiAlert = UIAlertController(title: "", message: "Please give feedback ratings.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            self.viewWorkStatus.removeFromSuperview()
            self.FeedbackRatingMethod(serviceBoookingId: String(service_boooking_id) , tenantRating: String(strFBCount), tenantnote: self.txtNoteSmiley.text!)
        }
    }
    @objc func myviewTapped(_ sender: UITapGestureRecognizer)
    {
        self.viewWorkStatus.removeFromSuperview()
    }
    func emojiToImage() -> UIImage?
    {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        UIRectFill(CGRect(origin: CGPoint(), size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    //MARK: -  post  rating Method
    func  FeedbackRatingMethod(serviceBoookingId:String,tenantRating:String, tenantnote:String)
    {
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.showLoadingMode()
        
        let strconnurl = String(format: "%@%@/%@", Constants.conn.ConnUrl, "tenant/rate_service",serviceBoookingId)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        let postString = "tenant_rating=\(tenantRating)&tenant_rating_note=\(tenantnote)"
        //  postString = postString.replacingOccurrences(of: "", with: "%20")
        print("postString  ->>",postString)
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
                    let messageText:String = dictemp.value(forKey: "message") as! String
                    
                    if (message_code == 1){
                        //success
                        OperationQueue.main.addOperation {
                            let obj = TenantThankYouPage()
                            obj.strMessage = messageText as NSString
                            self.navigationController?.pushViewController(obj, animated: true)
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
    
    // MARK: - TextView Delegates Method
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        
        if txtNoteSmiley.text.isEqual(" Note") && (txtNoteSmiley.textColor?.isEqual(UIColor.lightGray))!
        {
            txtNoteSmiley.text = ""
            txtNoteSmiley.textColor = UIColor.black
        }
        return true;
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool{
      
        if textView.isEqual(txtNoteSmiley) {
            self.viewWorkStatus.transform = CGAffineTransform(translationX: 0, y: -80)
            
            UIView.animate(withDuration: 0.1, animations: {
                self.viewWorkStatus.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            
        }
       
        return true;
    }
    func textViewDidBeginEditing(_ textView: UITextView){
        if textView.isEqual(txtNoteSmiley) {
            self.viewWorkStatus.transform = CGAffineTransform(translationX: 0, y: 0)
            
            UIView.animate(withDuration: 0.1, animations: {
                self.viewWorkStatus.transform = CGAffineTransform(translationX: 0, y: -80)
            }, completion: nil)
            
        }
        else{
            
        }
        //        let screenSize = UIScreen.main.bounds
        //        if (screenSize.height == 568.0){
        //            //5S
        //            scrollLeave.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y-10), animated: true)
        //        }
        //        else if(screenSize.height == 667.0){
        //            //6
        //            scrollLeave.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        //
        //        }
        //        else if(screenSize.height == 736.0){
        //            scrollLeave.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        //
        //        }
        //        else if(screenSize.height == 812.0){
        //            scrollLeave.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        //        }
        //        else
        //        {
        //            scrollLeave.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y-10), animated: true)
        //        }
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
    
    // MARK: - keyboardWillBeHidden Method
    func keyboardWillBeHidden(notification: NSNotification)
    {
        if( txtNoteSmiley.text.count == 0){
            txtNoteSmiley.textColor = UIColor.lightGray
            txtNoteSmiley.text = " Note"
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

extension String
{
    func imageL() -> UIImage? {
        let size = CGSize(width: 80, height: 80)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(rect)
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 75)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
