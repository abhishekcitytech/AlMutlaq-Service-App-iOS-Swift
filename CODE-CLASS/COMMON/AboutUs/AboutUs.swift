//
//  AboutUs.swift
//  AlMutlaqRealEstate
//
//  Created by Sabnam Nasrin on 19/12/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit
import WebKit

class AboutUs: UIViewController,UIScrollViewDelegate,WKUIDelegate,UIWebViewDelegate
{
    var loadingCircle = UIView()
    @IBOutlet var viewtop: UIView!
    
    @IBOutlet var vwSecond: UIView!
    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var imgvLogo: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgvOffcie: UIImageView!
  //  @IBOutlet var lblDescription: UITextView!
    
    @IBOutlet var webVieww: UIWebView!
    @IBOutlet var view1: UIView!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var btnAddress: UIButton!
    
    @IBOutlet var view2: UIView!
    @IBOutlet var btnWebsite: UIButton!
    @IBOutlet var lblWebsite: UILabel!
    
    @IBOutlet var view3: UIView!
    @IBOutlet var btnVideo: UIButton!
    @IBOutlet var lblVideo: UILabel!
     var webviewVideo = UIWebView()
       var vwWeb = UIView()
    var arrAboutUslist = NSMutableArray()
  
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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.FetchCompanyDetails()
        imgvLogo.layer.borderWidth = 0.25
        imgvLogo.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        imgvLogo.layer.cornerRadius = imgvLogo.frame.size.width/2
       imgvLogo.layer.masksToBounds = true
        
      
        view2.layer.cornerRadius = 4.0
        view2.layer.masksToBounds = true
        view3.layer.cornerRadius = 4.0
        view3.layer.masksToBounds = true
        
        self.scroll.contentSize = CGSize(width:  self.scroll.frame.size.width, height: view3.frame.maxY+20)
        vwSecond.frame.size.height = view3.frame.maxY+20
        
         webVieww.frame.size.height = vwSecond.frame.maxY - (webVieww.frame.minY + self.view3.frame.size.height+30)
      /*  webviewVideo.backgroundColor = UIColor.clear
        let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
        webviewVideo.loadRequest(URLRequest(url: url))*/
        
    }
    
    // MARK: - Address Click button
    @IBAction func pressAddressClick(_ sender: Any)
    {
        vwWeb.removeFromSuperview()
        // let dictemp: NSDictionary = self.arrAboutUslist[0] as! NSDictionary
     //   let strAddress =  String(format: "%@", dictemp.value(forKey: "company_address") as! CVarArg)
     
      //  UIApplication.shared.open(URL(string: strAddress)!, options: [:], completionHandler: nil)
        
       // UIApplication.shared.open(URL(string: "https://www.google.com/maps/place/Mutlaq+Al+Mutlaq+Real+Estate/@25.310461,55.372805,15z/data=!4m5!3m4!1s0x0:0xdba4ceca0034c273!8m2!3d25.3104608!4d55.372805?hl=en-US")!, options: [:], completionHandler: nil)
    }
    
    // MARK: - WebSite Click button
    @IBAction func pressWebsiteClick(_ sender: Any)
    {
 
          vwWeb.removeFromSuperview()
       let dictemp: NSDictionary = self.arrAboutUslist[0] as! NSDictionary
       let websiteUrl =   String(format: "%@", dictemp.value(forKey: "company_website_url") as! CVarArg)
        UIApplication.shared.open(URL(string: websiteUrl)!, options: [:], completionHandler: nil)
      
    }
    
    // MARK: - Video Click button
    @IBAction func pressVideoClick(_ sender: Any)
    {
        vwWeb.removeFromSuperview()
       vwWeb = UIView(frame: CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 160))
        vwWeb.backgroundColor = UIColor.black
        
        let buttonDone = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width-42, y: 30, width: 32, height: 32))
        buttonDone.backgroundColor = UIColor.clear
        buttonDone.tag=1
        buttonDone.setImage(UIImage(named: "cross1"), for: .normal)
        buttonDone.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
        buttonDone.addTarget(self, action: #selector(pressDone), for: .touchUpInside)
        vwWeb.addSubview(buttonDone)
        
        webviewVideo = UIWebView(frame: CGRect(x:0, y:buttonDone.frame.maxY+5, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height-180))
        webviewVideo.scalesPageToFit = true
        webviewVideo.delegate = self
        vwWeb.addSubview(webviewVideo)
        
        self.view.addSubview(vwWeb)
        let dictemp: NSDictionary = self.arrAboutUslist[0] as! NSDictionary
        let VideoUrl =   String(format: "%@", dictemp.value(forKey: "company_video_link") as! CVarArg)
        let myURL = URL(string: VideoUrl)
   //     let myURL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
       let myURLRequest:URLRequest = URLRequest(url: myURL!)
       webviewVideo.loadRequest(myURLRequest)
         self.showLoadingMode()
        
    }
    @objc func pressDone(){
    
        self.vwWeb.removeFromSuperview()
    }
    // MARK: - btnBack button
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
     //MARK: -  webView delegate Method
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        
        print("Started to load")
    }
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
         self.hideLoadingMode()
        print("Finished loading")
    }
    //MARK: -  Fetch Company Details Method
    func  FetchCompanyDetails()
    {
        let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.showLoadingMode()
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "about_us")
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
                        //success
                        let arrm1 :NSArray =  json.value(forKey: "data") as! NSArray
                        self.arrAboutUslist = NSMutableArray(array: arrm1)
                        
                        let dictemp: NSDictionary = self.arrAboutUslist[0] as! NSDictionary
                          OperationQueue.main.addOperation {
                        self.lblName.text =  String(format: "%@", dictemp.value(forKey: "company_name") as! CVarArg)
                        self.lblAddress.text =  String(format: "%@", dictemp.value(forKey: "company_address") as! CVarArg)
                            
                       let pageHtml  = String(format: "%@", dictemp.value(forKey: "company_description") as! CVarArg)
                       self.webVieww.loadHTMLString(pageHtml,
                                                     baseURL: nil)
                            
                            //logo
                            let strUrl = String(format: "%@", dictemp.value(forKey: "company_logo") as! CVarArg)
                            if(strUrl .isEqual("")){
                                self.imgvLogo.image=UIImage(named: "userprof")
                            }
                            else{
                                let imageUrl = String(format: "%@", (dictemp.value(forKey: "company_logo") as? CVarArg)!)
                                self.imgvLogo.imageFromURL(urlString: imageUrl)
                                
                            }
                            // company
                            let strImage = String(format: "%@", dictemp.value(forKey: "company_image") as! CVarArg)
                            if(strImage .isEqual("")){
                                self.imgvOffcie.image=UIImage(named: "no_image.png")
                            }
                            else{
                                
                                
                                let officeUrl = dictemp.value(forKey: "company_image") as! String
                                self.imgvOffcie.imageFromURL(urlString: officeUrl)
                                
                            }
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
