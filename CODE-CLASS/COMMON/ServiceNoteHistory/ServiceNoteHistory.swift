//
//  ServiceNoteHistory.swift
//  AlMutlaqRealEstate
//
//  Created by Sabnam Nasrin on 24/09/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class ServiceNoteHistory: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet var lblServiceHistory: UILabel!
   
    @IBOutlet var pressCross: UIButton!
        let cellReuseIdentifier = "cell"
    @IBOutlet var tableServiceNote: UITableView!
    
    var arrMNotelist = NSMutableArray()
    
    var arrMNote = NSMutableArray()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       //  self.tableServiceNote.layoutSubviews()
         tableServiceNote.reloadData()
     /*   let dictemp = UserDefaults.standard.value(forKey: "dicLogin") as!NSDictionary
        let strauthkey = String(format: "Bearer%@", dictemp.value(forKey: "token") as! CVarArg)
        self.fetchList(strauthkey: strauthkey, strstatus: strvalue as String)*/
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
   
//        let dictemp: NSDictionary = self.arrMNote[0] as! NSDictionary
//        let arrmP :NSArray =  dictemp.value(forKey: "booking_update_note") as! NSArray
//        let arrBooking_update_note:NSMutableArray = NSMutableArray(array: arrmP)
//         arrMNotelist = arrBooking_update_note
 
        arrMNotelist = arrMNote
        
        tableServiceNote.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        tableServiceNote.backgroundView=nil
        tableServiceNote.backgroundColor=UIColor.clear
     tableServiceNote.separatorColor=UIColor.clear
        tableServiceNote.delegate = self
        tableServiceNote.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        tableServiceNote.estimatedRowHeight = UITableViewAutomaticDimension
        tableServiceNote.rowHeight = UITableViewAutomaticDimension
        tableServiceNote.allowsSelection = false
     
        self.tableServiceNote.register(UINib(nibName: "NoteCell", bundle: Bundle.main), forCellReuseIdentifier: "NoteCell")
      //  self.tableServiceNote.setNeedsLayout()
      //  self.tableServiceNote.layoutIfNeeded()
         //  tableServiceNote.reloadData()
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrMNotelist.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
      
          let dictemp: NSDictionary = arrMNotelist[indexPath.row] as! NSDictionary
      
        print("arrMNotelist -- %@",arrMNotelist)
        //  let strservicename = String(format:"%@",(dictemp.value(forKey: "service_name") as? String)!)
        
        cell.lbl1.text = String(format:"%@",(dictemp.value(forKey: "booking_update_date") as? CVarArg)!)
        cell.lbl2.text = String(format:"%@",(dictemp.value(forKey: "labour_name") as? String)!)
        cell.lbl3.text = String(format: "%@%@",(dictemp.value(forKey: "job_completion"))! as! CVarArg, "%")
        cell.lbl4.text = String(format:"%@",(dictemp.value(forKey: "note") as? String)!)
        cell.lbl4.sizeToFit()
        cell.lbl4.layoutIfNeeded()
        cell.lbl4.numberOfLines = 0
    
      //  cell.setNeedsLayout()
       // cell.layoutIfNeeded()
      
    
           //self.tableServiceNote.setNeedsLayout()
         //  self.tableServiceNote.layoutIfNeeded()
        
     
       
         
        
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    /*
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
      return UITableViewAutomaticDimension;
        
    }
   
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMNotelist.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

       return UITableViewAutomaticDimension
    }
  /*  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
      cell.lbl4.numberOfLines = 0
        let dictemp: NSDictionary = self.arrMNote[0] as! NSDictionary
        
      //  let strservicename = String(format:"%@",(dictemp.value(forKey: "service_name") as? String)!)
        
        cell.lbl1.text = String(format:"%@",(dictemp.value(forKey: "booking_requested_date") as? String)!)
        cell.lbl2.text = String(format:"%@",(dictemp.value(forKey: "labour_name") as? String)!)
        cell.lbl3.text = String(format: "%@%@",(dictemp.value(forKey: "booking_completion_percentage"))! as! CVarArg, "%")
          
        cell.lbl4.text = arrMNotelist[indexPath.row] as? String
     
         //cell.lbl4.fitTextToBounds()
         cell.setNeedsLayout()
        cell.layoutIfNeeded()
       // cell.lbl4.setNeedsLayout()
       // cell.lbl4.layoutIfNeeded()
       
       // cell.lbl4.lineBreakMode = .byWordWrapping
     /*   cell.lbl1.text = arrMNotelist[indexPath.row] as? String
        cell.lbl2.text = arrMNotelist[indexPath.row] as? String
        cell.lbl3.text = arrMNotelist[indexPath.row] as? String
        cell.lbl4.text = arrMNotelist[indexPath.row] as? String*/
        
   
        
       
        return cell
      
        /*let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier:cellReuseIdentifier)
        
        cell.selectionStyle=UITableViewCellSelectionStyle.none
        cell.accessoryType = UITableViewCellAccessoryType.none
        cell.backgroundColor=UIColor.white
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        
        
        cell.textLabel?.text = arrMNotelist[indexPath.row] as? String
          cell.textLabel?.numberOfLines = 0
           cell.textLabel?.font = UIFont(name: "Roboto-Regular", size: 14.0)!
      //  let dictemp: NSDictionary = arrMNotelist[indexPath.row] as! NSDictionary
        
     /*
        let label = UILabel(frame: CGRect(x: 15, y: 5, width: tableView.frame.size.width-20, height: 40))
        label.textAlignment = .left
      
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.text = arrMNotelist[indexPath.row] as? String
        label.font = UIFont(name: "Roboto-Regular", size: 17.0)!
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        cell.contentView.addSubview(label)
        
*/
  
        let labelSeparator = UILabel(frame: CGRect(x: 15, y: (cell.textLabel?.frame.maxY)!, width: tableView.frame.size.width-30, height: 0.5))
        labelSeparator.backgroundColor = UIColor(red: 220.0/255, green: 220.0/255, blue: 220.0/255, alpha: 1.0)
        cell.contentView.addSubview(labelSeparator)
        
        return cell;*/
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    /*    let dictemp: NSDictionary = arrMNotelist[indexPath.row] as! NSDictionary
        
        let strbookingID:Int = dictemp.value(forKey: "service_boooking_id") as! Int
        let stringValue = "\(strbookingID)"
        
        let obj = CSTaskdetails()
        obj.strIdentifier = stringValue as NSString
        self.navigationController?.pushViewController(obj, animated: true)*/
    }*/
     // MARK: - Button Cross press Method
    @IBAction func pressCross(_ sender: Any) {
      //  let obj = ServiceNoteHistory()
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
 
    

}



