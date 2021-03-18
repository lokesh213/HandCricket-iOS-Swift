//
//  HandCricketManager.swift
//  HandCricket
//
//  Created by Lokesh on 17/03/21.
//

import Foundation

struct HandCricketManager {
    
    var handCricketModel = HandCricketModel(userThrowsArr: [], computerThrowsArr: [], target: 0)
    
    func getComputerRandomThrows() -> Int? {
        let numbers = [0, 1, 2, 3, 4, 6]
        if let random = numbers.randomElement() {
            return random
        }
        return nil
    }
    
    mutating func saveUserThrows(_ number: Int) {
        handCricketModel.userThrowsArr.append(number)
        
    }
    
    mutating func saveComputerThrows(_ number: Int) {
        handCricketModel.computerThrowsArr.append(number)
    }
    
    mutating func saveUserTarget() {
        let userScore = getUserScore()
        if userScore == 0 {
            handCricketModel.target = 1
        } else {
            handCricketModel.target = userScore
        }
    }
    
    func getUserThrowsInCommaSeparated() -> String {
        if handCricketModel.userThrowsArr.count > 0 {
            if handCricketModel.userThrowsArr.count == 1 {
                return "\(handCricketModel.userThrowsArr.first!)"
            } else {
                let commaSeparated = (handCricketModel.userThrowsArr.map{String($0)}).joined(separator: ",")
                return commaSeparated
            }
        }
        return "-"
    }
    
    func getComputerThrowsInCommaSeparated() -> String {
        if handCricketModel.computerThrowsArr.count > 0 {
            if handCricketModel.computerThrowsArr.count == 1 {
                return "\(handCricketModel.computerThrowsArr.first!)"
            } else {
                let commaSeparated = (handCricketModel.computerThrowsArr.map{String($0)}).joined(separator: ",")
                return commaSeparated
            }
        }
        return "-"
    }
    
    func getUserScore() -> Int {
        var userScore = 0
        for item in handCricketModel.userThrowsArr {
            userScore = userScore + item
        }
        return userScore
    }
    
    func getComputerScore() -> Int{
        var computerScore = 0
        for item in handCricketModel.computerThrowsArr {
            computerScore = computerScore + item
        }
        return computerScore
    }
    
    func getTarget() -> Int {
        return handCricketModel.target
    }
    
    mutating func checkUserOrComputerIsOut(_ userThrow: Int, _ computerThrow: Int) -> Bool {
        if userThrow == computerThrow {
            return true
        } else {
            //Save User Throw and Computer Throw. When there are not equal to each other
            self.saveUserThrows(userThrow)
            self.saveComputerThrows(computerThrow)
            return false
        }
    }
    
    func checkComputerWonTheMatch() -> Bool {
        let target = self.getTarget()
        let currentComputerScore = self.getComputerScore()
        if currentComputerScore > target {
            return true
        } else {
            return false
        }
    }
    
    func checkHandCricketResult() -> String? {
        let target = getTarget()
        let computerScore = getComputerScore()
        
        if target > computerScore {
            print("Game Winner is User")
            return localize(key: "USER_WON")
        } else if target < computerScore {
            print("Game Winner is Computer")
            return localize(key: "COMPUTER_WON")  
        } else if target == computerScore {
            print("Game is Tie")
            return localize(key: "MATCH_TIE")
        }
        return nil
    }
    
    mutating func resetUserThrows() {
        handCricketModel.userThrowsArr.removeAll()
    }
    
    mutating func resetComputerThrows() {
        handCricketModel.computerThrowsArr.removeAll()
    }
    
}
