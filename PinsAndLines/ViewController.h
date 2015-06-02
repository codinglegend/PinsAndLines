//
//  ViewController.h
//  PinsAndLines
//
//  Created by Alain  on 2015-06-01.
//  Copyright (c) 2015 Alain . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

