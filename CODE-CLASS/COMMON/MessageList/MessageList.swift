//
//  MessageList.swift
//  AlMutlaqRealEstate
//
//  Created by Sabnam Nasrin on 19/12/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class MessageList: UIViewController, UITableViewDataSource, UITableViewDelegate{
      var loadingCircle = UIView()
    @IBOutlet var lblServiceHistory: UILabel!
    
   
    let cellReuseIdentifier = "cell"
    @IBOutlet var tableMessage: UITableView!
    
    var arrMessagelist = NSMutableArray()
    
    var arrMNote = NSMutableArray()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //  self.tableServiceNote.layoutSubviews()
      
       
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
     
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
    
        self.fetchComplainlist(strauthkey: strauthkey)
        tableMessage.reloadData()
        
        tableMessage.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        tableMessage.backgroundView=nil
        tableMessage.backgroundColor=UIColor.clear
        tableMessage.separatorColor=UIColor.clear
        tableMessage.delegate = self
        tableMessage.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        tableMessage.estimatedRowHeight = UITableViewAutomaticDimension
        tableMessage.rowHeight = UITableViewAutomaticDimension
        tableMessage.allowsSelection = false
        
        self.tableMessage.register(UINib(nibName: "MessageCell", bundle: Bundle.main), forCellReuseIdentifier: "MessageCell")
        //  self.tableServiceNote.setNeedsLayout()
        //  self.tableServiceNote.layoutIfNeeded()
        //  tableServiceNote.reloadData()
    }
    
    @IBAction func pressBack(_ sender: Any) {
          self.navigationController?.popViewController(animated: true)
    }
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessagelist.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        let dictemp: NSDictionary = arrMessagelist[indexPath.row] as! NSDictionary
        
        print("arrMNotelist -- %@",arrMessagelist)
        //  let strservicename = String(format:"%@",(dictemp.value(forKey: "service_name") as? String)!)
        
        cell.lblDate.text = String(format:"%@",(dictemp.value(forKey: "posted_date") as? CVarArg)!)
        cell.lblTime.text = String(format:"%@",(dictemp.value(forKey: "posted_time") as? String)!)
        cell.lblSubject.text = String(format: "%@",(dictemp.value(forKey: "message_subject"))! as! CVarArg)
        cell.lblMessage.text = String(format:"%@",(dictemp.value(forKey: "message_text") as? String)!)
        
        cell.lblSubject.sizeToFit()
        cell.lblSubject.layoutIfNeeded()
        cell.lblSubject.numberOfLines = 2
        
        cell.lblMessage.sizeToFit()
        cell.lblMessage.layoutIfNeeded()
        cell.lblMessage.numberOfLines = 0
        
      return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    //MARK: -  fetch complain-list Method
    func fetchComplainlist(strauthkey:String )
    {
        self.showLoadingMode()
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "send_message")
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
                    
                    let message_code =  String(format: "%@", dictemp.value(forKey: "message_code")as! CVarArg)
                    if (message_code == "1")
                    {
                   
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        self.arrMessagelist = NSMutableArray(array: arrm1)
                        OperationQueue.main.addOperation {
                            self.tableMessage.reloadData()
                       }
                    }
                    else  if (message_code == "0")
                    {//fail
                        
                        OperationQueue.main.addOperation {
                            self.tableMessage.reloadData()
                           let lblDisplay = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width/2-100, y: 0, width: 200, height: 30))
                            lblDisplay.center = self.view.center
                           lblDisplay.textAlignment = .center
                            lblDisplay.textColor = UIColor.black
                            lblDisplay.backgroundColor = UIColor.clear
                            lblDisplay.text = "There is no message ."
                            lblDisplay.font = UIFont(name: "Roboto-Regular", size: 14.0)!
                            lblDisplay.layer.cornerRadius = 6.0
                            lblDisplay.layer.masksToBounds = true
                            self.view.addSubview( lblDisplay)
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
