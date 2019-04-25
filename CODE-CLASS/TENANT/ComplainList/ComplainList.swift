
//
//  ComplainList.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 18/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class ComplainList: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var loadingCircle = UIView()
    
    let cellReuseIdentifier = "cell"
    var stridentifer = NSString()
    @IBOutlet var tabvList: UITableView!

    @IBOutlet var viewtop: UIView!
    @IBOutlet var viewHeader: UIView!
    @IBOutlet var imgvSelected: UIImageView!
    @IBOutlet var btnSuggestion: UIButton!
    @IBOutlet var btnComplain: UIButton!
    
    var arrMMain = NSMutableArray()
    var strSugCompain = NSString()
     var strIdentSugCompain = NSString()
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
      print("strSugCompain--- %@",strSugCompain)
      print("stridentifer--- %@",stridentifer)
      print("strIdentSugCompain--- %@",strIdentSugCompain)
        
        
        
        
        if strSugCompain == "C"{
         
            btnComplain.isSelected=true
            btnSuggestion.isSelected=false
            imgvSelected.image = UIImage(named: "barselected")
            self.animateToActiveButton(btn: btnComplain, img: imgvSelected)
          
         
        }
        else if strSugCompain == "S"{
            btnSuggestion.isSelected=true
            btnComplain.isSelected=false
           
            imgvSelected.image = UIImage(named: "barselected")
            self.animateToActiveButton(btn: btnSuggestion, img: imgvSelected)
            
        }
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchComplainlist(strauthkey: strauthkey, strType: strSugCompain as String)
        
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        stridentifer="1"
        strSugCompain = "C"
    
        if strIdentSugCompain != ""{
             strSugCompain = strIdentSugCompain
            
        }
       
        
        
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
        strIdentSugCompain = ""
       self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - animateToActiveButton Method
    func animateToActiveButton(btn: UIButton, img:UIImageView) -> Void
    {
        img.backgroundColor=UIColor.white
        UIView.animate(withDuration: 0.2, animations: {
            img.frame=btn.frame
        }, completion:{ _ in
            
        })
    }
    
    // MARK: - pressAddComplaint Method
    @IBAction func pressAddComplaint(_ sender: Any)
    {
        var obj = AddComplain()
        let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
            //5S
            obj = AddComplain(nibName: "AddComplain5S", bundle: nil)
        }
        else if (screenSize.height == 480.0){
            //5S
            obj = AddComplain(nibName: "AddComplain4S", bundle: nil)
        }
        else if(screenSize.height == 667.0){
            //6
            obj = AddComplain(nibName: "AddComplain", bundle: nil)
        }
        else if(screenSize.height == 736.0){
            // 6Plus
            obj = AddComplain(nibName: "AddComplain6Plus", bundle: nil)
        }
        else if(screenSize.height == 812.0){
            //x
            obj = AddComplain(nibName: "AddComplainX", bundle: nil)
        }
        else
        {
            obj = AddComplain(nibName: "AddComplainXSMAX", bundle: nil)
            
        }
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    // MARK: - press Complain && Suggestions Method
    @IBAction func pressComplain(_ sender: Any)
    {
        strSugCompain = "C"
        if btnComplain.isSelected == true{
        }
        else{
            stridentifer="0"
            btnComplain.isSelected=true
            btnSuggestion.isSelected=false
        }
        imgvSelected.image = UIImage(named: "barselected")
        self.animateToActiveButton(btn: btnComplain, img: imgvSelected)
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchComplainlist(strauthkey: strauthkey, strType: strSugCompain as String)
           print("strSugCompain--- %@",strSugCompain)
        OperationQueue.main.addOperation {
            self.tabvList.reloadData()
        }
        
    }
    @IBAction func pressSuggestion(_ sender: Any)
    {
        strSugCompain = "S"
        if btnSuggestion.isSelected == true{
        }
        else{
           // stridentifer="0"
            btnSuggestion.isSelected=true
            btnComplain.isSelected=false
        }
        imgvSelected.image = UIImage(named: "barselected")
        self.animateToActiveButton(btn: btnSuggestion, img: imgvSelected)
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchComplainlist(strauthkey: strauthkey, strType: strSugCompain as String)
           print("strSugCompain--- %@",strSugCompain)
        OperationQueue.main.addOperation {
            self.tabvList.reloadData()
        }
    }
    
    // MARK: - tableView delegate & datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMMain.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
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
        
        let dictemp: NSDictionary = arrMMain[indexPath.row] as! NSDictionary
        
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: tableView.frame.size.width-100, height: 25))
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.numberOfLines=1;
        label.text = (dictemp.value(forKey: "complain_subject") as! String)
        label.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        cell.contentView.addSubview(label)
        
        let label1 = UILabel(frame: CGRect(x: 15, y: label.frame.maxY, width: tableView.frame.size.width-30, height:30))
        label1.text = (dictemp.value(forKey: "complain_note") as! String)
        label1.textAlignment = .left
        label1.textColor = UIColor.darkGray
        label1.backgroundColor = UIColor.clear
        label1.font = UIFont(name: "Roboto-Regular", size: 14.0)!
        label1.numberOfLines = 1
        cell.contentView.addSubview(label1)
        
        let lblOpenClose = UILabel(frame: CGRect(x: label.frame.maxX+5, y: 10, width: 60, height: 25))
        lblOpenClose.textAlignment = .center
        lblOpenClose.font = UIFont(name: "Roboto-Bold", size: 13.0)!
        cell.contentView.addSubview(lblOpenClose)
        
        let strOpenClose = String(format:"%@",(dictemp.value(forKey: "complain_status") as? String)!) as NSString
        if (strOpenClose .isEqual(to: "0"))
        {
            lblOpenClose.textColor = UIColor(red: 255.0/255, green: 147.0/255, blue: 0.0/255, alpha: 1.0)
            lblOpenClose.text="OPEN"
            lblOpenClose.backgroundColor = UIColor.clear
        }
        else
        {
            lblOpenClose.textColor = UIColor(red: 127.0/255, green: 186.0/255, blue: 2.0/255, alpha: 1.0)
            lblOpenClose.text="CLOSED"
            lblOpenClose.backgroundColor = UIColor.clear
        }
        
        let labelSeparator = UILabel(frame: CGRect(x: 15, y: 64.5, width: tableView.frame.size.width-15, height: 0.5))
        labelSeparator.backgroundColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0)
        cell.contentView.addSubview(labelSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictemp: NSDictionary = arrMMain[indexPath.row] as! NSDictionary
       
        var obj = Complaindetails()
        let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
            //5S
            obj = Complaindetails(nibName: "Complaindetails5S", bundle: nil)
        }
        else if (screenSize.height == 480.0){
            //5S
            obj = Complaindetails(nibName: "Complaindetails4S", bundle: nil)
        }
        else if(screenSize.height == 667.0){
            //6
            obj = Complaindetails(nibName: "Complaindetails", bundle: nil)
        }
        else if(screenSize.height == 736.0){
            // 6Plus
            obj = Complaindetails(nibName: "Complaindetails6Plus", bundle: nil)
        }
        else if(screenSize.height == 812.0){
            //x
            obj = Complaindetails(nibName: "ComplaindetailsX", bundle: nil)
        }
        else
        {
            obj = Complaindetails(nibName: "ComplaindetailsXSMAX", bundle: nil)
            
        }
        obj.dicComplainDetails =  NSMutableDictionary(dictionary: dictemp)
        self.navigationController?.pushViewController(obj, animated: true)
    }
  
    //MARK: -  fetch complain-list Method
    func fetchComplainlist(strauthkey:String , strType:String)
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@/%@", Constants.conn.ConnUrl, "tenant/complain-list",strType)
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
                //    print("dictemp -> \(dictemp)")
                    
                    let message_code:Int = dictemp.value(forKey: "message_code") as! Int
                    if (message_code == 1)
                    {
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        self.arrMMain = NSMutableArray(array: arrm1)
                        OperationQueue.main.addOperation {
                            self.tabvList.reloadData()
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
