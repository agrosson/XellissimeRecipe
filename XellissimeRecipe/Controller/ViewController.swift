//
//  ViewController.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 27/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit
import Alamofire




class ViewController: UIViewController {

    // MARK: - Outlets - Label
    @IBOutlet weak var introLabel: UILabel!
    // MARK: - Outlets - TextField and TextView
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var listOfIngredientsTextView: UITextView!
    // MARK: - Outlets - Buttons
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the navigationBar transparent
        //navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        setUpPage()
        gestureTapCreation()
        listOfIngredientsTextView.isEditable = false
        let url = "https://api.edamam.com/search?q=chicken&app_id=7ba6f788&app_key=58fb0a71d4b3042d003fa99123a86f75"
        
        Alamofire.request(url).responseJSON { (response) in
            if let myResponse = response.result.value as? [String : Any] {
                print(myResponse["count"] as Any)
            }
            print("rr")
          
        // Do any additional setup after loading the view.
    }
}
    // MARK: - Actions
    
    @IBAction func addButtonIsPressed(_ sender: UIButton) {
    }
    @IBAction func clearButtonIsPressed(_ sender: UIButton) {
    }
    @IBAction func searchButtonIsPressed(_ sender: UIButton) {
    }
    
    // MARK: - Methods
    /**
     Function that manages TextField
     */
    private func manageTextField() {
        ingredientsTextField.delegate = self
    }
    /**
     Function that customizes login page
     */
    private func setUpPage() {
        ingredientsTextField.layer.cornerRadius = 15
        
        AddButton.layer.borderWidth = 3
        AddButton.layer.cornerRadius = 15
        AddButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        clearButton.layer.borderWidth = 3
        clearButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        clearButton.layer.cornerRadius = 15
        searchButton.layer.borderWidth = 3
        searchButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchButton.layer.cornerRadius = 15
        listOfIngredientsTextView.layer.cornerRadius = 15
        listOfIngredientsTextView.layer.borderColor = #colorLiteral(red: 0.2116547525, green: 0.6101396084, blue: 0.4648743272, alpha: 1)
        listOfIngredientsTextView.layer.borderWidth = 3
        ingredientsTextField.layer.borderColor = #colorLiteral(red: 0.2116547525, green: 0.6101396084, blue: 0.4648743272, alpha: 1)
        ingredientsTextField.layer.borderWidth = 3
     
 
        
        gestureTapCreation()
        gestureswipeCreation()
    }
    /**
     Function that creates a tap gesture
     */
    private func gestureTapCreation() {
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTap
            ))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(mytapGestureRecognizer)
    }
    /**
     Function that creates a swipe gesture
     */
    private func gestureswipeCreation() {
        let mySwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(myTap
            ))
        mySwipeGestureRecognizer.direction = .down
        self.view.addGestureRecognizer(mySwipeGestureRecognizer)
    }
    /**
     Function that defines a swipe and tap gesture action
     */
    @objc private func myTap() {
       ingredientsTextField.resignFirstResponder()
    }
}

// MARK: - Extension
extension ViewController: UITextFieldDelegate {
    // definition of delegate functions for UITexfields
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
