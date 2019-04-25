//
//  CSDashboard.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 18/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class CSDashboard: ViewController, UITableViewDataSource, UITableViewDelegate,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance
{
    
    var lblDateDisplay = UILabel()
    
    var loadingCircle = UIView()

    @IBOutlet var viewtop: UIView!
    var calendar: FSCalendar!
    var datesWithEvent = NSArray()
    let datesWithMultipleEvents = NSArray()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let gregorian: Calendar = Calendar(identifier: .gregorian)
    var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var currentDT = NSDate()
    let cellReuseIdentifier = "cell"
    var myTableView: UITableView  =   UITableView()
    
    @IBOutlet var btnSlide: UIButton!
    
    var stridentifer = NSString()
    var arrDetailsJob = NSMutableArray()
    var arrMjobsdateonly = NSMutableArray()
    var arrDateList = NSMutableArray()
    var strSelectedDate = NSString()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //------ fetch date list for Calendar view ---------//
        currentDT=Date() as NSDate
        strSelectedDate=self.dateFormatter2.string(from: NSDate() as Date) as NSString
        self.createCalendar()
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchDateofTheMonth(strauthkey: strauthkey, strdate: strSelectedDate as String)
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        viewtop.layer.shadowColor = UIColor.lightGray.cgColor
        viewtop.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewtop.layer.shadowRadius = 0.0
        viewtop.layer.shadowOpacity = 2.0
        viewtop.layer.masksToBounds = false
        
        currentDT=Date() as NSDate
        strSelectedDate=self.dateFormatter2.string(from: NSDate() as Date) as NSString
        self.createCalendar()
        
        //-----  Create tableview details list -----
        lblDateDisplay = UILabel(frame: CGRect(x: 0, y: calendar.frame.maxY, width: UIScreen.main.bounds.size.width, height: 30))
        lblDateDisplay.textAlignment = .center
        lblDateDisplay.textColor = UIColor.white
        lblDateDisplay.backgroundColor = UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0)
        lblDateDisplay.text = strSelectedDate as String
        lblDateDisplay.font = UIFont(name: "Roboto-Regular", size: 16.0)!
        lblDateDisplay.isHidden = true
        self.view.addSubview(lblDateDisplay)
        
        myTableView = UITableView(frame: CGRect(x: 0, y: lblDateDisplay.frame.maxY+5, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-64-calendar.frame.size.height-5))
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundView=nil
        myTableView.backgroundColor=UIColor.clear
        myTableView.separatorColor=UIColor.clear
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view.addSubview(myTableView)
        myTableView.isHidden=true
        
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
    
    // MARK: - pressCalendar Method
    func createCalendar() -> Void
    {
        if ((calendar) != nil) {
            calendar.removeFromSuperview()
            calendar=nil;
        }
        
        let screenSize = UIScreen.main.bounds
        if(screenSize.height < 812.0){
         calendar = FSCalendar(frame: CGRect(x:0, y:64, width:UIScreen.main.bounds.size.width, height:300))
        }else{
         calendar = FSCalendar(frame: CGRect(x:0, y:84, width:UIScreen.main.bounds.size.width, height:300))
        }
        calendar.dataSource = self;
        calendar.delegate = self;
        calendar.allowsMultipleSelection=false
        calendar.swipeToChooseGesture.isEnabled=true
        calendar.backgroundColor=UIColor.white
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        calendar.setCurrentPage(currentDT as Date, animated: false)
        self.view.addSubview(calendar)
        self.calendar.accessibilityIdentifier = "calendar"
    }
    
    // MARK: - Calendar Delegate Method
    func todayItemClicked(sender: AnyObject)
    {
        self.calendar.setCurrentPage(Date(), animated: false)
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int
    {
        let dateString = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return 1
        }
        if self.datesWithMultipleEvents.contains(dateString) {
            return 3
        }
        return 0
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor?
    {
        return UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0)
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor?
    {
        print("currentDT>>><<<????",currentDT)
        print("self.datesWithEvent>>><<<????",self.datesWithEvent)
        
        let dateCT = self.dateFormatter2.string(from: currentDT as Date)
        let dateString = self.dateFormatter2.string(from: date)

        if self.datesWithEvent.contains(dateString)
        {
            if dateString == dateCT
            {
                print("Today Date")
                return UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0)
            }
            else
            {
                print("Not ")
                return UIColor.clear
            }
        }
        print("Not ")
        return UIColor.clear
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor?
    {
        print("currentDT>>><<<????",currentDT)
        print("self.datesWithEvent>>><<<????",self.datesWithEvent)
        
        let dateCT = self.dateFormatter2.string(from: currentDT as Date)
        let dateString = self.dateFormatter2.string(from: date)

        if self.datesWithEvent.contains(dateString)
        {
            if dateString == dateCT
            {
                print("Today Date")
                return UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0)
            }
            else
            {
                print("Not ")
                return UIColor.white
            }
        }
        print("Not ")
        //return UIColor.white
        return nil
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor?
    {
        return nil
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor?
    {
        return UIColor.clear
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor?
    {
        return UIColor.black
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor?
    {
        print("currentDT>>><<<????",currentDT)
        print("self.datesWithEvent>>><<<????",self.datesWithEvent)
        
        let dateCT = self.dateFormatter2.string(from: currentDT as Date)
        let dateString = self.dateFormatter2.string(from: date)

        if self.datesWithEvent.contains(dateString)
        {
            if dateString == dateCT
            {
                print("Today Date")
                return UIColor.white
            }
            else
            {
                print("Not")
                return UIColor(red: 78/255, green: 129/255, blue: 237/255, alpha: 1.0)
            }
        }
        print("Not")
        return nil
    }
  
    // MARK: - Calendar Datasource Method
    func calendarCurrentPageDidChange(_ calendar: FSCalendar)
    {
        print("-------------- calendarCurrentPageDidChange --------------------")
        
        /*let currentPageDate = calendar.currentPage
        let day = Calendar.current.component(.day, from: currentPageDate)
        print(day)
        let month = Calendar.current.component(.month, from: currentPageDate)
        print(month)
        let year = Calendar.current.component(.year, from: currentPageDate)
        print(year)
        let strTotalDate = String(format: "%@-%@-%@", year, month, day)
        print("--------------strTotalDate--------------",strTotalDate)*/
        
        
        let nowdtt=calendar.currentPage as NSDate
        strSelectedDate=self.dateFormatter2.string(from: nowdtt as Date) as NSString
        
        print("--------------currentDT--------------",currentDT)
        print("--------------strSelectedDate--------------",strSelectedDate)
       
        if (self.arrDateList.count > 0) {
            self.arrDateList.removeAllObjects()
        }
        
        if (self.arrDetailsJob.count > 0) {
            self.arrDetailsJob.removeAllObjects()
            self.myTableView.reloadData()
            self.lblDateDisplay.isHidden = true
        }
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchDateofTheMonth(strauthkey: strauthkey, strdate: strSelectedDate as String)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)
    {
        strSelectedDate=self.dateFormatter2.string(from: date) as NSString
        lblDateDisplay.text = strSelectedDate as String
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchBookedRescheduled(strauthkey: strauthkey, strdate: strSelectedDate as String)
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
    {
        if datesWithEvent.contains(dateFormatter2.string(from: date)){
            return true
        }else{
            return false
        }
    }
    
    // MARK: - TableView Delegate & Datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDetailsJob.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
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
        
        let dictemp: NSDictionary = arrDetailsJob[indexPath.row] as! NSDictionary
       
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: tableView.frame.size.width/1.5, height: 30))
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.text = String(format:"%@",(dictemp.value(forKey: "service_name") as? String)!)
        label.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        label.frame.size.width = label.intrinsicContentSize.width
        cell.contentView.addSubview(label)
        
        
        stridentifer = String(format:"%@",(dictemp.value(forKey: "booking_status") as? String)!) as NSString
        let label1 = UILabel(frame: CGRect(x: tableView.frame.size.width-110, y: 20, width: 100, height: 30))
        label1.textAlignment = .center
        label1.textColor = UIColor.white
        label1.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        cell.contentView.addSubview(label1)
        
        let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0)
        {
            //5S
            label1.frame =  CGRect(x: tableView.frame.size.width-100, y: label.frame.minY, width: 90, height: 30)
        }
        else if(screenSize.height == 480.0)
        {
            //4
             label1.frame =  CGRect(x: tableView.frame.size.width-100, y: label.frame.minY, width: 90, height: 30)
        }
        else
        {
            label1.frame =  CGRect(x: tableView.frame.size.width-110, y: label.frame.minY, width: 100, height: 30)
        }

        if (stridentifer .isEqual(to: "0"))
        {
            label1.text = "Booked"
            label1.textColor = UIColor(red: 131/255, green: 131/255, blue: 131/255, alpha: 1.0)
            label1.backgroundColor = UIColor.clear
            label1.layer.borderWidth=1.0
            label1.layer.borderColor=UIColor(red: 131/255, green: 131/255, blue: 131/255, alpha: 1.0).cgColor
            label1.layer.cornerRadius=4.0
            label1.layer.masksToBounds=true
        }
        else if (stridentifer .isEqual(to: "1"))
        {
            label1.text = "Rescheduled"
            label1.textColor = UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1.0)
            label1.backgroundColor = UIColor.clear
            label1.layer.borderWidth=1.0
            label1.layer.borderColor=UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1.0).cgColor
            label1.layer.cornerRadius=4.0
            label1.layer.masksToBounds=true
        }
        else if (stridentifer .isEqual(to: "4"))
        {
            label1.text = "Cancelled"
            label1.textColor = UIColor.red
            label1.backgroundColor = UIColor.clear
            label1.layer.borderWidth=1.0
            label1.layer.borderColor=UIColor.red.cgColor
            label1.layer.cornerRadius=4.0
            label1.layer.masksToBounds=true
        }
        
      /*  let label2 = UILabel(frame: CGRect(x: 15, y: label.frame.maxY, width: tableView.frame.size.width-40, height: 25))
        label2.textAlignment = .left
        label2.textColor = UIColor.darkGray
        label2.backgroundColor = UIColor.clear
        label2.text = String(format:"%@",(dictemp.value(forKey: "booking_requested_date") as? String)!)
        label2.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        cell.contentView.addSubview(label2)*/
        
        let label3 = UILabel(frame: CGRect(x: 15, y: label.frame.maxY, width: tableView.frame.size.width-45, height: 48))
        label3.textAlignment = .left
        label3.textColor = UIColor.darkGray
        label3.backgroundColor = UIColor.clear
        label3.numberOfLines=0
        label3.contentMode = .scaleToFill
        label3.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        label3.text = NSString(format:" Bulding no: %@, Flat no: %@",(dictemp.value(forKey: "building_address") as? String)!, (dictemp.value(forKey: "building_no") as? String)!,(dictemp.value(forKey: "flat_no") as? String)!) as String
        cell.contentView.addSubview(label3)
        
        
        let strbooking_status = dictemp.value(forKey: "booking_status") as? String
        if strbooking_status!.isEqual("0")
        {
            let strAck = dictemp.value(forKey: "booking_acknowledge") as? String
            if(strAck!.isEqual("Y"))
            {
                let imgvicon1 = UIImageView(frame: CGRect(x: tableView.frame.size.width-35, y: label.frame.maxY + 5, width:25, height:25))
                imgvicon1.backgroundColor = UIColor.clear
                imgvicon1.image = UIImage(named:"acked")
                cell.contentView.addSubview(imgvicon1)
            }
        }
        
        let labelSeparator = UILabel(frame: CGRect(x: 15, y: 89.7, width: tableView.frame.size.width-15, height: 0.3))
        labelSeparator.backgroundColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0)
        cell.contentView.addSubview(labelSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictemp: NSDictionary = arrDetailsJob[indexPath.row] as! NSDictionary
         let strbookingID = dictemp.value(forKey: "service_boooking_id") ?? String()
       // let strbookingID = dictemp.value(forKey: "service_boooking_id") as! Int
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
 
   
    //MARK: -   fetchDate Method
    func fetchDateofTheMonth(strauthkey:String, strdate:String)
    {
        self.hideLoadingMode()
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@%@", Constants.conn.ConnUrl, "customer_service_center/booked-rescheduled-servicedate/", strdate)
        print("posted string ---->",strconnurl)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue(strauthkey, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                // check for fundamental networking error
                self.hideLoadingMode()
               return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    self.hideLoadingMode()
                    let dictemp = NSMutableDictionary(dictionary: json)
                    print("(Calendar dictemp Date List)>>>>>",dictemp)
                    
                    let message_code =  String(format: "%@", dictemp.value(forKey: "message_code")as! CVarArg)
                    if (message_code == "1")
                    {
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        self.arrDateList.removeAllObjects()
                        var sum = 0
                        for i in 0..<arrm1.count
                        {
                            let dictemp1: NSDictionary = arrm1[i] as! NSDictionary
                            let strDate = dictemp1.value(forKey: "tenant_slot_date") as! String
                            self.arrDateList.add(strDate )
                            sum += i
                        }
                        
                        print("(Calendar Date List)>>>>>",self.arrDateList)
                        
                        
                        OperationQueue.main.addOperation{
                            self.hideLoadingMode()
                            self.datesWithEvent = self.arrDateList
                            for i in 0..<self.datesWithEvent.count
                            {
                                let currentdate=self.dateFormatter2.string(from: NSDate() as Date) as NSString
                                if currentdate.isEqual(to:  self.datesWithEvent[i] as! String)
                                {
                                    //Today have event
                                    self.lblDateDisplay.text = currentdate as String
                                    let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
                                    let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
                                    self.fetchBookedRescheduled(strauthkey: strauthkey, strdate: currentdate as String)
                                }
                                else
                                {
                                    //Today don't have event
                                }
                            }
                            self.calendar.reloadData()
                        }
                    }
                    else
                    {
                        //fail
                        self.hideLoadingMode()
                    }
                }
            }
            catch {
            self.hideLoadingMode()
            //print("Error -> \(error)")
            }
        }
        task.resume()
    }
   
    //MARK: -   fetchBookedRescheduled Method
    func fetchBookedRescheduled(strauthkey:String, strdate:String)
    {
           print("selected month", strdate)
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@%@", Constants.conn.ConnUrl, "customer_service_center/date-servicedetails/", strdate)
          print("strconnurl=\(strconnurl))")
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
                    //print("dictemp call-> \(dictemp)")
                    
                    let message_code =  String(format: "%@", dictemp.value(forKey: "message_code")as! CVarArg)
                    if (message_code == "1")
                    {
                        self.hideLoadingMode()
                        self.arrDetailsJob.removeAllObjects()
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        self.arrDetailsJob = NSMutableArray(array: arrm1)
                
                        OperationQueue.main.addOperation {
                            if(self.arrDetailsJob.count > 0)
                            {
                                self.hideLoadingMode()
                                self.myTableView.isHidden=false
                                self.myTableView.reloadData()
                                self.lblDateDisplay.isHidden = false
                            }
                            else
                            {
                                self.hideLoadingMode()
                                self.myTableView.reloadData()
                                self.myTableView.isHidden=true
                                self.lblDateDisplay.isHidden = true
                            }
                        }
                        
                    }
                    else if (message_code == "0")
                    {
                          self.hideLoadingMode()
                        // if current date have no data
                        OperationQueue.main.addOperation {
                        self.myTableView.isHidden=true
                        self.myTableView.reloadData()
                        self.lblDateDisplay.isHidden = true
                      
                        }
                    }
                    else
                    {
                        //fail
                         self.hideLoadingMode()
                        OperationQueue.main.addOperation {
                         self.myTableView.reloadData()
                         self.myTableView.isHidden=true
                         self.lblDateDisplay.isHidden = true
                       
                        }
                    }
                    
                }
            }
            catch {
                self.hideLoadingMode()
                //print("Error -> \(error)")
            }
        }
        task.resume()
    }
    @IBAction func btnNotification(_ sender: Any) {
        
        let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let hh = self.navigationController?.navigationBar.frame.maxY
        print("nav bar  : %@",hh ?? (Any).self)
     
        if hh == -20.0 || navigationBarHeight == 64.0{
            var obj = MessageList()
            obj = MessageList(nibName: "MessageList", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else{
            var obj = MessageList()
            obj = MessageList(nibName: "MessageListX", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
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
