//
//  DeactivatedNote.swift
//  AlMutlaqRealEstate
//
//  Created by Sabnam Nasrin on 26/09/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class DeactivatedNote: UIViewController
{
    var strMessage = NSString()
    
    @IBOutlet var viewUpper: UIView!
    @IBOutlet var imgvThumbsup: UIImageView!
    @IBOutlet var lblDeactivated: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var btnHome: UIButton!
    
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
        
        lblMessage.text = NSString(format:"%@", strMessage) as String
        viewUpper.layer.shadowColor = UIColor.lightGray.cgColor
        viewUpper.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewUpper.layer.shadowRadius = 0.0
        viewUpper.layer.shadowOpacity = 2.0
        viewUpper.layer.masksToBounds = false
        
        btnHome.layer.cornerRadius = 4.0
        btnHome.layer.masksToBounds = true
    }

    // MARK: - pressHome Method
    @IBAction func pressHome(_ sender: Any)
    {
        self.navigationController?.popToRootViewController(animated: false)
    }

}
