//
//  DetailTableViewController.swift
//  Emoji
//
//  Created by Michael Tseitlin on 6/12/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var emoji = Emoji()
    
    // MARK: - @IBOutlets
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBOutlet var symbolTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descritionTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var usageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        symbolTextField.text = emoji.symbol
        nameTextField.text = emoji.name
        descritionTextField.text = emoji.description
        typeTextField.text = emoji.type
        usageTextField.text = emoji.usage
        
        updateUI()
    }
    
    // MARK: - @IBActions
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateUI()
    }
    
    // MARK: - Methods
    
    private func updateUI() {
        
        saveButton.isEnabled = symbolTextField.text!.containsEmoji
            && !symbolTextField.text!.isEmpty
            && !nameTextField.text!.isEmpty
            && !descritionTextField.text!.isEmpty
            && !typeTextField.text!.isEmpty
            && !usageTextField.text!.isEmpty
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "saveEmoji" else { return }
        
        emoji.symbol = symbolTextField.text ?? ""
        emoji.name = nameTextField.text ?? ""
        emoji.description = descritionTextField.text ?? ""
        emoji.type = typeTextField.text ?? ""
        emoji.usage = usageTextField.text ?? ""
        
    }
    
}

// MARK: - Table View Delegate

extension DetailTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 88
        } else {
            return UITableView.automaticDimension
        }
    }
}

// MARK: - Text Field Delegate

extension DetailTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        switch textField {
        case symbolTextField:
            nameTextField.becomeFirstResponder()
        case nameTextField:
            descritionTextField.becomeFirstResponder()
        case descritionTextField:
            typeTextField.becomeFirstResponder()
        case typeTextField:
            usageTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        if textField == symbolTextField {
            if !symbolTextField.text!.containsEmoji {
                showAlert()
            }
        }
    }
}

// MARK: - Create Alert

extension DetailTableViewController {
    
    private func showAlert() {
        
        let alert = UIAlertController(title: "Wrong format", message: "Please add EMOJI", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
