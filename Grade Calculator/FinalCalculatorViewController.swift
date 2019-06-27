//
//  FinalCalculatorViewController.swift
//  Grade Calculator
//
//  Created by Bijoy on 6/26/19.
//  Copyright © 2019 Bijoy Shah. All rights reserved.
//

import UIKit

class FinalCalculatorViewController: UIViewController {
    @IBOutlet weak var currentGradeTextField: UITextField!
    @IBOutlet weak var desiredClassGradeTextField: UITextField!
    @IBOutlet weak var wieghtOfFinalTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var currentClassLabel: UILabel!
    
    
    var currentGrade = 0.00
    var desiredGrade = 0.00
    var weightOfFinal = 0.00
    var className = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.lightGray.cgColor, UIColor.gray.cgColor, UIColor.blue.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.barTintColor = UIColor.lightGray
        self.navigationController!.toolbar.barTintColor = UIColor.blue
        
        resultLabel.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromSaveToHistory" {
            if let currentGradeTemp = Double(currentGradeTextField.text!) {
                currentGrade = currentGradeTemp
            }
            if let desiredGradeTemp = Double(desiredClassGradeTextField.text!) {
                desiredGrade = desiredGradeTemp
            }
            if let weightOfFinalTemp = Double(wieghtOfFinalTextField.text!) {
                weightOfFinal = weightOfFinalTemp
            }
            className = currentClassLabel.text!
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentClassLabel.text = className
    }
    
    func whatDoINeedOnMyFinal() -> Double{
        var weightOfRestOfClass = (100.00 - Double(weightOfFinal))/100.00
        currentGrade = Double(currentGrade) * weightOfRestOfClass
        var desiredGradeCalculation = desiredGrade - currentGrade
        desiredGradeCalculation = (desiredGradeCalculation / weightOfFinal) * 100
        return desiredGradeCalculation
    }
    
    @IBAction func  unwindFromNewEntryViewController(segue: UIStoryboardSegue) {
        let source = segue.source as! NewEntryViewController
        className = source.classNames
        currentClassLabel.text = className
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode { // modal segue
            dismiss(animated: true, completion: nil)
        } else { // show segue
            navigationController!.popViewController(animated: true)
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        if let currentGradeTemp = Double(currentGradeTextField.text!) {
            currentGrade = currentGradeTemp
        }
        if let desiredGradeTemp = Double(desiredClassGradeTextField.text!) {
            desiredGrade = desiredGradeTemp
        }
        if let weightOfFinalTemp = Double(wieghtOfFinalTextField.text!) {
            weightOfFinal = weightOfFinalTemp
        }
        className = currentClassLabel.text!
        resultLabel.text = "You need a \(String(format:"%.02f",whatDoINeedOnMyFinal()))% on your final exam to get a \(desiredGrade)% in \(className). Good luck!"
    }
    
    @IBAction func historyButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ShowHistory", sender: nil)
    }
}
