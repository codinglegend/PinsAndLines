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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    initialLocationSet = false;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    

    
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
        startingRegion.span.latitudeDelta = 0.02;
        startingRegion.span.longitudeDelta = 0.02;
        [self.mapView setRegion:startingRegion];
        
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

@end
