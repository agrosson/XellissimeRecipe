//
//  Alert.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 30/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Class Alert
/**
 This class enables presentation of an alert what ever the viewController
 */
class Alert {
    // MARK: - Properties
    /// ViewController on which the alert will be displayed (self)
    var controller: UIViewController?
    /// Variable that tracks the case of alert
    var alertDisplay: AlertCase = .emptyListOfIngredient {
        didSet {
            presentAlert(alertCase: alertDisplay)
        }
    }
    /// Singleton Object
    static var shared = Alert()
    // MARK: - Enum
    /// Enum that lists all cases of alert presentations
    enum AlertCase {
        case emptyListOfIngredient, noIngredientToAdd, requestCrash, noRecipe, noFavorites
    }
    // MARK: -
    init() {}
    // MARK: - Methods
    /**
     Function that presents an alert with defined text depending on AlertCase
     - Parameter alertCase: variable used to set text of the alert
     */
    private func presentAlert(alertCase: AlertCase) {
        switch alertCase {
        case .emptyListOfIngredient: controller?.presentAlertDetails(
            title: "Sorry",
            message: "No ingredient in the list.\nPlease enter at least one ingredient",
            titleButton: "OK")
        case .noIngredientToAdd: controller?.presentAlertDetails(
            title: "Sorry",
            message: "No ingredient to add.\nPlease enter at least one ingredient",
            titleButton: "OK")
        case .requestCrash: controller?.presentAlertDetails(
            title: "Sorry",
            message: "Request has failed.\nPlease try with new ingredients",
            titleButton: "OK")
        case .noRecipe: controller?.presentAlertDetails(
            title: "Sorry",
            message: "No recipe found.\nPlease try with new ingredients",
            titleButton: "OK")
        case .noFavorites: controller?.presentAlertDetails(
            title: "Sorry",
            message: "No Favorites.\nYou can search and add recipes by clicking on forks",
            titleButton: "OK")
        }
    }
}
// MARK: - Extension
extension UIViewController {
    /**
     Function that presents an alert
     */
    func presentAlertDetails(title: String, message: String, titleButton: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: titleButton, style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
