//
//  ResultViewController.swift
//  HandCricket
//
//  Created by Lokesh on 17/03/21.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLbl: UILabel!
    var result: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLbl.text = result ?? "Something went wrong. Please try again later!"
        resultLbl.adjustsFontSizeToFitWidth = true

    }
    
    @IBAction func performPlayAgain(_ sender: Any) {
        guard let tossVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TossViewControllerID") as? TossViewController else { return }
        self.view.window?.rootViewController = tossVC
    }
    
}
