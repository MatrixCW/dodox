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

@property  int doctorID;
@property  NSString *doctorName;
@property  NSString *doctorSpeciality;
@property  NSString *subCategory;
@property  NSString *clinicName;
@property  NSString *doctorAddress;
@property  CGFloat doctorRate;
@property  CGFloat distance;
@property  NSString *doctorPhoneNumber;
@property  NSString *postCode;

@property NSArray *timeSlots;

@property  NSDictionary *doctorAvatars;
@property  NSDictionary *doctorDescription;


- (NSComparisonResult)compareName:(DOCDoctor *)otherObject;
- (NSComparisonResult)compareRate:(DOCDoctor *)otherObject;
- (NSComparisonResult)compareDistance:(DOCDoctor *)otherObject;


-(void)parseTime;


@end