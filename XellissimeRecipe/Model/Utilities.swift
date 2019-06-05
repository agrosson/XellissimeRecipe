//
//  Settings.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 27/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

// Credit Photo by Brooke Lark on Unsplash
// Photo by Dan Gold on Unsplash

/**
 This function enables to resize an image
 - Parameter image: the image to resize
 - Parameter newSize: the new size to set to the image
 - Returns: image resized
 */
func imageResize( _ image:UIImage, withSize newSize:CGSize) -> UIImage {
    UIGraphicsBeginImageContext(newSize)
    image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!.withRenderingMode(.automatic)
}

/**
 This extension enables to remove inaccurate whitespace
 */
extension String {
    mutating func removeFirstAndLastAndDoubleWhitespace() {
        var newString = self
        repeat {
            if newString.last == " " || newString.last == "\""{
                newString = String(newString.dropLast())
            }
            if newString.first == " " || newString.first == "\""{
                newString = String(newString.dropFirst())
            }
        }
            while newString.first == " " || newString.last == " " || newString.last == "\"" || newString.first == "\""
        repeat { newString = newString.replacingOccurrences(of: "  ", with: " ")
        } while newString.contains("  ")
        self =  newString
    }
}
