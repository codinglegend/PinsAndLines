//
//  ViewController.m
//  PinsAndLines
//
//  Created by Alain  on 2015-06-01.
//  Copyright (c) 2015 Alain . All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    bool initialLocationSet; // an instance variable (as opposed to a property)
}

@property (nonatomic) CLLocationManager* locationManager; //when you make this a property is when you have to call on it using self, as in instance variable you could have said locationManager without the self
@property (nonatomic) MKPolylineView *lineView;
@property (nonatomic) MKPolyline *polyline;
@property (nonatomic) CLLocationCoordinate2D destinationLocation;
@property (nonatomic) MKPointAnnotation *point;


@end

@implementation ViewController

//    CLLocationCoordinate2D *destinationLocation;
//    destinationLocation.CLLocationDegrees.latitude =




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    initialLocationSet = false;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.mapView.delegate = self; // because mapView is a property, we call self
    
    CLLocationDegrees lat = 49.215000;
    CLLocationDegrees lon = -123.108219;
    self.destinationLocation = CLLocationCoordinate2DMake(lat, lon);
    self.point = [MKPointAnnotation new];
    self.point.coordinate = self.destinationLocation;
    
//    MKAnnotationView *view = [[MKAnnotationView alloc] initWithAnnotation:self.point reuseIdentifier:nil];
    [self.mapView addAnnotation:self.point];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    return [[MKPinAnnotationView alloc] initWithAnnotation:self.point reuseIdentifier:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *location = [locations firstObject];
    
    if (!initialLocationSet){
        
        MKCoordinateRegion startingRegion;
        CLLocationCoordinate2D loc = location.coordinate;
        startingRegion.center = loc;
        startingRegion.span.latitudeDelta = 0.18;
        startingRegion.span.longitudeDelta = 0.18;
        [self.mapView setRegion:startingRegion]; //changed from startingRegion
        
        //This is still valid but won't zoom in
        //[self.mapView setCenterCoordinate:location.coordinate];
        initialLocationSet = true;
    
    }
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    //Here you would want to re-request startupdatinglocation
    // if given authorization
    //[_locationManager startUpdatingLocation];
    
}

// from pinkstone code
//- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
//    
//    return self.lineView;
//}



@end
