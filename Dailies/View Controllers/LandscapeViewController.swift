//
//  LandscapeViewController.swift
//  Dailies
//
//  Created by Banana Viking on 6/9/18.
//  Copyright © 2018 Banana Viking. All rights reserved.
//

import UIKit

class LandscapeViewController: UIViewController {
    
    let playerLevel = UserDefaults.standard.integer(forKey: "level")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let enemyImage  = self.view.viewWithTag(9000) as! UIImageView
        
        if playerLevel == 1 {
            enemyImage.image = UIImage(named: "enemy1")
        } else if playerLevel == 2 {
            enemyImage.image = UIImage(named: "enemy2")
        } else if playerLevel == 3 {
            enemyImage.image = UIImage(named: "enemy3")
        } else if playerLevel == 4 {
            enemyImage.image = UIImage(named: "enemy4")
        } else if playerLevel == 5 {
            enemyImage.image = UIImage(named: "enemy5")
        } else if playerLevel == 6 {
            enemyImage.image = UIImage(named: "enemy6")
        } else if playerLevel == 7 {
            enemyImage.image = UIImage(named: "enemy7")
        } else if playerLevel == 8 {
            enemyImage.image = UIImage(named: "enemy8")
        } else if playerLevel == 9 {
            enemyImage.image = UIImage(named: "enemy9")
        } else if playerLevel >= 10 {
            enemyImage.image = UIImage(named: "enemy10")
        }
    }
}
