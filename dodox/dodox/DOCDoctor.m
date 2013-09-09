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

@property (readwrite) int doctorID;
@property (readwrite) NSString *doctorName;
@property (readwrite) NSString *doctorAddress;
@property (readwrite) CGFloat doctorRate;
@property (readwrite) CGFloat distance;
@property (readwrite) CLLocationCoordinate2D doctorPosition;
@property (readwrite) NSString *doctorPhoneNumber;
@property (readwrite) NSDictionary *doctorDescription;
@property (readwrite) NSDictionary *doctorPictureURLs;
@end


@implementation DOCDoctor


-(id)initWithIdentity:(int)doctorID
                 Name:(NSString*)doctorName
              address:(NSString*)doctorAddress
                 rate:(CGFloat)rate
             position:(CLLocationCoordinate2D) position
                phone:(NSString*) phoneNumber
          description:(NSDictionary*)description
       andPictureURLs:(NSDictionary*)pictureURLs{
    
    self = [super init];
    
    if (self) {
        self.doctorID = doctorID;
        self.doctorName = doctorName;
        self.doctorAddress = doctorAddress;
        self.doctorRate = rate;
        self.doctorPosition = position;
        self.doctorPhoneNumber = phoneNumber;
        self.doctorDescription = [NSDictionary dictionaryWithDictionary:description];
        self.doctorPictureURLs = [NSDictionary dictionaryWithDictionary:pictureURLs];
        
        
        [self calculateDistance];
    }
    return self;
    
}


- (NSComparisonResult)compareName:(DOCDoctor *)otherObject{
    
    return [self.doctorName compare:otherObject.doctorName];
    
}

- (NSComparisonResult)compareRate:(DOCDoctor *)otherObject{
    
    return [[NSNumber numberWithDouble:self.doctorRate] compare:[NSNumber numberWithDouble:otherObject.doctorRate]];
    
}
- (NSComparisonResult)compareDistance:(DOCDoctor *)otherObject{
    
    return [[NSNumber numberWithDouble:self.distance] compare:[NSNumber numberWithDouble:otherObject.distance]];
    
}


-(void)calculateDistance{
    
    DOCGlobalUtil *sharedInstance = [DOCGlobalUtil getSharedInstance];
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:sharedInstance.myCurrentPosotion.latitude
                                                  longitude:sharedInstance.myCurrentPosotion.longitude];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:self.doctorPosition.latitude
                                                  longitude:self.doctorPosition.longitude];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
    self.distance = distance;

    
}

@end
