//
//  TossViewController.swift
//  HandCricket
//
//  Created by Lokesh on 17/03/21.
//

import UIKit

class TossViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK:- Button Action
    @IBAction func performPlay(_ sender: Any) {
        guard let scoreboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ScoreBoardViewControllerID") as? ScoreBoardViewController else { return }
        self.view.window?.rootViewController = scoreboardVC
    }
}
