//
//  Tutorials.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 18/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class Tutorials: UIViewController , UIScrollViewDelegate{

    var  arrMBanners = NSMutableArray()
    var  arrMBannersLogo = NSMutableArray()
    var  arrMBannersHeader = NSMutableArray()
    
   
     var scrollpageImage = UIScrollView()
    var pageControl = UIPageControl()
    
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
         self.scrollpageImage = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
     self.view.addSubview( self.scrollpageImage)
        
        
        
        UserDefaults.standard.set(1, forKey: "tutoriallaunch")
        UserDefaults.standard.synchronize()
        
        
        UserDefaults.standard.set(0, forKey: "dataNotSave")
        UserDefaults.standard.synchronize()
        arrMBanners = ["tutorial", "tutorial", "tutorial",]
        arrMBannersLogo = ["roundlogo-w", "roundlogo-w", "roundlogo-w",]
        arrMBannersHeader = ["Home service requirement", "Best Serviceman for you", "Get start with us",]
        
        self.pagecontrollerTutorials()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - pagecontrollerTutorials Method
    func pagecontrollerTutorials() -> Void
    {
        self.automaticallyAdjustsScrollViewInsets=false
         self.scrollpageImage.isPagingEnabled=true
         self.scrollpageImage.showsHorizontalScrollIndicator=false
         self.scrollpageImage.delegate=self;
         self.scrollpageImage.backgroundColor=UIColor.white
      
        let widthhh = UIScreen.main.bounds.width * CGFloat(arrMBanners.count)
        let heighttt = UIScreen.main.bounds.height
         self.scrollpageImage.contentSize=CGSize(width: widthhh, height: heighttt)
        
        self.pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height-100, width: 200, height: 50))
        self.pageControl.center = CGPoint (x: self.view.frame.size.width/2.0, y:  UIScreen.main.bounds.size.height/2.0 + UIScreen.main.bounds.size.height/3.0)
        self.pageControl.numberOfPages = arrMBanners.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor(red: 78.0/255, green: 129.0/255, blue: 238.0/255, alpha: 1.0)
        self.pageControl.pageIndicatorTintColor = UIColor(red: 211/255, green: 182/255, blue: 42/255, alpha: 1.0)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 78.0/255, green: 129.0/255, blue: 238.0/255, alpha: 1.0)
        self.view.addSubview(pageControl)
        self.view.bringSubview(toFront: pageControl)
        
        for x in 0 ..< arrMBanners.count
        {
            print("pages",x)
            
            let widthhh =  self.scrollpageImage.bounds.size.width * CGFloat(x)
            
            let viewPage = UIView(frame: CGRect(x: widthhh, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            viewPage.tag=x
             self.scrollpageImage.addSubview(viewPage)
            
            let imgviconBG = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            imgviconBG.backgroundColor = UIColor.clear
          let rowimagename = "\(arrMBanners[x])"
           imgviconBG.image = UIImage(named:rowimagename)
            viewPage.addSubview(imgviconBG)
            
            
            let imgvicon = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
            imgvicon.backgroundColor = UIColor.clear
            imgvicon.center = CGPoint(x: viewPage.bounds.size.width/2, y: viewPage.bounds.size.height/2-160)
            let rowimagename1 = "\(arrMBannersLogo[x])"
            imgvicon.image = UIImage(named:rowimagename1)
            viewPage.addSubview(imgvicon)
             print("scrollpageImage", self.scrollpageImage.frame)
            print("viewPage",viewPage.frame)
            print("imgviconBG",imgviconBG.frame)
            //-------Header ------//
            let labelHeader = UILabel(frame: CGRect(x: 40, y: imgvicon.frame.maxY + 30, width: viewPage.frame.size.width-80, height:40))
            labelHeader.textAlignment = .center
            labelHeader.numberOfLines=2;
            labelHeader.textColor = UIColor(red: 211/255, green: 182/255, blue: 42/255, alpha: 1.0)
            labelHeader.backgroundColor = UIColor.clear
            labelHeader.text = arrMBannersHeader[x] as? String
            labelHeader.font = UIFont(name: "Roboto-Bold", size: 21.0)!
            viewPage.addSubview(labelHeader)
            
            let labelsubtitle = UILabel(frame: CGRect(x: 40, y: labelHeader.frame.maxY + 5, width: viewPage.frame.size.width-80, height:120))
            labelsubtitle.textAlignment = .center
            labelsubtitle.numberOfLines=10;
            labelsubtitle.textColor = UIColor.white
            labelsubtitle.backgroundColor = UIColor.clear
            labelsubtitle.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."
            labelsubtitle.font = UIFont(name: "Roboto-Regular", size: 15.0)!
            viewPage.addSubview(labelsubtitle)
            
            
            let buttonSkip = UIButton(frame: CGRect(x: 0, y: viewPage.frame.maxY-50, width: 80, height: 50))
            buttonSkip.backgroundColor=UIColor.clear
            buttonSkip.tag=x
            buttonSkip.setTitle("Skip", for: .normal)
            buttonSkip.setTitleColor(UIColor(red: 211/255, green: 182/255, blue: 42/255, alpha: 1.0), for: .normal)
            buttonSkip.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
            buttonSkip.addTarget(self, action: #selector(buttonActionSkip), for: .touchUpInside)
            viewPage.addSubview(buttonSkip)
            
            let buttonNext = UIButton(frame: CGRect(x:  self.scrollpageImage.frame.maxX-80, y: viewPage.frame.maxY-50, width: 80, height: 50))
            buttonNext.backgroundColor=UIColor.clear
            buttonNext.tag=x
            buttonNext.setTitleColor(UIColor(red: 211/255, green: 182/255, blue: 42/255, alpha: 1.0), for: .normal)
            buttonNext.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18.0)!
            buttonNext.addTarget(self, action: #selector(buttonActionNext), for: .touchUpInside)
            viewPage.addSubview(buttonNext)
            
            let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
            let hh = self.navigationController?.navigationBar.frame.maxY
          // X
            if hh == -20.0 || navigationBarHeight == 64.0{
            }else{
                  buttonNext.frame =  CGRect(x:  self.scrollpageImage.frame.maxX-80, y: viewPage.frame.maxY-80, width: 80, height: 50)
                 buttonSkip.frame =  CGRect(x: 0, y: viewPage.frame.maxY-80, width: 80, height: 50)
            }
            
            
            if(x == 0){
                viewPage.backgroundColor=UIColor.green
                buttonNext.setTitle("Next", for: .normal)
            }
            else if(x == 1){
                viewPage.backgroundColor=UIColor.gray
                buttonNext.setTitle("Next", for: .normal)
               
            }
            else if(x == 2){
                viewPage.backgroundColor=UIColor.yellow
                buttonNext.setTitle("Finish", for: .normal)
                
            }
        }
    }
    @objc func buttonActionSkip(){
        var obj = login()
        obj = login(nibName: "login", bundle: nil)
        self.navigationController?.pushViewController(obj, animated: true)

    }
    @objc func buttonActionNext(sender:UIButton)
    {
        //print("Button Next")
        if(sender.tag == 2){
          //Finish
           var obj = login()
           obj = login(nibName: "login", bundle: nil)
           self.navigationController?.pushViewController(obj, animated: true)
        }
        else
        {
            if (  self.scrollpageImage.contentOffset.x <=  self.scrollpageImage.contentSize.width ){
                let rect = CGRect(x:  self.scrollpageImage.contentOffset.x +  self.scrollpageImage.frame.size.width, y: 0, width:  self.scrollpageImage.frame.size.width, height:  self.scrollpageImage.frame.size.height)
                
                 self.scrollpageImage.scrollRectToVisible(rect, animated: true)
            }
        }
    }
    
    // MARK: - ScrollView Delegate Method
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let pageWidth =  self.scrollpageImage.bounds.size.width
        let fractionalPage =  self.scrollpageImage.contentOffset.x / pageWidth
        let nearestNumber = lround(Double(fractionalPage))
        if (pageControl.currentPage != nearestNumber){
            pageControl.currentPage = nearestNumber ;
            if ( self.scrollpageImage.isDragging){
                pageControl.updateCurrentPageDisplay()
            }
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        print("end scroll")
        pageControl.updateCurrentPageDisplay()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
