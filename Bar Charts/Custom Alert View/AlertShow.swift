//
//  AlertSerice.swift
//  To Do List
//
//  Created by MAK on 5/11/20.
//  Copyright © 2020 MAK. All rights reserved.
//

import UIKit


class AlertShow{
    
    
    func alert() -> AlertService {
        
        let storyboard = UIStoryboard(name: "AlertDesign", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertService") as! AlertService

        return alertVC
        
    }
    
}
