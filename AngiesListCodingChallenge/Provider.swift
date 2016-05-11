//
//  Provider.swift
//  AngiesListCodingChallenge
//
//  Created by Jack Hutchinson on 5/10/16.
//  Copyright © 2016 Helium Apps. All rights reserved.
//

import Foundation
import MapKit

@objc class Provider : NSObject, MKAnnotation
{
    let name : String
    let city : String
    let state : String
    let postalCode : String
    let coordinates : CLLocation
    let reviewCount : Int
    let overallGrade : String
    
    var coordinate: CLLocationCoordinate2D {
        return self.coordinates.coordinate
    }
    var title : String? {
        return self.name
    }
    
    init(dictionary : [String:AnyObject])
    {
        self.name = dictionary["name"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.state = dictionary["state"] as? String ?? ""
        self.postalCode = dictionary["postalCode"] as? String ?? ""
        self.reviewCount = dictionary["reviewCount"] as? Int ?? 0
        self.overallGrade = dictionary["overallGrade"] as? String ?? ""
        
        var location = CLLocation()
        if let coordinates = dictionary["coordinates"] as? [String:AnyObject]
        {
            if let latitude = coordinates["latitude"] as? NSString, longitude = coordinates["longitude"] as? NSString
            {
                location = CLLocation(latitude: latitude.doubleValue, longitude: longitude.doubleValue)
            }
        }
        self.coordinates = location
        
    }
    
    var location : String {
        return "\(self.city), \(self.state) \(self.postalCode)"
    }
    
    var badgeColor : UIColor {
        switch self.overallGrade
        {
            case "A":
            return UIColor(red: 36/255.0, green: 149/255.0, blue: 44/255.0, alpha: 1.0)
        default:
            return UIColor.lightGrayColor()
        }
    }
}