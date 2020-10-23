//
//  ViewController.swift
//  Bar Charts
//
//  Created by MAK on 10/20/20.
//  Copyright © 2020 MAK. All rights reserved.
//

import UIKit
struct SpendData {
    var day: String!
    var money: Double!
    var note: String!
}


class ViewController: UIViewController, SendData, UITableViewDataSource, UITableViewDelegate {
    
    
    var alert = AlertShow()
    var day : String!
    var moneySpent: Double!
    var daysMap = [Int:String]()
    var userBalance: Double!
    var maxHeigt : Double = 161
    
    @IBOutlet weak var balanceLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBackGround: UIView!
    
    
    @IBOutlet weak var backViewSu: UIView!
    @IBOutlet weak var frontViewSu: UIView!
    @IBOutlet weak var hightSu: NSLayoutConstraint!
    
    @IBOutlet weak var backViewMo: UIView!
    @IBOutlet weak var frontViewMo: UIView!
    @IBOutlet weak var heightMo: NSLayoutConstraint!
    
    @IBOutlet weak var backViewTu: UIView!
    @IBOutlet weak var frontViewTu: UIView!
    @IBOutlet weak var heightTu: NSLayoutConstraint!
    
    @IBOutlet weak var backViewWe: UIView!
    @IBOutlet weak var frontViewWe: UIView!
    @IBOutlet weak var heightWe: NSLayoutConstraint!
    
    @IBOutlet weak var backViewTh: UIView!
    @IBOutlet weak var frontViewTh: UIView!
    @IBOutlet weak var heightTh: NSLayoutConstraint!
    
    @IBOutlet weak var backViewFr: UIView!
    @IBOutlet weak var frontViewFr: UIView!
    @IBOutlet weak var heightFr: NSLayoutConstraint!
    
    @IBOutlet weak var backViewSa: UIView!
    @IBOutlet weak var frontViewSa: UIView!
    @IBOutlet weak var heightSa: NSLayoutConstraint!
    
    var viewContenner = [UIView]()
    var heights = [NSLayoutConstraint]()
    @IBOutlet weak var chartBackGround: UIView!
    
    var barColors = [UIColor]()
    var userSpendData = [SpendData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        viewContenner = [backViewSu,frontViewSu,backViewMo,frontViewMo,backViewTu,frontViewTu,backViewWe,frontViewWe,backViewTh,frontViewTh,backViewFr,frontViewFr,backViewSa,frontViewSa]
        
        heights = [hightSu,heightMo,heightTu,heightWe,heightTh,heightFr,heightSa]
        barColors = [#colorLiteral(red: 0.9814946055, green: 0.4105269313, blue: 0.4141915739, alpha: 1),#colorLiteral(red: 0.6307432652, green: 0.639832139, blue: 1, alpha: 1),#colorLiteral(red: 0.9003511628, green: 0.8238256887, blue: 0.3792606705, alpha: 1),#colorLiteral(red: 0.6523426175, green: 0.8508819938, blue: 0.3274415433, alpha: 1),#colorLiteral(red: 0.6735033145, green: 0.7462824294, blue: 1, alpha: 1),#colorLiteral(red: 0.9922303557, green: 0.8149613738, blue: 0.6596651077, alpha: 1),#colorLiteral(red: 0.578780084, green: 0.7537469113, blue: 0.8071776395, alpha: 1)]
        daysMap[1] = "Su"
        daysMap[2] = "Mo"
        daysMap[3] = "Tu"
        daysMap[4] = "We"
        daysMap[5] = "Th"
        daysMap[6] = "Fr"
        daysMap[7] = "Sa"
        userBalance = 5000
    }
    override func viewWillAppear(_ animated: Bool) {
        roundedCornersAndColorBars(viewContenner)
    }
    func roundedCornersAndColorBars(_ Views : [UIView]){
        var totalViewIndex = 1
        var colorsIndex = 0
        for view in Views{
            view.layer.cornerRadius = 10
            if totalViewIndex % 2 == 0{
                view.backgroundColor = barColors[colorsIndex]
                colorsIndex += 1
            }
            totalViewIndex += 1
        }
        chartBackGround.layer.cornerRadius = 10
        chartBackGround.layer.shadowColor = UIColor.black.cgColor
        chartBackGround.layer.shadowOpacity = 0.3
        chartBackGround.layer.shadowOffset = .zero
        chartBackGround.layer.shadowRadius = 5
        
        
        tableViewBackGround.layer.cornerRadius = 10
        tableViewBackGround.layer.shadowColor = UIColor.black.cgColor
        tableViewBackGround.layer.shadowOpacity = 0.2
        tableViewBackGround.layer.shadowOffset = .zero
        tableViewBackGround.layer.shadowRadius = 2
        
    }
    
    @IBAction func Done(_ sender: Any) {
        let vc = alert.alert()
        vc.delegate = self
        present(vc, animated: true)
    }
    
}
extension ViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSpendData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath)
            as! TableViewCell
        cell.Day.text = "Day: \(userSpendData[indexPath.row].day!)"
        cell.spentMony.text = "Spent Money: \(userSpendData[indexPath.row].money!)"
        cell.note.text = "Note: \(userSpendData[indexPath.row].note!)" 
        return cell
    }
    
    func sendData(day: String, moneySpent: Double , note: String) {
        self.day = day
        self.moneySpent = moneySpent
        upDate(day: day, moneySpent: moneySpent,note:note)
    }
    func upDate(day: String, moneySpent: Double, note: String){
        var index = 1
        for hight in heights{
            if daysMap[index] == day{
                hight.constant += CGFloat(changeHeight(moneySpent: moneySpent, oldHeight: Double((hight.constant)), note: note))
                UIView.animate(withDuration: 1.5, delay: 0.3, options: [], animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
                
                break
            }
            index += 1
        }
    }
    func changeHeight(moneySpent: Double,oldHeight : Double , note: String) -> Double {
        if userBalance > 0{
            userSpendData.append(SpendData(day: day,money: moneySpent,note:note))
            
            self.tableView.reloadData()
            let newHeight = ((maxHeigt) * (moneySpent/userBalance))
            self.userBalance -= moneySpent
            cubeTransition(label: balanceLable, text: "\(self.userBalance!)")
            if maxHeigt > (oldHeight + newHeight){
                return newHeight
            }
            else if maxHeigt < (oldHeight + newHeight){
                return 0
            }
            
            return maxHeigt
        }
        return 0
    }
    
    func cubeTransition(label: UILabel, text: String) {
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textColor = label.textColor
        auxLabel.textAlignment = label.textAlignment
        auxLabel.backgroundColor =  .white
        
        let auxLabelOffset = CGFloat(-1) * label.frame.height / 2.0 // up || down
        auxLabel.transform = CGAffineTransform(translationX: 0.0, y: auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
        label.superview?.addSubview(auxLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            auxLabel.transform = .identity
            label.transform = CGAffineTransform(translationX: 0.0, y: -auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
        }, completion: { _ in
            label.text = auxLabel.text
            label.transform = .identity
            auxLabel.removeFromSuperview()
        })
    }
    
    
    
    
}

