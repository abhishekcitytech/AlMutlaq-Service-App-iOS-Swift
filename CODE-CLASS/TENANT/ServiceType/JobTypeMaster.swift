//
//  JobTypeMaster.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 03/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class JobTypeMaster: ViewController,UITableViewDataSource, UITableViewDelegate
{
    var loadingCircle = UIView()
    var arrMServicelist = NSMutableArray()
    
    @IBOutlet var viewtop: UIView!
    let cellReuseIdentifier = "cell"
    @IBOutlet var tabvMenu: UITableView!

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
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        //print("dictemp :%@",dictemp)
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchServicetype(strauthkey: strauthkey )
        
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 174/255, green: 174/255, blue: 174/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: viewtop.frame.size.height - width, width: viewtop.frame.size.width, height: viewtop.frame.size.height)
        border.borderWidth = width
        viewtop.layer.addSublayer(border)
        viewtop.layer.masksToBounds = true
        
        tabvMenu.separatorColor=UIColor.clear
        tabvMenu.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any)
    {
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - tableView delegate & datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMServicelist.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
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
        cell.backgroundColor=UIColor.clear
        
        let dictemp: NSDictionary = arrMServicelist[indexPath.row] as! NSDictionary
        
        let imgvicon = UIImageView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 180))
        imgvicon.backgroundColor = UIColor.gray
        //imgvicon.image = UIImage(named:dictemp.value(forKey: "service_image") as! String)
        cell.contentView.addSubview(imgvicon)
        
      /*  DispatchQueue.global(qos: .background).async {
            // Background Thread
            let imageUrl = dictemp.value(forKey: "service_image") as! String
            let url = URL(string: imageUrl)
            let imageData:NSData = NSData(contentsOf: url!)!
            DispatchQueue.main.async {
                // Run UI Updates or call completion block
                imgvicon.backgroundColor = UIColor.white
                let image = UIImage(data: imageData as Data)
                imgvicon.image = image
            }
        }*/
        let imageUrl = dictemp.value(forKey: "service_image") as! String
        imgvicon.imageFromURL(urlString: imageUrl)
     //   imageFromURL
        
        let labelshadow = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 180))
        labelshadow.textAlignment = .center
        labelshadow.backgroundColor = UIColor.black
        labelshadow.alpha=0.4
        cell.contentView.addSubview(labelshadow)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 180))
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = String(format:"%@",(dictemp.value(forKey: "service_name") as? String)!)
        label.font = UIFont(name: "Roboto-Regular", size: 23.0)!
        cell.contentView.addSubview(label)
        
        let labelSeparator = UILabel(frame: CGRect(x: 0, y: 176, width: tableView.frame.size.width, height: 4))
        labelSeparator.backgroundColor = UIColor.white
        cell.contentView.addSubview(labelSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
         let dictemp: NSDictionary = arrMServicelist[indexPath.row] as! NSDictionary
         print(dictemp.value(forKey: "service_id") ?? String())
        
         var obj = Tenantjobcreate()
        
       //  self.navigationController?.pushViewController(obj, animated: true)
          OperationQueue.main.addOperation {
        let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
            //5S
            obj = Tenantjobcreate(nibName: "Tenantjobcreate5S", bundle: nil)
        }
        else  if (screenSize.height == 480.0){
            //5S
            obj = Tenantjobcreate(nibName: "Tenantjobcreate4S", bundle: nil)
        }
        else if(screenSize.height == 667.0){
            //6
            obj = Tenantjobcreate(nibName: "Tenantjobcreate", bundle: nil)
        }
        else if(screenSize.height == 736.0){
            // 6Plus
            obj = Tenantjobcreate(nibName: "Tenantjobcreate6Plus", bundle: nil)
        }
        else if(screenSize.height == 812.0){
            //x
            obj = Tenantjobcreate(nibName: "TenantjobcreateX", bundle: nil)
        }
        else
        {
            obj = Tenantjobcreate(nibName: "TenantjobcreateXSMAX", bundle: nil)
            
        }
     
            let strsid = "\(dictemp.value(forKey: "service_id") ?? "")"
          obj.strServicetypeid =  String(strsid) as NSString
            obj.strServicetype=dictemp.value(forKey: "service_name") as! String as NSString
        self.navigationController?.pushViewController(obj, animated: true)
        }
    }
    
    //MARK: -   fetchServicetype Method
    func fetchServicetype(strauthkey:String)
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "tenant/service-list")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        //let postString = ""
        request.setValue(strauthkey, forHTTPHeaderField: "Authorization")
        //request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
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
                    //print("dictemp -> \(dictemp)")
                    
                    let message_code:Int = dictemp.value(forKey: "message_code") as! Int
                    if (message_code == 1){
                        //success
                        
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        self.arrMServicelist = NSMutableArray(array: arrm1)
                        //print("self.arrMServicelist -> \(self.arrMServicelist)")
                        
                        OperationQueue.main.addOperation {
                            self.tabvMenu.reloadData()
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
extension UIImageView {
    public func imageFromURL(urlString: String) {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.color =  UIColor(red: 78.0/255, green: 129.0/255, blue: 237.0/255, alpha: 1.0)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
//        if self.image == nil{
//            self.addSubview(activityIndicator)
//        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
            })
            
        }).resume()
    }
}
