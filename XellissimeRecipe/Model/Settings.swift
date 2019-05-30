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

 func imageResize( _ image:UIImage, withSize newSize:CGSize) -> UIImage {
    UIGraphicsBeginImageContext(newSize)
    image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!.withRenderingMode(.automatic)
}
