//
//  DDXDoctor.m
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DDXDoctor.h"
#import "DDXGlobalUtil.h"

@interface DDXDoctor ()

@property (readwrite) NSString *doctorName;
@property (readwrite) NSString *doctorAddress;
@property (readwrite) CGFloat rate;
@property (readwrite) CLLocationCoordinate2D position;
@property (readwrite) CGFloat distance;



@end


@implementation DDXDoctor


-(id)initWithName:(NSString*)doctorName
          address:(NSString*)doctorAddress
       coordinate:(CLLocationCoordinate2D) position
          andRate:(CGFloat)rate{
    
    self = [super init];
    if (self) {
        self.doctorName = doctorName;
        self.doctorAddress = doctorAddress;
        self.position = position;
        self.rate = rate;
        
        [self calculateDistance];
    }
    return self;
    
}


- (NSComparisonResult)compareName:(DDXDoctor *)otherObject{
    
    return [self.doctorName compare:otherObject.doctorName];
    
}

- (NSComparisonResult)compareRate:(DDXDoctor *)otherObject{
    
    return [[NSNumber numberWithDouble:self.rate] compare:[NSNumber numberWithDouble:otherObject.rate]];
    
}
- (NSComparisonResult)compareDistance:(DDXDoctor *)otherObject{
    
    return [[NSNumber numberWithDouble:self.distance] compare:[NSNumber numberWithDouble:otherObject.distance]];
    
}


-(void)calculateDistance{
    
    DDXGlobalUtil *sharedInstance = [DDXGlobalUtil getSharedInstance];
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:sharedInstance.myCurrentPosotion.latitude
                                                  longitude:sharedInstance.myCurrentPosotion.longitude];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:self.position.latitude
                                                  longitude:self.position.longitude];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
    self.distance = distance;

    
}

@end
