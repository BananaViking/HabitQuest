//
//  PlayerStats.swift
//  Dailies
//
//  Created by Banana Viking on 6/9/18.
//  Copyright © 2018 Banana Viking. All rights reserved.
//

import UIKit

class PlayerInfoViewController: UITableViewController {
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var daysTilLabel: UILabel!
    @IBOutlet weak var daysMissedLabel: UILabel!
    @IBOutlet weak var questLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        tableView.allowsSelection = false 
    }
    
    func updateLabels() {
        levelLabel.text = "\(UserDefaults.standard.object(forKey: "level") ?? "1")"
        rankLabel.text = "\(UserDefaults.standard.object(forKey: "rank") ?? "Novice")"
        daysTilLabel.text = "\(UserDefaults.standard.object(forKey: "daysTil") ?? "3")" // change to 7 on launch
        daysMissedLabel.text = "\(UserDefaults.standard.object(forKey: "daysMissed") ?? "0")"
        questLabel.text = UserDefaults.standard.object(forKey: "quest") as? String ?? "Skeleton Quest"
    }
}
