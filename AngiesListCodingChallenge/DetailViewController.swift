//
//  DetailViewController.swift
//  AngiesListCodingChallenge
//
//  Created by Jack Hutchinson on 5/10/16.
//  Copyright © 2016 Helium Apps. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate
{

    @IBOutlet var mapView : MKMapView!
    @IBOutlet var providerNameLabel : UILabel!
    @IBOutlet var providerLocationLabel : UILabel!
    @IBOutlet var providerReviewCountLabel : UILabel!
    @IBOutlet var providerGradeLabel : UILabel!
    
    var provider : Provider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = provider.name
        
        self.providerNameLabel.text = self.provider.name
        self.providerLocationLabel.text = self.provider.location
        self.providerReviewCountLabel.text = "Reviews: \(provider.reviewCount)"
        self.providerGradeLabel.text = "Grade: \(provider.overallGrade)"
        
        // initialize the map
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let center = CLLocationCoordinate2DMake(self.provider.coordinates.coordinate.latitude, self.provider.coordinates.coordinate.longitude)
        let region = MKCoordinateRegionMake(center, span)
        self.mapView.setRegion(region, animated: false)
        self.mapView.addAnnotation(self.provider)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - MKMapViewDelegate
    
    func mapViewWillStartLocatingUser(mapView: MKMapView)
    {
    }
    
    func mapViewDidStopLocatingUser(mapView: MKMapView)
    {
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation)
    {
    }
    
    func mapView(mapView: MKMapView, didFailToLocateUserWithError error: NSError)
    {
    }
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool)
    {
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool)
    {
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        if annotation.dynamicType == MKUserLocation.self
        {
            return nil
        }
        else
        {
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView)
    {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
