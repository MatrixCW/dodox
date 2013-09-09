//
//  DDXDoctor.h
//  dodox
//
//  Created by Enravi on 8/9/13.
//  Copyright (c) 2013 Cui Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DOCDoctor : NSObject

@property (readonly) int identity;
@property (readonly) NSString *doctorName;
@property (readonly) NSString *doctorAddress;
@property (readonly) CGFloat rate;
@property (readonly) CGFloat distance;
@property (readonly) CLLocationCoordinate2D position;

@property UIImage *doctorAvatar;

-(id)initWithName:(NSString*)doctorName
          address:(NSString*)doctorAddress
       coordinate:(CLLocationCoordinate2D) position
          andRate:(CGFloat)rate;

- (NSComparisonResult)compareName:(DOCDoctor *)otherObject;
- (NSComparisonResult)compareRate:(DOCDoctor *)otherObject;
- (NSComparisonResult)compareDistance:(DOCDoctor *)otherObject;


@end