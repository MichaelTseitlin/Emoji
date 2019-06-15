//
//  MainTableViewController.swift
//  Emoji
//
//  Created by Michael Tseitlin on 6/12/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var emojis: [[Emoji]]! {
        didSet {
            storageManager.saveData(emojis: emojis)
        }
    }
    
    private let storageManager = StorageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojis = storageManager.loadData() ?? storageManager.loadEmojis()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: - Table View Delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return emojis.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Разное"
        case 1:
            return "Фрукты"
        case 2:
            return "Животные"
        case 3:
            return "Техника"
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        
        let emoji = emojis[indexPath.section][indexPath.row]
        
        cell.configure(emoji: emoji)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            emojis[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let removeEmoji = emojis[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        emojis[destinationIndexPath.section].insert(removeEmoji, at: destinationIndexPath.row)
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "editEmojiSegue" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let emoji = emojis[indexPath.section][indexPath.row]
        
        let destination = segue.destination as! DetailTableViewController
        destination.navigationItem.title = "Edit"
        destination.emoji = emoji
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
        guard segue.identifier == "saveEmoji" else { return }
        
        let source = segue.source as! DetailTableViewController
        let emoji = source.emoji
        
        if let index = tableView.indexPathForSelectedRow {
            // Edit emoji
            emojis[index.section][index.row] = emoji
            tableView.reloadRows(at: [index], with: .automatic)
        }
        else {
            // Add emoji
            let indexPath = IndexPath(row: emojis.count, section: 0)
            emojis[indexPath.section].append(emoji)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
}
