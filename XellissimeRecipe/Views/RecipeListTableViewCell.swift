//
//  RecipeListTableViewCell.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 29/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class RecipeListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var nameRecipe: UILabel!
    @IBOutlet weak var timeRecipe: UILabel!
    @IBOutlet weak var ingredientsRecipe: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
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
            imageRecipe.image = imageResize(myImage, withSize: mySize)
        } else {
            guard let basicImage = UIImage(named: "straw") else {return}
            imageRecipe.image = basicImage
        }
        nameRecipe.textColor = .white
        timeRecipe.textColor = .black
        ingredientsRecipe.textColor = .white
        nameRecipe.text = name
        if  time == 0 {
            timeRecipe.text = "No time indication"
        } else {
            timeRecipe.text = "Cooking time: \(time) minutes"
        }
        var text = ""
        for item in ingredients {
            text += "\(item)\n"
        }
        ingredientsRecipe.text = text
        
        print("c'est ici que je cherche à voir "+text)
    }
}
