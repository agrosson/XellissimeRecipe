//
//  ViewController.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 28/05/2019.
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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var listOfIngredientsArray = [String]()
 //   var testListRecipe = [MyRecipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        setUpPage()
        listOfIngredientsTextView.isEditable = false
    }
    // MARK: - Actions
    
    @IBAction func addButtonIsPressed(_ sender: UIButton) {
        addAction()
    }
    @IBAction func clearButtonIsPressed(_ sender: UIButton) {
        listOfIngredientsTextView.text = "Your ingredients:"
        listOfIngredientsArray = [String]()
    }
    @IBAction func searchButtonIsPressed(_ sender: UIButton) {
        toggleActivityIndicator(shown: true)
        if listOfIngredientsArray.count == 0 {
            Alert.shared.controller = self
            Alert.shared.alertDisplay = .emptyListOfIngredient
            self.toggleActivityIndicator(shown: false)
        } else {
            NetworkingClient.shared.search(with: listOfIngredientsArray){ (success, returnlistOfRecipes) in
                self.toggleActivityIndicator(shown: false)
                if returnlistOfRecipes != nil {
                    print("on est là avec \(listOfRecipes.count) recettes")
                    guard listOfRecipes.count != 0 else {
                        Alert.shared.controller = self
                        Alert.shared.alertDisplay = .noRecipe
                        self.toggleActivityIndicator(shown: false)
                        return
                    }
                    self.performSegue(withIdentifier: "goList", sender: self)
                } else {
                    Alert.shared.controller = self
                    Alert.shared.alertDisplay = .requestCrash
                }
            }
        }
    }
    
    // MARK: - Methods
    /**
     Function to show/hide activity indicator
     */
    private func toggleActivityIndicator(shown: Bool){
        activityIndicator.isHidden = !shown
        searchButton.isHidden = shown
    }
    /**
     Function to show/hide activity indicator
     */
    private func addAction(){
        guard var ingredient = ingredientsTextField.text else {return}
        ingredient.removeFirstAndLastAndDoubleWhitespace()
        if ingredient == "" {
            Alert.shared.controller = self
            Alert.shared.alertDisplay = .noIngredientToAdd
            self.toggleActivityIndicator(shown: false)
        } else {
            listOfIngredientsArray.append(ingredient)
            let newLine = "- \(ingredient.capitalized)"
            listOfIngredientsTextView.text += "\n\t\(newLine)"
        }
        ingredientsTextField.text = ""
        print(listOfIngredientsArray)
    }
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
        manageTextField()
        clearButton.setTitle(" Clear ", for: .normal)
        
        let wid = clearButton.intrinsicContentSize.width
        clearButton.widthAnchor.constraint(equalToConstant: wid).isActive = true
        AddButton.widthAnchor.constraint(equalToConstant: wid).isActive = true
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
        addAction()
        ingredientsTextField.resignFirstResponder()
        return true
    }
}
