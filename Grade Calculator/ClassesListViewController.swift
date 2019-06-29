//
//  ClassesListViewController.swift
//  Grade Calculator
//
//  Created by Bijoy on 6/24/19.
//  Copyright © 2019 Bijoy Shah. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import FirebaseUI
import GoogleSignIn


class ClassesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gpaLabel: UILabel!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    
    var classes = [String]()
    var grades = [String]()
    var credits = [String]()
    var authUI: FUIAuth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        updateGPA()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.lightGray.cgColor, UIColor.gray.cgColor, UIColor.blue.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.barTintColor = UIColor.lightGray
        self.navigationController!.toolbar.barTintColor = UIColor.blue
        if grades.isEmpty {
            gpaLabel.text = "0.000"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if grades.isEmpty {
            gpaLabel.text = "0.000"
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        updateGPA()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowClass" {
            let destination = segue.destination as! IndividualClassViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.oneClass = classes[selectedIndexPath.row]
            destination.grade = grades[selectedIndexPath.row]
            destination.credit = credits[selectedIndexPath.row]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: true)
            }
        }
        //      updateGPA()
    }
    
    func updateGPA() {
        let currentGPA = calculateOverallGPA(grades: grades)
        gpaLabel.text = String(format:"%.3f", currentGPA)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func calculateOverallGPA(grades: [String]) -> Double {
        var addingValueToGPA = 0.000
        var totalGPAPoints = 0.000
        var currentGPA = 0.000
        for i in 0..<grades.count {
            if grades[i] == "A" {
                addingValueToGPA = 4.000
            } else if grades[i] == "A-" {
                addingValueToGPA = 3.667
            } else if grades[i] == "B+" {
                addingValueToGPA = 3.333
            } else if grades[i] == "B" {
                addingValueToGPA = 3.000
            } else if grades[i] == "B-" {
                addingValueToGPA = 2.667
            } else if grades[i] == "C+" {
                addingValueToGPA = 2.333
            } else if grades[i] == "C" {
                addingValueToGPA = 2.000
            } else if grades[i] == "C-" {
                addingValueToGPA = 1.667
            } else if grades[i] == "D+" {
                addingValueToGPA = 1.333
            } else if grades[i] == "D" {
                addingValueToGPA = 1.000
            } else if grades[i] == "D-" {
                addingValueToGPA = 0.667
            }
            if let totalPoints = Double(credits[i]) {
                totalGPAPoints += totalPoints
                let credit = credits[i]
                if let creditDouble = Int(credit) {
                    currentGPA = currentGPA + (addingValueToGPA * Double(creditDouble))
                }
            }
        }
        currentGPA = currentGPA/totalGPAPoints
        return currentGPA
    }
    
    @IBAction func unwindFromIndividualClassViewController(segue: UIStoryboardSegue) {
        let source = segue.source as! IndividualClassViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            classes[selectedIndexPath.row] = source.oneClass
            grades[selectedIndexPath.row] = source.grade
            credits[selectedIndexPath.row] = source.credit
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: grades.count, section: 0)
            classes.append(source.oneClass)
            grades.append(source.grade)
            credits.append(source.credit)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            editBarButton.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            editBarButton.title = "Done"
        }
        if grades.isEmpty {
            gpaLabel.text = "0.000"
        }
    }
    
}
extension ClassesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath)
        cell.textLabel?.text = classes[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = grades[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            classes.remove(at: indexPath.row)
            grades.remove(at: indexPath.row)
            credits.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if grades.isEmpty {
                gpaLabel.text = "0.000"
            }
            updateGPA()
        }
        if grades.isEmpty {
            gpaLabel.text = "0.000"
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = classes[sourceIndexPath.row]
        classes.remove(at: sourceIndexPath.row)
        classes.insert(itemToMove, at: destinationIndexPath.row)
    }
}
