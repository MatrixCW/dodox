//
//  DDXGlobalUtil.m
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DDXGlobalUtil.h"
#import "Reachability.h"
#import <CoreLocation/CoreLocation.h>

@interface DDXGlobalUtil ()

@property Reachability *internetReachableDetector;
@property CLLocationManager *locationManager;
@property (readwrite) CLLocationCoordinate2D myCurrentPosotion;
@property (readwrite) NSString *currentSelectedSpeciality;

@end

@implementation DDXGlobalUtil

static DDXGlobalUtil *sharedInstance;


+(id)getSharedInstance{
    
    if(sharedInstance == NULL){
        sharedInstance = [[DDXGlobalUtil alloc] init];
    }
    
    return sharedInstance;
    
}

-(BOOL)isNetworkActive{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    return !(networkStatus == NotReachable);
    
}

-(void)alertNoNetwork{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops, cannot connect to Internet"
                                                    message:@"To use this app, you need Internet Connection"
                                                   delegate:Nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


- (NSString *)findMyCurrentLocation{
    
    if(!self.locationManager){
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        [self.locationManager startUpdatingLocation];
    }
    
    self.myCurrentPosotion = self.locationManager.location.coordinate;
    
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}


-(void)saveSpeciality:(NSString*)speciality{
    
    self.currentSelectedSpeciality = speciality;
    
}

@end
