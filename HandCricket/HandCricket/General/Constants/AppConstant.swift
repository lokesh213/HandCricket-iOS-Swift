//
//  AppConstant.swift
//  HandCricket
//
//  Created by Lokesh on 17/03/21.
//

import Foundation


enum UserThrowsResult {
    case throwsCompleted
    case out
}

enum ComputerThrowsResult {
    case throwsCompleted
    case out
    case won
}

func localize (key:String) ->String
{
    return NSLocalizedString(key, comment: "")
}
