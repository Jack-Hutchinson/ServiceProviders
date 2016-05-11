//
//  UIImage+Extensions.swift
//  AngiesListCodingChallenge
//
//  Created by Jack Hutchinson on 5/10/16.
//  Copyright © 2016 Helium Apps. All rights reserved.
//

import UIKit

extension UIImage
{
    class func imageFromText(text : String, bounds : CGRect, color : UIColor) -> UIImage
    {
        // return image of text with given background color.
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext()
        {
            CGContextSetFillColorWithColor(context, color.CGColor)
            CGContextFillRect(context, CGRectMake(0, 0, bounds.size.width, bounds.size.height))
        }
        let fontsize : CGFloat = text.characters.count > 1 ? 11.0 : 16.0
        let textAttributes : [String:AnyObject] = [
                        NSForegroundColorAttributeName: UIColor.whiteColor(),
                        NSFontAttributeName : UIFont.boldSystemFontOfSize(fontsize),
                    ]
        let textSize = text.sizeWithAttributes(textAttributes)
        text.drawInRect(CGRectMake(bounds.size.width / 2 - textSize.width / 2, bounds.size.height / 2 - textSize.height / 2, textSize.width, textSize.height), withAttributes: textAttributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}