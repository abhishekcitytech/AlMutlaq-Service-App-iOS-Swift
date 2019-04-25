//
//  CSTasklist.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 18/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class CSTasklist: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    //// feed back
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
    
    var btnSmiley1 = UIButton()
    var btnSmiley2 = UIButton()
    var btnSmiley3 = UIButton()
    var imgSmile1 = UIImageView()
    var lblsmile2 = UILabel()
    
    var txtNoteSmiley = UITextView()
    var strFBCount = Int()
    var service_boooking_id = Int()
    var strNoteCome = NSString()
    
    var loadingCircle = UIView()
    
    let cellReuseIdentifier = "cell"
    @IBOutlet var tabvList: UITableView!
    
    @IBOutlet var viewtop: UIView!
    
    var stridentifer = NSString()
    var strvalue = NSString()
    
    var arrMTasklist = NSMutableArray()
  var lblDisplay = UILabel()
    @IBOutlet var lblHeader: UILabel!
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchList(strauthkey: strauthkey, strstatus: strvalue as String)
        
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
        
        lblHeader.text=stridentifer as String
        
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
    
    // MARK: - tableView delegate & datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMTasklist.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
      return 140.0
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
        
        let dictemp: NSDictionary = arrMTasklist[indexPath.row] as! NSDictionary
        
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: tableView.frame.size.width-20, height: 24))
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.text = String(format:"%@",(dictemp.value(forKey: "service_name") as? String)!)
        label.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        cell.contentView.addSubview(label)
        
        let label1 = UILabel(frame: CGRect(x: 15, y: label.frame.maxY, width: tableView.frame.size.width-50, height: 22))
        label1.textAlignment = .left
        label1.lineBreakMode = .byWordWrapping
        label1.textColor = UIColor.darkGray
        label1.backgroundColor = UIColor.clear
        label1.text = String(format:"%@",(dictemp.value(forKey: "booking_notes") as? String)!)
        
        label1.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        cell.contentView.addSubview(label1)
        
        let imgvicon1 = UIImageView(frame: CGRect(x: 15, y: label1.frame.maxY+4, width: 18, height: 18))
        imgvicon1.backgroundColor = UIColor.clear
        imgvicon1.image = UIImage(named:"calendar")
        cell.contentView.addSubview(imgvicon1)
        
        let label2 = UILabel(frame: CGRect(x: imgvicon1.frame.maxX+10, y: label1.frame.maxY+4, width: tableView.frame.size.width-50, height: 22))
        label2.textAlignment = .left
        label2.backgroundColor = UIColor.clear
        label2.textColor = UIColor.gray
     //   label2.text = String(format:"%@",(dictemp.value(forKey: "booking_requested_date") as? String)!)
         label2.text = String(format:"%@",(dictemp.value(forKey: "tenant_slot_date") as! CVarArg))
     
        label2.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        cell.contentView.addSubview(label2)
        
        let imgvicon2 = UIImageView(frame: CGRect(x: 15, y: label2.frame.maxY+4, width: 18, height: 18))
        imgvicon2.backgroundColor = UIColor.clear
        imgvicon2.image = UIImage(named:"mapgray")
        cell.contentView.addSubview(imgvicon2)

        let label3 = UILabel(frame: CGRect(x: imgvicon2.frame.maxX+10, y: label2.frame.maxY+4, width: tableView.frame.size.width-60, height: 48))
        label3.textAlignment = .left
        label3.numberOfLines = 5
        label3.lineBreakMode = .byWordWrapping
        label3.backgroundColor = UIColor.clear
        label3.textColor = UIColor.gray
        label3.text = NSString(format:" Bulding no: %@, Flat no: %@",(dictemp.value(forKey: "building_address") as? String)!, (dictemp.value(forKey: "building_no") as? String)!,(dictemp.value(forKey: "flat_no") as? String)!) as String
        label3.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        cell.contentView.addSubview(label3)
        
        let strbooking_status = dictemp.value(forKey: "booking_status") as? String
        if strbooking_status!.isEqual("0")
        {
            let strAck = dictemp.value(forKey: "booking_acknowledge") as? String
            if(strAck!.isEqual("Y"))
            {
                let imgvicon1 = UIImageView(frame: CGRect(x: tableView.frame.size.width-56, y: label.frame.maxY, width:32, height:32))
                imgvicon1.backgroundColor = UIColor.clear
                imgvicon1.image = UIImage(named:"acked")
                cell.contentView.addSubview(imgvicon1)
            }
        }
        
        if strbooking_status!.isEqual("3")
        {
                let strRating = "\(dictemp.value(forKey: "tenant_rating") ?? "")"
              //    print(dictemp.value(forKey: "service_id") ?? String())
         //   let strRating = ((dictemp.value(forKey: "tenant_rating") ?? String()) as AnyObject).integerValue
          //  let strRating = dictemp.value(forKey: "tenant_rating") as! Int
           // if (strRating == 0)
              if strRating.isEqual("0")
            {
            }
            else{
                let btnFeedback = UIButton(frame: CGRect(x:  tableView.frame.size.width-45 , y: 5, width: 35, height: 35))
                btnFeedback.backgroundColor=UIColor.white
                btnFeedback.tag = indexPath.row
                btnFeedback.setImage(UIImage(named: "feedback"), for: .normal)
                btnFeedback.addTarget(self, action: #selector(pressFeedBack), for: .touchUpInside)
                cell.contentView.addSubview(btnFeedback)
            }
        }
        
        let labelSeparator = UILabel(frame: CGRect(x: 15, y: 139.5, width: tableView.frame.size.width-30, height: 0.5))
        labelSeparator.backgroundColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0)
        cell.contentView.addSubview(labelSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictemp: NSDictionary = arrMTasklist[indexPath.row] as! NSDictionary
        //SN
          let strbookingID = dictemp.value(forKey: "service_boooking_id") ?? String()
       // let strbookingID:Int = dictemp.value(forKey: "service_boooking_id") as! Int
        let stringValue = "\(strbookingID)"
        
        var obj = CSTaskdetails()
        
        
        let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
            //5S
            obj = CSTaskdetails(nibName: "CSTaskdetails5S", bundle: nil)
        }
        else   if (screenSize.height == 480.0){
            //5S
            obj = CSTaskdetails(nibName: "CSTaskdetails4S", bundle: nil)
        }
        else if(screenSize.height == 667.0){
            //6
            obj = CSTaskdetails(nibName: "CSTaskdetails", bundle: nil)
        }
        else if(screenSize.height == 736.0){
            // 6Plus
            obj = CSTaskdetails(nibName: "CSTaskdetails6Plus", bundle: nil)
        }
        else if(screenSize.height == 812.0){
            //x
            obj = CSTaskdetails(nibName: "CSTaskdetailsX", bundle: nil)
        }
        else
        {
            obj = CSTaskdetails(nibName: "CSTaskdetailsXSMAX", bundle: nil)
            
        }
       
        obj.strIdentifier = stringValue as NSString
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    
    //MARK: -   Rating and Feedback View Method
    @objc func pressFeedBack(sender: UIButton)
    {
        
        let dictemp: NSDictionary = arrMTasklist[sender.tag] as! NSDictionary
        print("dictemp  ->>",dictemp)
          //    print(dictemp.value(forKey: "service_id") ?? String())
          //let strRating = ((dictemp.value(forKey: "tenant_rating") ?? String()) as AnyObject).integerValue
        service_boooking_id = ((dictemp.value(forKey: "service_boooking_id") ?? String()) as AnyObject).integerValue
        strFBCount = ((dictemp.value(forKey: "tenant_rating") ?? String()) as AnyObject).integerValue
        strNoteCome = dictemp.value(forKey: "tenant_rating_note") as! NSString
        
        self.FeedbackPopUpView()
    }
    func FeedbackPopUpView() -> Void
    {
        arrMText=["Rate this service","Very Bad","Bad","Good","Very Good","Excellent",]
        arrMSmiley = ["roundlogo", "\u{1F620}","\u{1F614}","\u{1F642}","\u{1F60A}","\u{1F600}",]
        
        self.viewWorkStatus = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        self.viewWorkStatus.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Servicestatus.myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.viewWorkStatus.addGestureRecognizer(tapGesture)
        self.viewWorkStatus.isUserInteractionEnabled = true
        
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
        
        buttonStar1 = UIButton(frame: CGRect(x: 15 , y: 5, width:  40, height: 35))
        buttonStar1.tag=1
        buttonStar1.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar1.backgroundColor=UIColor.clear
        myViewStar.addSubview(buttonStar1)
        
        buttonStar2 = UIButton(frame: CGRect(x: Int(buttonStar1.frame.maxX)+12 , y: 5, width:  40, height: 35))
        buttonStar2.tag=2
        buttonStar2.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar2.backgroundColor=UIColor.clear
        myViewStar.addSubview(buttonStar2)
        
        buttonStar3 = UIButton(frame: CGRect(x: Int(buttonStar2.frame.maxX)+12 , y: 5, width: 40, height: 35))
        buttonStar3.tag=3
        buttonStar3.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar3.backgroundColor=UIColor.clear
        myViewStar.addSubview(buttonStar3)
        
        buttonStar4 = UIButton(frame: CGRect(x: Int(buttonStar3.frame.maxX)+12 , y: 5, width:  40, height: 35))
        buttonStar4.tag=4
        buttonStar4.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar4.backgroundColor=UIColor.clear
        myViewStar.addSubview(buttonStar4)
        
        buttonStar5 = UIButton(frame: CGRect(x: Int(buttonStar4.frame.maxX)+12 , y: 5, width:  40, height: 35))
        buttonStar5.tag=5
        buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
        buttonStar5.backgroundColor=UIColor.clear
        myViewStar.addSubview(buttonStar5)
        
        txtNoteSmiley = UITextView(frame: CGRect(x: 10, y: myViewStar.frame.maxY+20, width: myView1.frame.size.width - 20, height: 160));
        txtNoteSmiley.text = " Note"
        txtNoteSmiley.textColor = UIColor.lightGray
        txtNoteSmiley.textAlignment = NSTextAlignment.justified
        txtNoteSmiley.backgroundColor = UIColor.white
        txtNoteSmiley.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        txtNoteSmiley.layer.borderWidth = 1.0
        txtNoteSmiley.isEditable=false
        txtNoteSmiley.layer.cornerRadius=4.0
        txtNoteSmiley.layer.masksToBounds=true
        txtNoteSmiley.font = UIFont(name: "Roboto-Regular", size: 15.0)!
        myView1.addSubview(txtNoteSmiley)
        
        self.view.addSubview(self.viewWorkStatus)
        
        let notestr  =  String(format: "%@", strNoteCome as NSString )
        if !notestr.isEqual("")
        {
            txtNoteSmiley.textColor = UIColor.black
            txtNoteSmiley.text =  String(format: "%@", strNoteCome as NSString )
        }
        
        if strFBCount == 1
        {
            // text
            btnSmiley2.isHidden = true
            
            let imoji : String = (arrMSmiley.object(at: strFBCount) as! String)
            imgSmile1.image = String.imageL(imoji)()
            lblsmile2 .text = (arrMText.object(at: strFBCount) as! String)
            
            //setected
            buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
            // not setected
            buttonStar2.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar3.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar4.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
        }
        else  if strFBCount == 2
        {
            // text
            btnSmiley2.isHidden = true
            let imoji : String = (arrMSmiley.object(at: strFBCount) as! String)
            imgSmile1.image = String.imageL(imoji)()
            lblsmile2 .text = (arrMText.object(at: strFBCount) as! String)
            
            buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
            // not setected
            buttonStar3.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar4.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
        }
        else  if strFBCount == 3
        {
            // text
            btnSmiley2.isHidden = true
            let imoji : String = (arrMSmiley.object(at: strFBCount) as! String)
            imgSmile1.image = String.imageL(imoji)()
            lblsmile2 .text = (arrMText.object(at: strFBCount) as! String)
            
            buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar3.setImage(UIImage(named: "star-selected"), for: .normal)
            
            // not setected
            buttonStar4.setImage(UIImage(named: "star-deselect"), for: .normal)
            buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
        }
        else  if strFBCount == 4
        {
            // text
            btnSmiley2.isHidden = true
            let imoji : String = (arrMSmiley.object(at: strFBCount) as! String)
            imgSmile1.image = String.imageL(imoji)()
            lblsmile2 .text = (arrMText.object(at: strFBCount) as! String)
            
            buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar3.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar4.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar5.setImage(UIImage(named: "star-deselect"), for: .normal)
        }
        else  if strFBCount == 5
        {
            btnSmiley2.isHidden = true
            let imoji : String = (arrMSmiley.object(at: strFBCount) as! String)
            imgSmile1.image = String.imageL(imoji)()
            lblsmile2 .text = (arrMText.object(at: strFBCount) as! String)
            
            buttonStar1.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar2.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar3.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar4.setImage(UIImage(named: "star-selected"), for: .normal)
            buttonStar5.setImage(UIImage(named: "star-selected"), for: .normal)
        }
    }
    @objc func myviewTapped(_ sender: UITapGestureRecognizer)
    {
        self.viewWorkStatus.removeFromSuperview()
    }
    
    
    //MARK: -   fetchList -Booked - Rescheduled - Closed Method
    func fetchList(strauthkey:String, strstatus:String)
    {
        print("selected status", strstatus)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let strcurrentDate = formatter.string(from: date)
        
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@%@/%@", Constants.conn.ConnUrl, "customer_service_center/customer-servicesList/",strcurrentDate,strstatus)
        print(strconnurl)
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
                    print("dictemp -> \(dictemp)")
                    
                    let message_code:Int = dictemp.value(forKey: "message_code") as! Int
                    if (message_code == 1)
                    {
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        self.arrMTasklist = NSMutableArray(array: arrm1)
                        
                        print("array count",self.arrMTasklist.count)
                        print("array details",self.arrMTasklist)
                        
                        OperationQueue.main.addOperation {
                            if(self.arrMTasklist.count > 0){
                                self.tabvList.reloadData()
                            }else{
                                   self.showLabelNoData()
                            }
                            
                        }
                    }
                    else  if (message_code == 0){
                        
                        //fail
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
            self.arrMTasklist.removeAllObjects()
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
    //MARK: -   string Null checking
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
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
