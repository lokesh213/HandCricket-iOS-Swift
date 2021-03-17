//
//  UIUtility.swift
//  HandCricket
//
//  Created by Lokesh on 17/03/21.
//

import Foundation
import UIKit


class UIUtility {
    
    class func showAlertWithTitle(title:String , message:String , buttonTitles:[String], viewController:UIViewController, actionHandler:((_ buttonIndex:Int)->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        for strTitle:String in buttonTitles{
            alert.addAction(UIAlertAction(title:strTitle, style: UIAlertAction.Style.default, handler: { (alert: UIAlertAction!)in
                let index = buttonTitles.firstIndex( where: { (str: String) -> Bool in
                    return str == alert.title
                })
                actionHandler?(index!)
            }))
        }
        viewController.present(alert, animated: true, completion: nil)
    }

}
