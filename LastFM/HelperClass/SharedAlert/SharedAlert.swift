//
//  SharedAlert.swift
//  LastFM

import Foundation

import UIKit

class SharedAlert {
    
    static let alert : SharedAlert = {
        let objInstance = SharedAlert()
        return objInstance
    }()
    
    func showAlertMessage(_ controllerObj:UIViewController,Message:String) {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: Constant.APP_NAME, message: Message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: MessageConstant.commonButtonTitle.ok, style: UIAlertAction.Style.default, handler: nil))
            controllerObj.present(alert, animated: true, completion: nil)
        })
    }
    
    func displayAlertMessageWithBlock(viewController: UIViewController!,strMessage:String!,buttonTitle:String!,handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertController = UIAlertController(title: Constant.APP_NAME , message:strMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            handler!(result)
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func displayAlertMessageWithTwoButtonBlock(viewController: UIViewController!,strMessage:String!,buttonTitle1:String!,buttonTitle2:String!,handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertController = UIAlertController(title: Constant.APP_NAME , message:strMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: buttonTitle1, style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            handler!(result)
        }
        let okAction2 = UIAlertAction(title: buttonTitle2, style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            handler!(result)
        }
        alertController.addAction(okAction)
        alertController.addAction(okAction2)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func displayAlertMessage(viewController: UIViewController!,strMessage:String!,buttonTitle:String!) {
        let alertController = UIAlertController(title: Constant.APP_NAME , message:strMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
