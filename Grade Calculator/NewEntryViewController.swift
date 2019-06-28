//
//  NewEntryViewController.swift
//  Grade Calculator
//
//  Created by Bijoy on 6/26/19.
//  Copyright © 2019 Bijoy Shah. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController {
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    var helpOptionsArray = ["What do I need on my final exam?", "What is my final grade?", "There are 2+ parts in my final. What do I have to get on each part?", "Not including my final, the lowest test grade is dropped. What do I need on my final?"]
    
    var classNames: String!
    var currentDates: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        formulaPicker.delegate = self
        //        formulaPicker.dataSource = self
        //        conversionString = helpOptionsArray[formulaPicker.selectedRow(inComponent: 0)]
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.lightGray.cgColor, UIColor.gray.cgColor, UIColor.blue.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.barTintColor = UIColor.lightGray
        self.navigationController!.toolbar.barTintColor = UIColor.blue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewEntryNext" {
            let destination = segue.destination as! FinalCalculatorViewController
            destination.className = classNameTextField.text
            destination.currentDate = dateTextField.text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.isHidden = false
        super.viewWillAppear(animated)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode { // modal segue
            dismiss(animated: true, completion: nil)
        } else { // show segue
            navigationController!.popViewController(animated: true)
        }
    }
    
    @IBAction func nextToolbarButtonPressed(_ sender: UIBarButtonItem) {
        if classNameTextField.text!.isEmpty || dateTextField.text!.isEmpty {
            showAlert(title: "Invalid Input", message: "Please fill out all fields.")
        } else {
            performSegue(withIdentifier: "NewEntryNext", sender: nil)
        }
    }
}

