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

enum HandCricketResult: String {
    case userWon = "User Won the Hand Cricket"
    case computerWon = "Computer won the Hand Cricket"
    case matchTie = "Hand Cricket between User vs Computer is Tie"
}

let USER_THROWING = "User Throws (Round 1)";
let COMPUTER_THROWING = "Computer Throws (Round 2)";
