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
    
    var historyClassName = ["Portico", "Digital Tech"]
    var historyCurrentGrade = [94, 98.5]
    var historyDesiredGrade = [93, 93.0]
    var historyWeightOfFinal = [20, 30.2]
    
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
    
    @IBAction func unwindFromFinalCalculatorViewController(segue: UIStoryboardSegue) {
        let source = segue.source as! FinalCalculatorViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            historyClassName[selectedIndexPath.row] = source.className
            historyCurrentGrade[selectedIndexPath.row] = source.currentGrade
            historyDesiredGrade[selectedIndexPath.row] = source.desiredGrade
            historyWeightOfFinal[selectedIndexPath.row] = source.weightOfFinal
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: historyClassName.count, section: 0)
            historyClassName.append(source.className)
            historyCurrentGrade.append(source.currentGrade)
            historyDesiredGrade.append(source.desiredGrade)
            historyWeightOfFinal.append(source.weightOfFinal)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
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
        cell.detailTextLabel?.text = "06/27/2019"
        return cell
    }
    
    
}
