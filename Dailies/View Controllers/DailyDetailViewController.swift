//
//  DailyDetailViewController.swift
//  Dailies
//
//  Created by Banana Viking on 5/31/18.
//  Copyright © 2018 Banana Viking. All rights reserved.
//

import UIKit

protocol DailyDetailViewControllerDelegate: class {
    func dailyDetailViewControllerDidCancel(_ controller: DailyDetailViewController)
    
    func dailyDetailViewController(_ controller: DailyDetailViewController, didFinishAdding daily: Daily)
    
    func dailyDetailViewController(_ controller: DailyDetailViewController, didFinishEditing daily: Daily)
}

class DailyDetailViewController: UITableViewController, UITextFieldDelegate {

    weak var delegate: DailyDetailViewControllerDelegate?
    
    var dailyToEdit: Daily?
    
    var dueDate = Date()
    
    var datePickerVisible = false
    
    // MARK: - Actions
    @IBAction func cancel() {
        delegate?.dailyDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let dailyToEdit = dailyToEdit {
            dailyToEdit.text = textField.text!
            
            dailyToEdit.shouldRemind = shouldRemindSwitch.isOn
            dailyToEdit.dueDate = dueDate
            
            delegate?.dailyDetailViewController(self, didFinishEditing: dailyToEdit)
        } else {
            let daily = Daily()
            daily.text = textField.text!
            daily.checked = false
            
            dailyToEdit?.shouldRemind = shouldRemindSwitch.isOn
            dailyToEdit?.dueDate = dueDate
            
            delegate?.dailyDetailViewController(self, didFinishAdding: daily)
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var datePickerCell: UITableViewCell!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: - tableView Delegates
    // stops the cell from highlighting when tap just outside the text field
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 && indexPath.row == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    // override to show datePickerCell when tapped even though table view has static cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == 2 {
            return datePickerCell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && datePickerVisible {
            return 3
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    // override to make height of cell bigger to fit datePickerCell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 2 {
            return 217
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        textField.resignFirstResponder()
        
        if indexPath.section == 1 && indexPath.row == 1 {
            showDatePicker()
        }
    }
    
    // delegate method required when overriding data source for static table view cell
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        var newIndexPath = indexPath
        if indexPath.section == 1 && indexPath.row == 2 {
            newIndexPath = IndexPath(row: 0, section: indexPath.section)
        }
        
        return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
    }
    
    // MARK: - Functions
    // activates the text field when page is loaded without having to select it first
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dailyToEdit = dailyToEdit {
            title = "Edit Daily"
            textField.text = dailyToEdit.text
            doneBarButton.isEnabled = true
            shouldRemindSwitch.isOn = dailyToEdit.shouldRemind
            dueDate = dailyToEdit.dueDate
        }
        
        updateDueDateLabel()
    }

    // disables doneBarButton if textField is empty
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneBarButton.isEnabled = !newText.isEmpty
        
        return true
    }
    
    func updateDueDateLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dueDateLabel.text = formatter.string(from: dueDate)
    }
    
    func showDatePicker() {
        datePickerVisible = true
        let indexPathDatePicker = IndexPath(row: 2, section: 1)
        tableView.insertRows(at: [indexPathDatePicker], with: .fade)
    }
}






