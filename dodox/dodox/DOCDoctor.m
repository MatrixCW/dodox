//
//  DDXDoctor.m
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DOCDoctor.h"
#import "DOCGlobalUtil.h"

@interface DOCDoctor ()

@property (readwrite) NSString *doctorName;
@property (readwrite) NSString *doctorAddress;
@property (readwrite) CGFloat rate;
@property (readwrite) CLLocationCoordinate2D position;
@property (readwrite) CGFloat distance;



@end


@implementation DOCDoctor


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


- (NSComparisonResult)compareName:(DOCDoctor *)otherObject{
    
    return [self.doctorName compare:otherObject.doctorName];
    
}

- (NSComparisonResult)compareRate:(DOCDoctor *)otherObject{
    
    return [[NSNumber numberWithDouble:self.rate] compare:[NSNumber numberWithDouble:otherObject.rate]];
    
}
- (NSComparisonResult)compareDistance:(DOCDoctor *)otherObject{
    
    return [[NSNumber numberWithDouble:self.distance] compare:[NSNumber numberWithDouble:otherObject.distance]];
    
}


-(void)calculateDistance{
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:sharedInstance.myCurrentPosotion.latitude
                                                  longitude:sharedInstance.myCurrentPosotion.longitude];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:self.position.latitude
                                                  longitude:self.position.longitude];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
    self.distance = distance;

    
}

@end
