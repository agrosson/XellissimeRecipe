//
//  FavoriteTableViewCell.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 30/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeCookingTime: UILabel!
    @IBOutlet weak var recipeIngredient: UILabel!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withImage: String, name: String, time: Int, ingredients: [String]) {
        var imageToGet : UIImage?
        let url = URL(string: withImage )
        let data = try? Data(contentsOf: url!)
        imageToGet = UIImage(data: data!)
        let mySize = CGSize(width: 100, height: 100)
        if let myImage = imageToGet {
            recipeImage.image = imageResize(myImage, withSize: mySize)
        } else {
            guard let basicImage = UIImage(named: "straw") else {return}
            recipeImage.image = basicImage
        }
        recipeName.textColor = .white
        recipeCookingTime.textColor = .black
        recipeIngredient.textColor = .white
        recipeName.text = name
        if  time == 0 {
            recipeCookingTime.text = "No time indication"
        } else {
            recipeCookingTime.text = "Cooking time: \(time) minutes"
        }
        var text = ""
        for item in ingredients {
            text += "\(item)\n"
        }
        recipeIngredient.text = text
    }
}
