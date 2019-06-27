//
//  HistoryViewController.swift
//  Grade Calculator
//
//  Created by Bijoy on 6/26/19.
//  Copyright © 2019 Bijoy Shah. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var historyClassName = ["Portico", "Digital Tech"]
    var historyCurrentGrade = [94, 98.5]
    var historyDesiredGrade = [93, 93.0]
    var historyWeightOfFinal = [20, 30.2]
    var historyDate = ["06/27/2019", "06/28/2019"]
    var historyScoreNeeded = ["23", "23"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.lightGray.cgColor, UIColor.gray.cgColor, UIColor.blue.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.barTintColor = UIColor.lightGray
        self.navigationController!.toolbar.barTintColor = UIColor.blue
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowHistoryCell" {
            let destination = segue.destination as! FinalCalculatorViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.className = historyClassName[selectedIndexPath.row]
            destination.currentGrade = historyCurrentGrade[selectedIndexPath.row]
            destination.desiredGrade = historyDesiredGrade[selectedIndexPath.row]
            destination.weightOfFinal = historyWeightOfFinal[selectedIndexPath.row]
            destination.currentDate = historyDate[selectedIndexPath.row]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromFinalCalculatorViewController(segue: UIStoryboardSegue) {
        let source = segue.source as! FinalCalculatorViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            historyClassName[selectedIndexPath.row] = source.className
            historyCurrentGrade[selectedIndexPath.row] = source.currentGrade
            historyDesiredGrade[selectedIndexPath.row] = source.desiredGrade
            historyWeightOfFinal[selectedIndexPath.row] = source.weightOfFinal
            historyDate[selectedIndexPath.row] = source.currentDate
            historyScoreNeeded[selectedIndexPath.row] = source.scoreNeeded
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: historyClassName.count, section: 0)
            historyClassName.append(source.className)
            historyCurrentGrade.append(source.currentGrade)
            historyDesiredGrade.append(source.desiredGrade)
            historyWeightOfFinal.append(source.weightOfFinal)
            historyDate.append(source.scoreNeeded)
            historyScoreNeeded.append(source.currentDate)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            editBarButton.title = "Edit"
            addBarButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            editBarButton.title = "Done"
            addBarButton.isEnabled = false
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyClassName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        cell.textLabel?.text = historyClassName[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = historyDate[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            historyClassName.remove(at: indexPath.row)
            historyDate.remove(at: indexPath.row)
            historyCurrentGrade.remove(at: indexPath.row)
            historyDesiredGrade.remove(at: indexPath.row)
            historyWeightOfFinal.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let classNameItemToMove = historyClassName[sourceIndexPath.row]
        let dateItemToMove = historyDate[sourceIndexPath.row]
        let currentGradeItemToMove = historyCurrentGrade[sourceIndexPath.row]
        let desiredGradeItemToMove = historyDesiredGrade[sourceIndexPath.row]
        let weightOfFinalItemToMove = historyWeightOfFinal[sourceIndexPath.row]
        historyClassName.remove(at: sourceIndexPath.row)
        historyDate.remove(at: sourceIndexPath.row)
        historyCurrentGrade.remove(at: sourceIndexPath.row)
        historyDesiredGrade.remove(at: sourceIndexPath.row)
        historyWeightOfFinal.remove(at: sourceIndexPath.row)
        historyClassName.insert(classNameItemToMove, at: destinationIndexPath.row)
        historyDate.insert(dateItemToMove, at: destinationIndexPath.row)
        historyCurrentGrade.insert(currentGradeItemToMove, at: destinationIndexPath.row)
        historyDesiredGrade.insert(desiredGradeItemToMove, at: destinationIndexPath.row)
        historyWeightOfFinal.insert(weightOfFinalItemToMove, at: destinationIndexPath.row)
    }
}
