//
//  Constants.swift
//  NeverEverWait
//
//  Created by Macmini2 on 10/29/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import Foundation


let BASE_URL: String = "http://69.175.75.134/NeverEverWaitService/"  //Staging

//let BASE_URL: String = "http://69.175.75.134/NeverEverWaitService/"  //Live




class Common: NSObject {
    
    struct GlobalConstants {
        static let API_GetVenueList = BASE_URL + "Api/Venue/GetVenueList"
        static let API_PatronSignUp = BASE_URL + "Api/Patrons/PatronSignUp"

    }
}




//#MARK:- Aleart message

struct AlertMessages {
    static let Internet_Error = "No internet connection. Please check your internet settings and try again."
    static let SomethingWentWrong = "Oops something went wrong...Please try again"
    static let NoData = "No content to show."
    
  
    /*
    static let GoToNearStoreWarning = "Indoor Map and Positioning feature are available only inside an aswaaq store..!!"
    static let LoginWarning = "Please Login to enjoy all features"
    static let CommentSuccess = "Thank you for your valuable Suggestion!"
    static let ItemAddedToWorkSheetSuccessMessage = "Item added to Shopping List"
    static let ItemAddedToCartSuccessMessage = "Item added to Cart"
    static let SavedSuccessfullyMessage = "Saved details!"
    static let SavingFailedMessage = "Failed to save data! please try later."
    static let RegistrationSuccessMessage = "Registration Success! Please Login."
    static let AddingFreeText = "Adding short name item..."
    static let DeletingFreeText = "Deleting short name item.."
    static let AddingWorkSheetItem = "Adding item to shopping list"
    static let DeletingWorkSheetItem = "Deleting item from Shopping List.."
    static let AddingItemToCart = "Adding item to cart.."
    static let DeletingItemFromCart = "Deleting cart item.."
    static let ProceedingToPOS = "Proceeding To POS.."
    static let SubmittingFeedBack = "Submitting your comment.."
    static let SavingScannedDetails = "Saving scanned details.."
    static let SiginingUpUser = "Registering user.."
    static let SingInToAddItemsToShoppingList = "Please Sign in to add items to Shopping List"
    static let AllItemsAddedToWorkSheet = "All Recipe Items added to Shopping List"
    static let AccessKioskSavingSuccess = "You have Logged in Successfully!"
    static let ProceedToCheckOut = "Please Proceed to Checkout"
    static let AllFieldsAreMandatoryMessage = "All fields are mandatory"
    static let EnterValidEmail = "Please enter valid email!"
    static let ItemAlreadyAddedToShortNames = "This item is already added to short names!"
    static let ShoppingCartValidate = "Shopping Cart Validated Successfully."
    static let CheckOutInsideAswaaq = "You can proceed to checkout only inside an aswaaq store ..!!" */
    
    
    
}




/*
 
 {
 
 
 guard txtMainPint.text?.count == 4 && Int(txtMainPint.text!) != nil  else {
 
 cleartext()
 ShowAleart(msg: "Please enter a valid pin.")
 
 return
 }
 
 
 
 
 let token = UserDefaults.standard.value(forKey: "auth") as! String
 
 var dict = [String : Any]()
 dict["WafaId"] =  Utility().readDataFromUserdefaults(keyToRead: "WafaID") as? String
 dict["PIN"] =  Int(txtMainPint.text!)
 dict["Points"] =  String(format: "%.1f",TotalAmount )
 
 let urlString = Constants.GlobalConstants.CreatePointJr
 
 
 
 
 //WARNING
 //print("URL:" + urlString)
 // //print("Dict:" + mainDict.description)
 //print("Token:" + token)
 let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
 let jsonString = String(data: jsonData!, encoding: .utf8)!
 //print(jsonString)
 
 self.startLoaderWithText(loadingText: "Please wait...")
 
 Alamofire.request(urlString, method: .post, parameters: ["redeempoints":dict], encoding: JSONEncoding.default, headers: ["Authorization":"Bearer \(token)", "Content-Type":"application/json","Accept":"application/json"])
 
 .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
 //print("Progress: \(progress.fractionCompleted)")
 }
 
 
 .validate { request, response, data in
 // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
 return .success
 }
 .responseJSON { response in
 
 self.cleartext()
 debugPrint(response)
 self.stopLoader()
 guard response.result.isSuccess else {
 //print("Error while fetching")
 self.ShowAleart(msg: AlertMessages.Internet_Error)
 return
 }
 
 var dict = response.result.value as? [String: Any]
 
 guard let code = dict!["ResponseStatus"] else {
 
 self.ShowAleart(msg: AlertMessages.SomethingWentWrong)
 return
 }
 
 
 
 let text = dict!["Status"] as? String
 if text == "Success"{
 
 let check:CheckoutOptionController = self.ctrlID as! CheckoutOptionController
 
 check.placeOrder(payType: "loyalty")
 
 
 }else{
 self.ShowAleart(msg: code as! String)
 }
 
 
 
 
 
 }
 
 }
 
 */
