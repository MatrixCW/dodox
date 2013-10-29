//
//  DDXGlobalUtil.m
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCGlobalUtil.h"
#import "Reachability.h"
#import <CoreLocation/CoreLocation.h>

@interface DOCGlobalUtil ()

@property Reachability *internetReachableDetector;
@property CLLocationManager *locationManager;
@property (readwrite) CLLocationCoordinate2D myCurrentPosotion;

@end

@implementation DOCGlobalUtil

static DOCGlobalUtil *sharedInstance;


+(id)getSharedInstance{
    
    if(sharedInstance == NULL){
        
        sharedInstance = [[DOCGlobalUtil alloc] init];
        sharedInstance.firstTimeLaunch = YES;
        
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

-(void)storeSpecialities:(NSArray*)inputArray{
    self.storedSpecialities = [NSArray arrayWithArray:inputArray];
}


@end
