//
//  DDXDoctor.m
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import "DDXDoctor.h"


@interface DDXDoctor ()

@property (readwrite) NSString *doctorName;
@property (readwrite) NSString *doctorAddress;
@property (readwrite) CGFloat rate;
@property (readwrite) CLLocationCoordinate2D position;


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
    }
    return self;
    
}


- (NSComparisonResult)compareName:(DDXDoctor *)otherObject{
    
    return [self.doctorName compare:otherObject.doctorName];
    
}

- (NSComparisonResult)compareRate:(DDXDoctor *)otherObject{
    
    return [self.doctorName compare:otherObject.doctorName];
    
}
- (NSComparisonResult)compareDistance:(DDXDoctor *)otherObject{
    
    return [self.doctorName compare:otherObject.doctorName];
    
}

@end
