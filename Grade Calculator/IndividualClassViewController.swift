//
//  IndividualClassViewController.swift
//  Grade Calculator
//
//  Created by Bijoy on 6/25/19.
//  Copyright © 2019 Bijoy Shah. All rights reserved.
//

import UIKit

class IndividualClassViewController: UIViewController {
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var finalGradeTextField: UITextField!
    @IBOutlet weak var numberOfCreditsTextField: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    var oneClass: String!
    var grade: String!
    var credit: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if oneClass == nil {
            oneClass = ""
            grade = ""
            credit = ""
        }
        
        classNameTextField.text = oneClass
        finalGradeTextField.text = grade
        numberOfCreditsTextField.text = credit
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.lightGray.cgColor, UIColor.gray.cgColor, UIColor.blue.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.barTintColor = UIColor.lightGray
        self.navigationController!.toolbar.barTintColor = UIColor.blue
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromSave" {
            oneClass = classNameTextField.text
            grade = finalGradeTextField.text
            credit = numberOfCreditsTextField.text
        }
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
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if classNameTextField.text!.isEmpty || finalGradeTextField.text!.isEmpty || numberOfCreditsTextField.text!.isEmpty {
            showAlert(title: "Invalid Input", message: "Please fill out all fields appropriately.")
        }
        
    }
    
}
