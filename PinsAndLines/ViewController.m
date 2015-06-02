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
@property (nonatomic) MKPointAnnotation *point2;
@property (nonatomic) MKPolyline *line;
//@property (nonatomic, assign) CLLocationCoordinate2D* points; // when it is not an object, add assign to make it more clear. also, an NSArray only contains objects (can't contain int, it would be an object...like NSNumber) so

@property (nonatomic, strong) NSMutableArray* mutableArray;
@end

@implementation ViewController

//    CLLocationCoordinate2D *destinationLocation;
//    destinationLocation.CLLocationDegrees.latitude =




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    initialLocationSet = false;
//    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.mapView.delegate = self; // because mapView is a property, we call self
    
// making pin #1
 
// terrible way to do it:
//    CLLocationDegrees lat = 49.215000;
//    CLLocationDegrees lon = -123.108219;
//    self.destinationLocation = CLLocationCoordinate2DMake(lat, lon);
    self.destinationLocation = CLLocationCoordinate2DMake(49.215000, -123.108219);
    self.point = [MKPointAnnotation new];
    self.point.coordinate = self.destinationLocation;
    
    [self.mapView addAnnotation:self.point];
    
// making pin #2
    
    CLLocationCoordinate2D startingLocation = CLLocationCoordinate2DMake(49.20000, -123.09);
    self.point2 = [MKPointAnnotation new];
    self.point2.coordinate = startingLocation;
    [self.mapView addAnnotation:self.point2];
    
    CLLocationCoordinate2D ps[2] = {self.destinationLocation, startingLocation}; //no self dot for starting location since we did not make it a property
    
    self.line = [MKPolyline polylineWithCoordinates:ps count:2]; //remove [] on the array name
    
    [self.mapView addOverlay:self.line];
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) { // how to ask if something is of a certain class
        
        MKPinAnnotationView *pinViewStart = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
        
        [pinViewStart setPinColor:MKPinAnnotationColorGreen];
        
        return pinViewStart;
//        return nil; if you want the blue dot
    }
    
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    
    
//    NSLog(@"MapView is asking for a view for %@", annotation);
//
//    if (NO) {
//        [pinView setPinColor:MKPinAnnotationColorRed];
//    }
    
    
    return pinView;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay{
    
    MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithPolyline:self.line];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 5.0;
    
    return renderer;
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
    
    // here is where you want to save the user's location
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    //Here you would want to re-request startupdatinglocation
    // if given authorization
    //[_locationManager startUpdatingLocation];
    
}





@end
