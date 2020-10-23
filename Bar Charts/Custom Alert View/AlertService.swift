//
//  AlertService.swift
//  To Do List
//
//  Created by MAK on 5/11/20.
//  Copyright © 2020 MAK. All rights reserved.
//

import UIKit

protocol SendData {
    func sendData(day: String, moneySpent: Double, note: String)
}
class AlertService: UIViewController {
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var monySpendTextFiled: UITextField!
    @IBOutlet weak var suBurron: UIButton!
    var day: String!
    var moneySpent: Double!
    var delegate: SendData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        day = "Su"
    }
    override func viewWillAppear(_ animated: Bool) {
        circleView.layer.borderWidth = 5
        circleView.layer.borderColor = #colorLiteral(red: 0.5722488446, green: 0.7750451746, blue: 1, alpha: 1)
        circleView.layer.cornerRadius = 20
        done.layer.cornerRadius = 20
        done.backgroundColor = #colorLiteral(red: 0.5722488446, green: 0.7750451746, blue: 1, alpha: 1)
        myView.layer.cornerRadius = 15

    }
    override func viewDidAppear(_ animated: Bool) {
        circleView.center.x = suBurron.center.x
        circleView.center.y = suBurron.center.y
    }
 
    @IBAction func donePress(_ sender: Any) {
        moneySpent = Double(monySpendTextFiled.text!) ?? 0.0
        delegate?.sendData(day: day, moneySpent: moneySpent, note: noteTextField.text! )
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tapACtion(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.circleView.center.x = sender.center.x
            self.circleView.center.y = sender.center.y
        }
        day = sender.titleLabel?.text
        
    }
    
    
    
    
}
