//
//  ServiceCall.swift
//  AngiesListCodingChallenge
//
//  Created by Jack Hutchinson on 5/10/16.
//  Copyright © 2016 Helium Apps. All rights reserved.
//

import Foundation

@objc class ServiceCall : NSObject
{
    let urlString = "http://private-895ba-angieslistcodingchallenge.apiary-mock.com/angieslist/codingChallenge/serviceproviders"
    
    func getServiceProviders(completion : (providers : [Provider]?, error : NSError?)->())
    {
        if let url = NSURL(string: urlString)
        {
            let session = NSURLSession.sharedSession()
            session.dataTaskWithURL(url){ data, response, error in
                if let error = error
                {
                    print("get service providers \(error.localizedDescription)")
                }
                if let data = data
                {
                    do
                    {
                        if let object = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String:AnyObject]
                        {
                            if let providers = object["serviceproviders"] as? [[String:AnyObject]]
                            {
                                var serviceProviders = [Provider]()
                                for provider in providers
                                {
                                    serviceProviders.append(Provider(dictionary: provider))
                                }
                                completion(providers: serviceProviders, error: nil)
                            }
                        }
                    }
                    catch let error as NSError
                    {
                        completion(providers: nil, error: error)
                    }
                }
                
            }.resume()
        }
        else
        {
            print("could not resolve string to NSURL")
            completion(providers: nil, error: nil)
        }
    }
}