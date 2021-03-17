//
//  ScoreBoardViewController.swift
//  HandCricket
//
//  Created by Lokesh on 17/03/21.
//

import UIKit

class ScoreBoardViewController: UIViewController {
    
    @IBOutlet weak var bastmenName: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var userThrowsLbl: UILabel!
    @IBOutlet weak var computerThrowsLabel: UILabel!
    @IBOutlet weak var targetView: UIView!
    
    var throwsCount = 0
    var handCricketManager = HandCricketManager()
    
    var isRoundOne: Bool = true
    var isRoundTwo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupScoreBoardUI()
        print("Round 1: User Batting")
    }
    
    private func setupInterface() {
        self.title = "Score Board"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupScoreBoardUI() {
        bastmenName.text = isRoundOne ? USER_THROWING : COMPUTER_THROWING
        bastmenName.adjustsFontSizeToFitWidth = true
        
        let userScore = "Score: \(handCricketManager.getUserScore())"
        let computerScore = "Score: \(handCricketManager.getComputerScore())"
        scoreLbl.text = isRoundOne ? userScore : computerScore
        
        targetView.isHidden = isRoundOne
        
        userThrowsLbl.text = handCricketManager.getUserThrowsInCommaSeparated()
        computerThrowsLabel.text = handCricketManager.getComputerThrowsInCommaSeparated()
    }
    
    //MARK:- Button Actions
    @IBAction func performThrows(_ sender: UIButton) {
        throwsCount += 1
        guard throwsCount <= 6 else { return }
        
        let userThrow = sender.tag
        var compThrow = Int()
        
        if let computerThrow = handCricketManager.getComputerRandomThrows() {
            compThrow = computerThrow
            if userThrow == computerThrow {
                //User Throw and Computer Throw are equal to each other
                if isRoundOne {
                    roundOneCompleted(status: .out)
                } else if isRoundTwo {
                    roundTwoCompleted(status: .out)
                }
                return
            } else {
                //Save User Throw and Computer Throw. When there are not equal to each other
                saveUserAndComputerThrows(userThrow, compThrow)
            }
        }
        
        if isRoundTwo {
            //This is condition to check whether Computer Throw is greater than User Throw
            let target = handCricketManager.getTarget()
            let currentComputerScore = handCricketManager.getComputerScore()
            if currentComputerScore > target {
                roundTwoCompleted(status: .won)
            }
        }
        setupScoreBoardUI()
        
        if throwsCount == 6 {
            //Stop Rounds after 6 throws
            roundsAreCompleted()
        }
        
    }
    
    private func saveUserAndComputerThrows(_ userThrow: Int, _ computerThrow: Int) {
        printLogs(userThrow, computerThrow)
        handCricketManager.saveUserThrows(userThrow)
        handCricketManager.saveComputerThrows(computerThrow)
    }
    
    private func roundsAreCompleted() {
        if isRoundOne {
            roundOneCompleted(status: .throwsCompleted);
        } else if isRoundTwo {
            roundTwoCompleted(status: .throwsCompleted);
        }
    }
    
    private func roundOneCompleted(status: UserThrowsResult) {
        //Reset User flag
        isRoundOne = false
        
        if status == .throwsCompleted {
            print("User throw is completed")
            UIUtility.showAlertWithTitle(title: "User", message: "Completed Batting", buttonTitles: ["OK"], viewController: self) { (_) in }
        } else if status == .out {
            print("User is out")
            UIUtility.showAlertWithTitle(title: "User", message: "OUT", buttonTitles: ["OK"], viewController: self) { (_) in }
        }
        
        handCricketManager.saveUserTarget()
        
        //User sets target
        targetLbl.text = "Target: \(handCricketManager.getTarget())"
        
        //Reset User and Computer Throws after round 1
        handCricketManager.resetUserThrows()
        handCricketManager.resetComputerThrows()
        
        //Reset throwsCount
        throwsCount = 0
        
        setupScoreBoardUI()
        
        //Round 2 started
        isRoundTwo = true
        print("Round 2: Computer Batting")
        
    }
    
    private func roundTwoCompleted(status: ComputerThrowsResult) {
        switch status {
        case .throwsCompleted:
            print("Computer throw is completed")
            UIUtility.showAlertWithTitle(title: "Computer", message: "Completed Batting", buttonTitles: ["OK"], viewController: self) { (title) in
                if title == 0 {
                    self.redirectResultViewCntl()
                }
            }
        case .out:
            print("Computer is out")
            UIUtility.showAlertWithTitle(title: "Computer", message: "OUT", buttonTitles: ["OK"], viewController: self) { (title) in
                if title == 0 {
                    self.redirectResultViewCntl()
                }
                
            }
        case .won:
            print("Computer won")
            UIUtility.showAlertWithTitle(title: "Computer", message: "Won the Hand cricket", buttonTitles: ["OK"], viewController: self) { (title) in
                if title == 0 {
                    self.redirectResultViewCntl()
                }
            }
        }
    }
    
    private func redirectResultViewCntl() {
        if let checkForResult = handCricketManager.checkHandCricketResult() {
            guard let resultVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ResultViewControllerID") as? ResultViewController else { return }
            resultVC.result = checkForResult
            self.view.window?.rootViewController = resultVC
        }
    }
    
    private func printLogs(_ userThrow: Int, _ computerThrow: Int) {
        if isRoundOne {
            print("User throws \(userThrow), Computer throws \(computerThrow), User score is \(handCricketManager.getUserScore() == 0 ? userThrow : handCricketManager.getUserScore())")
        }
        if isRoundTwo {
            print("User throws \(userThrow), Computer throws \(computerThrow), Computer score is \(handCricketManager.getComputerScore() == 0 ? computerThrow : handCricketManager.getComputerScore())")
        }
    }
    
    
}
