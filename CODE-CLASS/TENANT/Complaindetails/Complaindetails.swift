//
//  Complaindetails.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 18/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class Complaindetails: UIViewController
{
    var dicComplainDetails = NSMutableDictionary()
    
    @IBOutlet var lblHeader: UILabel!
    
    @IBOutlet var viewtop: UIView!
    @IBOutlet var scrollOverall: UIScrollView!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var txtvNotes: UITextView!
    @IBOutlet var lblSubject: UILabel!
    
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
        
        viewtop.layer.shadowColor = UIColor.lightGray.cgColor
        viewtop.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewtop.layer.shadowRadius = 0.0
        viewtop.layer.shadowOpacity = 2.0
        viewtop.layer.masksToBounds = false
        
        let border1 = CALayer()
        let width1 = CGFloat(1.0)
        border1.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        border1.frame = CGRect(x: 0, y: lblSubject.frame.size.height - width1, width: lblSubject.frame.size.width, height: lblSubject.frame.size.height)
        border1.borderWidth = width1
        lblSubject.layer.addSublayer(border1)
        lblSubject.layer.masksToBounds = true
        txtvNotes.layer.borderWidth=1.0
        txtvNotes.layer.borderColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0).cgColor
        txtvNotes.layer.cornerRadius = 4.0
        txtvNotes.layer.masksToBounds = true
        
        lblSubject.text=dicComplainDetails.value(forKey: "complain_subject") as? String
        
        let complain_close_note:String = dicComplainDetails.value(forKey: "complain_close_note") as! String
        let complain_note:String = (dicComplainDetails.value(forKey: "complain_note") as? String)!
        
        if(complain_close_note .isEqual(""))
        {
            txtvNotes.text=dicComplainDetails.value(forKey: "complain_note") as? String
        }
        else
        {
      
     
        let blackColor = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font:  UIFont(name: "Roboto-Regular", size: 14.0)!]
            
          let finalString =  NSMutableAttributedString(string: String(format: "%@ \n\n\n",complain_note as CVarArg), attributes: blackColor)
      
        let RedColor = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.font:  UIFont(name: "Roboto-Regular", size: 16.0)!]
            
        let partTwo = NSMutableAttributedString(string: "Closed Note :  ", attributes: RedColor)
            finalString.append(partTwo)
            
        let RedColor1 = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.font:  UIFont(name: "Roboto-Regular", size: 14.0)!]
        let partClosed = NSMutableAttributedString(string: complain_close_note, attributes: RedColor1)
            finalString.append(partClosed)
             txtvNotes.attributedText =  finalString
        }
        
        let complaintype:String = dicComplainDetails.value(forKey: "complain_type") as! String
        if(complaintype .isEqual("C"))
        {
            lblHeader.text="Complaint Details"
        }else{
            lblHeader.text="Suggestion Details"
        }
        
        
        let status_code:String = dicComplainDetails.value(forKey: "complain_status") as! String
        if(status_code .isEqual("0"))
        {
            let label1 = UILabel(frame: CGRect(x: lblDescription.frame.maxX-80, y: lblDescription.frame.minY, width: 80, height: 30))
            label1.textAlignment = .center
            label1.textColor = UIColor(red: 255.0/255, green: 147.0/255, blue: 0.0/255, alpha: 1.0)
            label1.backgroundColor = UIColor.clear
            label1.text = "OPEN"
            label1.font = UIFont(name: "Roboto-Bold", size: 14.0)!
            label1.layer.cornerRadius = 4.0
            label1.layer.masksToBounds = true
            scrollOverall.addSubview(label1)
        }
        else
        {
            let label1 = UILabel(frame: CGRect(x: lblDescription.frame.maxX-80, y: lblDescription.frame.minY, width: 80, height: 30))
            label1.textAlignment = .center
            label1.textColor = UIColor(red: 127.0/255, green: 186.0/255, blue: 2.0/255, alpha: 1.0)
            label1.backgroundColor = UIColor.clear
            label1.text = "CLOSED"
            label1.font = UIFont(name: "Roboto-Bold", size: 14.0)!
            label1.layer.cornerRadius = 4.0
            label1.layer.masksToBounds = true
            scrollOverall.addSubview(label1)
        }
        scrollOverall.contentSize = CGSize(width: scrollOverall.frame.size.width, height: txtvNotes.frame.maxY+100)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }

}
